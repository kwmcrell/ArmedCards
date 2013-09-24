<#
.SYNOPSIS
Combine multiple text based files into a single file.

.DESCRIPTION
Combine-Files.ps1 is a flexible script for combining multiple text based files into a single file.
Source files can be filtered by name or by modified date and files can also be appended to an existing file.
The script can be used on its own or as part of a larger build script for combining *.sql, *.js or *.csv files. 

.EXAMPLE
.\Combine-Files.ps1 -output "Combined-Files.txt" -source "D:\MyScripts\" -filter "*.txt" -modifiedAfter "2011-11-11 11:11" -append -recurse -separator
	
.NOTES
Author:		Declan Bright
	
.LINK
http://www.declanbright.com/powershell-script-combine-files.php
#>

param(
    # The path (relative or absolute) of the output file
    [string]$output = "Combined-Files.txt", 
    
    # The path (relative or absolute) of the source file or files
    [string]$source = ".", 
    
    # The filter to be applied to the source when retrieving files 
    [string]$filter = "*.txt", 
    
    # Only retrieve files which have been modified after this datetime
    [string]$modifiedAfter = "1900-01-01 00:00:00",
    
    # Only retrieve files which have been modified before this datetime
    [string]$modifiedBefore = "2099-12-30 23:59:59",
    
    # Switch to append files to an existing output file
    [switch]$append, 
    
    # Switch to retrieve files recursively from child folders
    [switch]$recurse, 
    
    # Switch to put a separator between each file which includes the file path
    [switch]$separator 
)

# Check the path of the source files
if (!(Test-Path -path $source)) {
    Write-Host "`n`n  ERROR: Path ""$source"" is invalid`n"
    break
}

# Check the modifiedAfter date
if (($modifiedAfter -as [DateTime]) -ne $null) {
    $modifiedAfterDate = [DateTime]::Parse($modifiedAfter)
} else {
    Write-Host "`n`n  ERROR: -modifiedAfter date ""$modifiedAfter"" is invalid`n"
    break
}

# Check the modifiedBefore date
if (($modifiedBefore -as [DateTime]) -ne $null) {
    $modifiedBeforeDate = [DateTime]::Parse($modifiedBefore)
} else {
    Write-Host "`n`n  ERROR: -modifiedBefore date ""$modifiedBefore"" is invalid`n"
    break
}

# Setup new file if not appending or if appending and it does not already exist
if ((!$append) -or (($append) -and (!(Test-Path -path $output)))) {
    Write-Host "`n + Setting up output file:" $output "`n"
    New-Item -ItemType file $output -force | Out-Null
}

# Get the files from the path, recursively if required
if ($recurse) {   
    $files = Get-ChildItem $source -filter $filter -recurse
}
else {
    $files = Get-ChildItem $source -filter $filter
}
# Exclude folder objects
$files = $files | Where-Object { $_.PSIsContainer -ne $true }
# Exclude the output file
$files = $files | Where-Object { $_.Name -ne $output }
# Only get files modified after the modifiedAfter datetime
$files = $files | Where-Object { $_.LastWriteTime -gt $modifiedAfterDate }
# Only get files modified before the modifiedBefore datetime
$files = $files | Where-Object { $_.LastWriteTime -lt $modifiedBeforeDate }
       
# Add the content of each file to the output file
foreach ($fileInfo in $files) {
    if($fileInfo) {
        Write-Host " +"$fileInfo.FullName
        
        # Add a file path separator to the file
        if($separator) {
            Add-Content $output ("/* " + [string]$fileInfo.FullName + " */`n")
        }
        
        # Add the file content of the output file
        Add-Content $output (Get-Content $fileInfo.FullName) 
        
        # Add a line break to the end        
        if($separator) {
            Add-Content $output "`n"
        }
    }
}

Write-Host "`n"
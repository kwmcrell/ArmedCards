/*
* Copyright (c) 2013, Kevin McRell & Paul Miller
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are permitted
* provided that the following conditions are met:
* 
* * Redistributions of source code must retain the above copyright notice, this list of conditions
*   and the following disclaimer.
* * Redistributions in binary form must reproduce the above copyright notice, this list of
*   conditions and the following disclaimer in the documentation and/or other materials provided
*   with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
* WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

IF OBJECT_ID('[dbo].[ActiveConnection_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_Select]
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new User
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_Select]
	@GroupName				varchar(255)			  =	NULL,
	@ExcludeUserIds			XML						  = NULL,
	@ConnectionType			INT						  = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

     SELECT AC.[ActiveConnectionID],
			AC.[GroupName],
			AC.[User_UserId],
			AC.[ConnectionType],
			UP.[UserName]
	 FROM [dbo].[ActiveConnection] AC
	 INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = AC.[User_UserId]
	 WHERE (AC.[GroupName] = @GroupName OR @GroupName IS NULL)
	 AND   (@ExcludeUserIds IS NULL OR UP.UserId NOT IN (SELECT ids.id.value('@value', 'int')
														 FROM	@ExcludeUserIds.nodes('ids/id') AS ids ( id )))
	AND (AC.[ConnectionType] = @ConnectionType OR @ConnectionType IS NULL)

	COMMIT

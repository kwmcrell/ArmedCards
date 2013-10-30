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

IF OBJECT_ID('[dbo].[LeaderboardPointScale]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[LeaderboardPointScale](
		[LeaderboardPointScaleID]	[int] IDENTITY(1,1) NOT NULL,
		[Name]						[varchar](255) NOT NULL,
		[Value]						[int] NOT NULL,
	 CONSTRAINT [PK_dbo.LeaderboardPointScale] PRIMARY KEY CLUSTERED 
	(
		[LeaderboardPointScaleID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS (	SELECT LPS.LeaderboardPointScaleID
			FROM dbo.LeaderboardPointScale LPS
			WHERE LPS.[LeaderboardPointScaleID] = 1
		  )
	BEGIN
		INSERT INTO dbo.LeaderboardPointScale
		(
			Name,
			Value
		)
				SELECT 'Won Round',				5
		UNION	SELECT 'Won Game',				15
		UNION	SELECT 'Card Votes',			5
		UNION	SELECT 'Card Selected For Deck',100 
	END
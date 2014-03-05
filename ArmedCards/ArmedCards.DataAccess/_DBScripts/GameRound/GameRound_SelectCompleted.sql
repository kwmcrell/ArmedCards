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

IF OBJECT_ID('[dbo].[GameRound_SelectCompleted]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_SelectCompleted] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 3/2/2014
-- Description:	Selects completed rounds based on game id
-- ===============================================
CREATE PROC [dbo].[GameRound_SelectCompleted] 
	@GameID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT DISTINCT	GR.[GameRoundID],
					GR.[Started],
					GR.[Game_GameID],
					UP.[UserId],
					UP.[UserName]
	FROM [dbo].[GameRound] GR
	INNER JOIN [dbo].[GameRoundCard] GRC ON GRC.[GameRound_GameRoundID] = GR.[GameRoundID] 
										AND GRC.[Winner] = 1
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = GRC.[PlayedBy_UserId]
	WHERE GR.[Game_GameID] = @GameID
	ORDER BY GR.[GameRoundID] DESC

	COMMIT
GO
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

IF OBJECT_ID('[dbo].[Game_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Game_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new User
-- ===============================================
CREATE PROC [dbo].[Game_Select]
	@GameID			int			  =	NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

    SELECT	G.[GameID],
			G.[Title],
			G.[IsPrivate],
			G.[Passphrase],
			G.[PointsToWin],
			G.[MaxNumberOfPlayers],
			G.[GameCreator_UserId],
			G.[DateCreated],
			G.[PlayedLast],
			G.[GameOver],
			G.[AnswerShuffleCount],
			G.[QuestionShuffleCount],
			G.[SecondsToPlay],
			(SELECT COUNT(UserID) 
			 FROM [dbo].[GamePlayer] GP
			 WHERE GP.[GameID] = G.[GameID]
			 AND   GP.[Type] = 1
			 AND   GP.[Status] > 0) AS PlayerCount,
			(SELECT COUNT([Game_GameID]) 
			 FROM [dbo].[GameRound] GR
			 WHERE GR.[Game_GameID] = G.[GameID]) AS RoundCount,
			G.MaxNumberOfSpectators,
			(SELECT COUNT(UserID) 
			 FROM [dbo].[GamePlayer] GP
			 WHERE GP.[GameID] = G.[GameID]
			 AND   GP.[Type] = 2
			 AND   GP.[Status] > 0) AS SpectatorCount,
			 G.[IsPersistent]
	 FROM [dbo].[Game] G
	 WHERE (G.[GameID] = @GameID OR @GameID IS NULL)
	 AND    G.[GameOver] IS NULL
	 ORDER BY G.[PlayedLast] DESC

	COMMIT
GO


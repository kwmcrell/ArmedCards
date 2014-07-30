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

IF OBJECT_ID('[dbo].[GamePlayer_SelectForUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_SelectForUser] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/06/2013
-- Description:	Select all for a user
-- ===============================================
CREATE PROC [dbo].[GamePlayer_SelectForUser]
	@UserId			int,
	@Type			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

    SELECT	G.[GameID],
			G.[Title],
			G.[IsPrivate],
			G.[GameOver],
			GP.[Points],
			GP.[GameID],
			GP.[UserId],
			GP.[JoinDate],
			GP.[Type],
			GP.[IdlePlayCount]
	 FROM [dbo].[GamePlayer] GP
	 INNER JOIN [dbo].[Game] G ON G.[GameID] = GP.[GameID]
	 WHERE GP.[UserId] = @UserId
	 AND   GP.[Type]   = @Type
	 AND   GP.[Status] = 1

	 SELECT [Points]
	 FROM [dbo].[Leaderboard] L
	 WHERE L.[UserId] = @UserId

	COMMIT
GO
﻿/*
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

IF OBJECT_ID('[dbo].[GamePlayer_Delete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_Delete] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/14/2013
-- Description:	Delete a game player
-- ===============================================
CREATE PROC [dbo].[GamePlayer_Delete] 
	@GameID			int,
	@UserId			int,
	@Type			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	IF (SELECT G.[GameOver] 
		FROM [dbo].[Game] G 
		WHERE G.[GameID] = @GameID) IS NULL OR @Type = 2
		BEGIN

			UPDATE	[dbo].[GamePlayer]
			SET		[Status] = 0 
			WHERE	[GameID] = @GameID 
			AND		[UserId] = @UserId
			AND		[Type]   = @Type

			DELETE
			FROM	[dbo].[GamePlayerCard]
			WHERE	[GameID] = @GameID
			AND		[UserId] = @UserId

		END
		
		IF @Type = 1
			BEGIN
				UPDATE	[dbo].[GamePlayer]
				SET		[Status] = 0, [IdlePlayCount] = 0
				WHERE	[GameID] = @GameID 
				AND		[UserId] = @UserId
			END

	COMMIT
GO
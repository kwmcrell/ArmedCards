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

IF OBJECT_ID('[dbo].[GamePlayerKickVote_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayerKickVote_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/12/2013
-- Description:	Inserts a new vote to kick a user
-- ===============================================
CREATE PROC [dbo].[GamePlayerKickVote_Insert] 
	@GameID			int,
	@KickUserId		int,
	@VotedUserId	int,
	@Vote			bit,
	@VotesToStay	int OUTPUT,
	@VotesToKick	int OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	SELECT @VotesToKick = COUNT(GPKV.[KickUserId])
	FROM [GamePlayerKickVote] GPKV
	WHERE GPKV.[GameID] = @GameID 
	AND GPKV.[KickUserId] = @KickUserId
	AND GPKV.[Vote] = 1

	SELECT @VotesToStay = COUNT(GPKV.[KickUserId])
	FROM [GamePlayerKickVote] GPKV
	WHERE GPKV.[GameID] = @GameID 
	AND GPKV.[KickUserId] = @KickUserId
	AND GPKV.[Vote] = 0
	
	IF NOT EXISTS	(	
						SELECT TOP 1 GPKV.[VotedUserId]
						FROM [GamePlayerKickVote] GPKV
						WHERE GPKV.[GameID] = @GameID 
						AND GPKV.[KickUserId] = @KickUserId
						AND GPKV.[VotedUserId] = @VotedUserId
					)
		BEGIN
			INSERT INTO [GamePlayerKickVote]
			(
				GameID,
				KickUserId,
				VotedUserId,
				Vote
			)
			SELECT
				@GameID,
				@KickUserId,
				@VotedUserId,
				@Vote
		END

	SELECT GPKV.[VotedUserId]
	FROM [GamePlayerKickVote] GPKV
	WHERE GPKV.[GameID] = @GameID 
	AND GPKV.[KickUserId] = @KickUserId

	COMMIT TRAN
		
GO
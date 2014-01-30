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

IF OBJECT_ID('[dbo].[Game_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Game_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new Game
-- ===============================================
CREATE PROC [dbo].[Game_Insert] 
	@Title					nvarchar(255),
	@IsPrivate				bit			  =	0,
	@Passphrase				nvarchar(100) = NULL,
	@PointsToWin			int			  =	8,
	@MaxNumberOfPlayers		int			  =	6,
	@GameCreator_UserId		int,
	@DateCreated			datetime,
	@PlayedLast				datetime	  =	NULL,
	@GameOver				datetime	  =	NULL,
	@GameDeckIDs			xml,
	@MaxNumberOfSpectators	int			  = 0,
	@NewID					int				OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	INSERT INTO [dbo].[Game]
           ([Title]
           ,[IsPrivate]
           ,[Passphrase]
           ,[PointsToWin]
           ,[MaxNumberOfPlayers]
           ,[GameCreator_UserId]
           ,[DateCreated]
           ,[PlayedLast]
           ,[GameOver]
		   ,[MaxNumberOfSpectators])
     SELECT
           @Title,
		   @IsPrivate,
		   @Passphrase,
		   @PointsToWin,
		   @MaxNumberOfPlayers,
		   @GameCreator_UserId,
		   @DateCreated,
		   @PlayedLast,
		   @GameOver,
		   @MaxNumberOfSpectators
	
	SET @NewID = @@IDENTITY

	INSERT INTO [dbo].[GameDeck]
				(GameID, 
				DeckID)
	SELECT		@NewID,
				ids.id.value('@value', 'int')
	FROM		@GameDeckIDs.nodes('ids/id') AS ids ( id )

	COMMIT
GO

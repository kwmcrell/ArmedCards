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

IF OBJECT_ID('[dbo].[GameRoundCard_UpdateWinners]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRoundCard_UpdateWinners] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/28/2013
-- Description:	Update round winning cards
-- ===============================================
CREATE PROC [dbo].[GameRoundCard_UpdateWinners]
	@CardIDs			XML,
	@GameID				INT,
	@AutoPlayed			BIT OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[GameRoundCard]
	SET [Winner] = 1
	WHERE [Card_CardID] IN (SELECT ids.id.value('@value', 'int')
						  FROM	 @CardIDs.nodes('ids/id') AS ids ( id ))
	AND [Game_GameID] = @GameID

	SELECT TOP 1 @AutoPlayed = GRC.[AutoPlayed]
	FROM [GameRoundCard] GRC
	WHERE [Card_CardID] IN (SELECT ids.id.value('@value', 'int')
						  FROM	 @CardIDs.nodes('ids/id') AS ids ( id ))
	AND [Game_GameID] = @GameID

	COMMIT
GO
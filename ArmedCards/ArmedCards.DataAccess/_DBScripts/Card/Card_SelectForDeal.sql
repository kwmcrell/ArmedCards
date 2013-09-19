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

IF OBJECT_ID('[dbo].[Card_SelectForDeal]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Card_SelectForDeal] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/18/2013
-- Description:	Select cards based on game ID
-- ===============================================
CREATE PROC [dbo].[Card_SelectForDeal]
	@GameID			INT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT DISTINCT C.[CardID],
				    C.[Content],
				    C.[Instructions],
				    C.[Type],
				    C.[CreatedBy_UserId],
					(
						SELECT COUNT(GRC.[Card_CardID])
						FROM [dbo].[GameRoundCard] GRC
						WHERE GRC.[Game_GameID] = @GameID
						AND GRC.[Card_CardID] = C.[CardID]
					) AS NumberOfTimesPlayed,
					(
						CASE
							WHEN EXISTS (
											SELECT TOP 1 GPC.CardID
											FROM [dbo].[GamePlayerCard] GPC
											WHERE GPC.[CardID] = C.[CardID]
										)
								THEN 1
							ELSE 0
						END
					) AS CurrentlyInAHand
	FROM [dbo].[Card] C
	INNER JOIN [dbo].[DeckCard] DC ON DC.[CardID] = C.[CardID]
	INNER JOIN [dbo].[GameDeck] GD ON GD.[DeckID] = DC.[DeckID]
	WHERE GD.GameID = @GameID

	COMMIT
GO

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

IF OBJECT_ID('[dbo].[Leaderboard_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Leaderboard_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/2/2013
-- Description:	Selects overall leaderboard
-- ===============================================
CREATE PROC [dbo].[Leaderboard_Select] 
	@UserId			int	= NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DECLARE @leaderboard TABLE(	Points		INT NOT NULL,
								UserId		INT NOT NULL,
								PictureUrl	VARCHAR(500) NOT NULL,
								UserName	VARCHAR(max) NOT NULL,
								Rank		INT NOT NULL
								)

	INSERT INTO @leaderboard
	SELECT 	L.[Points],
			L.[UserId],
			UP.[PictureUrl],
			UP.[UserName],
			ROW_NUMBER() OVER (ORDER BY L.Points DESC) AS Rank
	FROM [dbo].[Leaderboard] L
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = L.[UserId]
	ORDER BY L.Points DESC

	SELECT TOP 10	[Points],
					[UserId],
					[PictureUrl],
					[UserName],
					[Rank]
	FROM @leaderboard

	IF @UserId IS NOT NULL
		BEGIN
			
			DECLARE @currentUserRank INT

			SELECT @currentUserRank = [Rank]
			FROM @leaderboard
			WHERE UserId = @UserId
			
			SELECT TOP 10	[Points],
					[UserId],
					[PictureUrl],
					[UserName],
					[Rank]
			FROM @leaderboard
			WHERE	[Rank] >= (@currentUserRank + 5) OR
					[Rank] <= (@currentUserRank + 4)
		END

	COMMIT
GO
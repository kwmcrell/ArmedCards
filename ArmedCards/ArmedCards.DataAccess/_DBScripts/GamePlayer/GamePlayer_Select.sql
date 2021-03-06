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

IF OBJECT_ID('[dbo].[GamePlayer_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/2/2013
-- Description:	Selects game players
-- ===============================================
CREATE PROC [dbo].[GamePlayer_Select] 
	@GameID			int,
	@Type			int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT	GP.[GameID],
			GP.[Points],
			GP.[UserId],
			GP.[JoinDate],
			GP.[Type],
			GP.[Status],
			UP.[UserName],
			UP.[PictureUrl],
			GP.[IdlePlayCount],
			CASE WHEN GP.[Type] = 1
				THEN
					(SELECT COUNT(CardID)
					FROM [dbo].[GamePlayerCard]
					WHERE	[UserId] = GP.UserId
					AND	[GameID] = @GameID)
				ELSE
					0 
			END AS CardCount
	FROM [dbo].[GamePlayer] GP
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = GP.[UserId]
	WHERE (GP.[GameID] = @GameID OR @GameID IS NULL)
	AND   (GP.[Type]   = @Type   OR @Type IS NULL)
	AND	  (GP.[Status] > 0)
	ORDER BY GP.[JoinDate] ASC

	COMMIT
GO
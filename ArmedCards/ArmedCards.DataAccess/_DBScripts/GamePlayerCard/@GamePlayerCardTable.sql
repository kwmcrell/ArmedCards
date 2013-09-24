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

IF OBJECT_ID('[dbo].[GamePlayerCard]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[GamePlayerCard](
		[UserId]		[int] NOT NULL,
		[CardID]		[int] NOT NULL,
		[GameID]		[int] NOT NULL,
	 CONSTRAINT [PK_dbo.GamePlayerCard] PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC,
		[GameID] ASC,
		[CardID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[GamePlayerCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerCard_dbo.Card_CardID] FOREIGN KEY([CardID])
	REFERENCES [dbo].[Card] ([CardID])
	ON DELETE CASCADE

	ALTER TABLE [dbo].[GamePlayerCard] CHECK CONSTRAINT [FK_dbo.GamePlayerCard_dbo.Card_CardID]

	ALTER TABLE [dbo].[GamePlayerCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerCard_dbo.UserProfile_UserId] FOREIGN KEY([UserId])
	REFERENCES [dbo].[UserProfile] ([UserId])

	ALTER TABLE [dbo].[GamePlayerCard] CHECK CONSTRAINT [FK_dbo.GamePlayerCard_dbo.UserProfile_UserId]

	ALTER TABLE [dbo].[GamePlayerCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerCard_dbo.Game_GameID] FOREIGN KEY([GameID])
	REFERENCES [dbo].[Game] ([GameID])
END
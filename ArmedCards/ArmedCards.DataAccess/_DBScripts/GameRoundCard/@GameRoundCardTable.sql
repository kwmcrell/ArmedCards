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

IF OBJECT_ID('[dbo].[GameRoundCard]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[GameRoundCard](
		[GameRoundCardID]			[int] IDENTITY(1,1) NOT NULL,
		[DatePlayed]				[datetime] NOT NULL,
		[PlayedBy_UserId]			[int] NOT NULL,
		[Card_CardID]				[int] NOT NULL,
		[GameRound_GameRoundID]		[int] NOT NULL,
		[Game_GameID]				[int] NOT NULL,
		[Winner]					[bit] NOT NULL,
		[PlayOrder]					[smallint] NOT NULL,
	 CONSTRAINT [PK_dbo.GameRoundCard] PRIMARY KEY CLUSTERED 
	(
		[GameRoundCardID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[GameRoundCard] ADD  DEFAULT ((0)) FOR [Winner]

	ALTER TABLE [dbo].[GameRoundCard] ADD  DEFAULT ((1)) FOR [PlayOrder]

	ALTER TABLE [dbo].[GameRoundCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GameRoundCard_dbo.Card_Card_CardID] FOREIGN KEY([Card_CardID])
	REFERENCES [dbo].[Card] ([CardID])
	ON DELETE CASCADE

	ALTER TABLE [dbo].[GameRoundCard] CHECK CONSTRAINT [FK_dbo.GameRoundCard_dbo.Card_Card_CardID]

	ALTER TABLE [dbo].[GameRoundCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GameRoundCard_dbo.UserProfile_PlayedBy_UserId] FOREIGN KEY([PlayedBy_UserId])
	REFERENCES [dbo].[UserProfile] ([UserId])

	ALTER TABLE [dbo].[GameRoundCard] CHECK CONSTRAINT [FK_dbo.GameRoundCard_dbo.UserProfile_PlayedBy_UserId]

	ALTER TABLE [dbo].[GameRoundCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GameRoundCard_dbo.Game_Game_GameID] FOREIGN KEY([Game_GameID])
	REFERENCES [dbo].[Game] ([GameID])

	ALTER TABLE [dbo].[GameRoundCard] CHECK CONSTRAINT [FK_dbo.GameRoundCard_dbo.Game_Game_GameID]

	ALTER TABLE [dbo].[GameRoundCard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GameRoundCard_dbo.GameRound_GameRound_GameRoundID] FOREIGN KEY([GameRound_GameRoundID])
	REFERENCES [dbo].[GameRound] ([GameRoundID])

	ALTER TABLE [dbo].[GameRoundCard] CHECK CONSTRAINT [FK_dbo.GameRoundCard_dbo.GameRound_GameRound_GameRoundID]
END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'AutoPlayed' 
				AND Object_ID = Object_ID(N'GameRoundCard'))
BEGIN
    ALTER TABLE [dbo].[GameRoundCard] ADD [AutoPlayed] [bit] NOT NULL DEFAULT 0
END
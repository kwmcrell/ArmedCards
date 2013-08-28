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

IF OBJECT_ID('[dbo].[Game]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[Game](
			[GameID]				[int] IDENTITY(1,1) NOT NULL,
			[Title]					[nvarchar](max) NULL,
			[IsPrivate]				[bit] NOT NULL,
			[Password]				[nvarchar](max) NULL,
			[PointsToWin]			[int] NOT NULL,
			[MaxNumberOfPlayers]	[int] NOT NULL,
			[GameCreator_UserId]	[int] NOT NULL,
			[DateCreated]			[datetime] NOT NULL,
			[PlayedLast]			[datetime] NULL,
			[GameOver]				[datetime] NULL,
		 CONSTRAINT [PK_dbo.Game] PRIMARY KEY CLUSTERED 
		(
			[GameID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((6)) FOR [MaxNumberOfPlayers]
		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((8)) FOR [PointsToWin]
		ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Game_dbo.UserProfile_GameCreator_UserId] FOREIGN KEY([GameCreator_UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])
		ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_dbo.Game_dbo.UserProfile_GameCreator_UserId]
	END

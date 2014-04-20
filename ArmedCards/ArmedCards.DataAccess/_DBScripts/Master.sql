GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection]') IS NULL
	BEGIN
		 CREATE TABLE [dbo].[ActiveConnection](
			[ActiveConnectionID]	[varchar] (255) NOT NULL,
			[GroupName]				[varchar] (255) NOT NULL,
			[User_UserId]			[int]			NOT NULL,
		 CONSTRAINT [PK_dbo.ActiveConnection] PRIMARY KEY CLUSTERED 
		(
			[ActiveConnectionID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[ActiveConnection]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ActiveConnection_dbo.UserProfile_User_UserId] FOREIGN KEY([User_UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])

		ALTER TABLE [dbo].[ActiveConnection] CHECK CONSTRAINT [FK_dbo.ActiveConnection_dbo.UserProfile_User_UserId]
	END

GO

IF NOT EXISTS(	SELECT * 
			FROM sys.columns 
			WHERE Name = N'ConnectionType' 
			AND Object_ID = Object_ID(N'ActiveConnection'))
BEGIN
    ALTER TABLE [dbo].[ActiveConnection] ADD [ConnectionType] [int] NOT NULL DEFAULT 0
END
GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection_Delete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_Delete]
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/2/2013
-- Description:	Delete a active connection
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_Delete]
	@ActiveConnectionID			varchar(255)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	DECLARE @GroupName varchar(255);
	DECLARE @User_UserId int;
	DECLARE @UserName nvarchar(max)

	SELECT	@GroupName = AC.[GroupName],
			@User_UserId = AC.[User_UserId],
			@UserName = UP.[UserName]
	FROM [dbo].[ActiveConnection] AC
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = AC.[User_UserId]
	WHERE (AC.[GroupName] = @GroupName OR @GroupName IS NULL)

	DELETE FROM [dbo].[ActiveConnection]
	WHERE [ActiveConnectionID] = @ActiveConnectionID

	SELECT @ActiveConnectionID AS ActiveConnectionID,
		   @GroupName AS GroupName,
		   @User_UserId AS User_UserId,
		   @UserName AS UserName

	COMMIT
GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection_DeleteAll]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_DeleteAll]
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/2/2013
-- Description:	Delete all active connections
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_DeleteAll]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE FROM [dbo].[ActiveConnection]

	COMMIT
GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new Activie Connection
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_Insert] 
	@ActiveConnectionID		varchar(255),
	@GroupName				varchar(255),
	@User_UserId			int,
	@ConnectionType			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	IF NOT EXISTS (SELECT [User_UserId] FROM [dbo].[ActiveConnection] AC WHERE AC.[GroupName] = @GroupName AND AC.[User_UserId] = @User_UserId AND AC.[ConnectionType] = @ConnectionType)
		BEGIN
			INSERT INTO [dbo].[ActiveConnection]
           (
			[ActiveConnectionID],
			[GroupName],
			[User_UserId],
			[ConnectionType]
		   )
			SELECT
				@ActiveConnectionID,
				@GroupName,
				@User_UserId,
				@ConnectionType

		END
	ELSE
		BEGIN
			UPDATE [dbo].[ActiveConnection]
			SET [ActiveConnectionID] = @ActiveConnectionID
			WHERE [GroupName] = @GroupName 
			AND	  [User_UserId] = @User_UserId
			AND   [ConnectionType] = @ConnectionType
		END

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_Select]
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new User
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_Select]
	@GroupName				varchar(255)			  =	NULL,
	@ExcludeUserIds			XML						  = NULL,
	@ConnectionType			INT						  = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

     SELECT AC.[ActiveConnectionID],
			AC.[GroupName],
			AC.[User_UserId],
			AC.[ConnectionType],
			UP.[UserName]
	 FROM [dbo].[ActiveConnection] AC
	 INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = AC.[User_UserId]
	 WHERE (AC.[GroupName] = @GroupName OR @GroupName IS NULL)
	 AND   (@ExcludeUserIds IS NULL OR UP.UserId NOT IN (SELECT ids.id.value('@value', 'int')
														 FROM	@ExcludeUserIds.nodes('ids/id') AS ids ( id )))
	AND (AC.[ConnectionType] = @ConnectionType OR @ConnectionType IS NULL)

	COMMIT
GO 

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

IF OBJECT_ID('[dbo].[ActiveConnection_SelectById]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ActiveConnection_SelectById]
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 3/12/2014
-- Description:	Select a active connection by its id
-- ===============================================
CREATE PROC [dbo].[ActiveConnection_SelectById]
	@ActiveConnectionID		VARCHAR(255),
	@UserId					INT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

     SELECT AC.[ActiveConnectionID],
			AC.[GroupName],
			AC.[User_UserId],
			AC.[ConnectionType],
			UP.[UserName]
	 FROM [dbo].[ActiveConnection] AC
	 INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = @UserId
	 WHERE (AC.[ActiveConnectionID] = @ActiveConnectionID)

	COMMIT
GO 

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

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'PictureUrl' 
				AND Object_ID = Object_ID(N'UserProfile'))
BEGIN
    ALTER TABLE [dbo].[UserProfile] ADD [PictureUrl] [varchar](500) NULL
END
GO 

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
IF OBJECT_ID('[dbo].[User_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[User_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new User
-- ===============================================
CREATE PROC [dbo].[User_Insert] 
    @UserName varchar(max),
	@PictureUrl varchar(500),
	@NewID int OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	IF NOT EXISTS (SELECT UserId FROM UserProfile WHERE UserName = @userName)
		BEGIN
			INSERT INTO [dbo].[UserProfile] ([UserName], [PictureUrl])
			SELECT @UserName, @PictureUrl
	
			SET @NewID = @@IDENTITY

			--Create user's overall leaderboard
			INSERT INTO [dbo].[Leaderboard] 
			(
				[UserId], 
				[Points]
			)
			SELECT
				@NewID,   
				0

		END
	ELSE
		BEGIN
			SET @NewID = 0
		END

	COMMIT
GO
GO 

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
IF OBJECT_ID('[dbo].[User_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[User_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/29/2013
-- Description:	Select user profiles
-- ===============================================
CREATE PROC [dbo].[User_Select] 
    @UserIds XML
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
			
	SELECT	UP.[UserId],
			UP.[UserName],
			UP.[PictureUrl]
	FROM [dbo].[UserProfile] UP
	WHERE UP.[UserId] IN (SELECT ids.id.value('@value', 'int')
							FROM	@UserIds.nodes('ids/id') AS ids ( id ))

	COMMIT
GO
GO 

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
IF OBJECT_ID('[dbo].[User_UpdateDisplayName]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[User_UpdateDisplayName] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/05/2013
-- Description:	Updates a user's display name
-- ===============================================
CREATE PROC [dbo].[User_UpdateDisplayName] 
	@UserId			int,
    @NewDisplayName	varchar(max),
	@OldDisplayName varchar(max)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	DECLARE @count INT
	
	UPDATE UserProfile
	SET UserName = @NewDisplayName
	WHERE UserId = @UserId

	SELECT @count = COUNT(UP.UserId)
	FROM UserProfile UP 
	WHERE UP.UserName = @NewDisplayName

	IF @count > 1
		BEGIN
			UPDATE UserProfile
			SET UserName = @OldDisplayName
			WHERE UserId = @UserId
		END
	ELSE
		BEGIN
			SELECT OAM.Provider, OAM.ProviderUserId
			FROM webpages_OAuthMembership OAM
			WHERE OAM.UserId = @UserId
		END

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[Card]') IS NULL
	BEGIN
		 CREATE TABLE [dbo].[Card](
			[CardID] [int] IDENTITY(1,1) NOT NULL,
			[Content] [varchar](255) NULL,
			[Type] [int] NOT NULL,
			[Instructions] [int] NOT NULL,
			[CreatedBy_UserId] [int] NULL,
		 CONSTRAINT [PK_dbo.Card] PRIMARY KEY CLUSTERED 
		(
			[CardID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[Card]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Card_dbo.UserProfile_CreatedBy_UserId] FOREIGN KEY([CreatedBy_UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])

		ALTER TABLE [dbo].[Card] CHECK CONSTRAINT [FK_dbo.Card_dbo.UserProfile_CreatedBy_UserId]
	END
GO 

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

IF OBJECT_ID('[dbo].[Card_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Card_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/6/2013
-- Description:	Select cards based on deck IDs
-- ===============================================
CREATE PROC [dbo].[Card_Select]
	@DeckIDs			XML
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT DISTINCT C.[CardID],
				    C.[Content],
				    C.[Instructions],
				    C.[Type],
				    C.[CreatedBy_UserId]
	FROM [dbo].[Card] C
	INNER JOIN [dbo].[DeckCard] DC ON DC.[CardID] = C.[CardID]
	WHERE DC.[DeckID] IN (SELECT ids.id.value('@value', 'int')
						  FROM	 @DeckIDs.nodes('ids/id') AS ids ( id ))

	COMMIT
GO
GO 

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
								THEN CAST(1 as BIT)
							ELSE CAST(0 as BIT)
						END
					) AS CurrentlyInAHand
	FROM [dbo].[Card] C
	INNER JOIN [dbo].[DeckCard] DC ON DC.[CardID] = C.[CardID]
	INNER JOIN [dbo].[GameDeck] GD ON GD.[DeckID] = DC.[DeckID]
	WHERE GD.GameID = @GameID

	COMMIT
GO
GO 

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

IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card])
BEGIN

SET IDENTITY_INSERT [dbo].[Card] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 1, N'Being on fire.', 1, 0, 1 UNION ALL
SELECT 2, N'Racism.', 1, 0, 1 UNION ALL
SELECT 3, N'Old-people smell.', 1, 0, 1 UNION ALL
SELECT 4, N'A micropenis.', 1, 0, 1 UNION ALL
SELECT 5, N'Women in yogurt commercials.', 1, 0, 1 UNION ALL
SELECT 6, N'Classist undertones.', 1, 0, 1 UNION ALL
SELECT 7, N'Not giving a shit about the Third World.', 1, 0, 1 UNION ALL
SELECT 8, N'Sexting.', 1, 0, 1 UNION ALL
SELECT 9, N'Roofies.', 1, 0, 1 UNION ALL
SELECT 10, N'A windmill full of corpses.', 1, 0, 1 UNION ALL
SELECT 11, N'The gays.', 1, 0, 1 UNION ALL
SELECT 12, N'Oversized lollipops.', 1, 0, 1 UNION ALL
SELECT 13, N'African Children.', 1, 0, 1 UNION ALL
SELECT 14, N'An asymmetric boob job.', 1, 0, 1 UNION ALL
SELECT 15, N'Bingeing and purging.', 1, 0, 1 UNION ALL
SELECT 16, N'The hardworking Mexican.', 1, 0, 1 UNION ALL
SELECT 17, N'An Oedipus complex.', 1, 0, 1 UNION ALL
SELECT 18, N'A tiny horse.', 1, 0, 1 UNION ALL
SELECT 19, N'Boogers.', 1, 0, 1 UNION ALL
SELECT 20, N'Penis envy.', 1, 0, 1 UNION ALL
SELECT 21, N'Barack Obama.', 1, 0, 1 UNION ALL
SELECT 22, N'My humps.', 1, 0, 1 UNION ALL
SELECT 23, N'The Tempurpedic® Swedish Sleep System™.', 1, 0, 1 UNION ALL
SELECT 24, N'Scientology.', 1, 0, 1 UNION ALL
SELECT 25, N'Dry heaving.', 1, 0, 1 UNION ALL
SELECT 26, N'Skeletor.', 1, 0, 1 UNION ALL
SELECT 27, N'Darth Vader.', 1, 0, 1 UNION ALL
SELECT 28, N'Figgy Pudding.', 1, 0, 1 UNION ALL
SELECT 29, N'Chutzpah.', 1, 0, 1 UNION ALL
SELECT 30, N'Five-Dollar Footlongs™.', 1, 0, 1 UNION ALL
SELECT 31, N'Elderly Japanese men.', 1, 0, 1 UNION ALL
SELECT 32, N'Free Samples.', 1, 0, 1 UNION ALL
SELECT 33, N'Estrogen.', 1, 0, 1 UNION ALL
SELECT 34, N'Sexual tension.', 1, 0, 1 UNION ALL
SELECT 35, N'Famine.', 1, 0, 1 UNION ALL
SELECT 36, N'A stray pube.', 1, 0, 1 UNION ALL
SELECT 37, N'Men.', 1, 0, 1 UNION ALL
SELECT 38, N'Heartwarming orphans.', 1, 0, 1 UNION ALL
SELECT 39, N'Genital piercings.', 1, 0, 1 UNION ALL
SELECT 40, N'A bag of magic beans.', 1, 0, 1 UNION ALL
SELECT 41, N'Repression.', 1, 0, 1 UNION ALL
SELECT 42, N'Prancing.', 1, 0, 1 UNION ALL
SELECT 43, N'My relationship status.', 1, 0, 1 UNION ALL
SELECT 44, N'Overcompensation.', 1, 0, 1 UNION ALL
SELECT 45, N'Peeing a little bit.', 1, 0, 1 UNION ALL
SELECT 46, N'Pooping back and forth. Forever', 1, 0, 1 UNION ALL
SELECT 47, N'Eating all of the cookies before the AIDS bake-sale.', 1, 0, 1 UNION ALL
SELECT 48, N'Testicular torsion.', 1, 0, 1 UNION ALL
SELECT 49, N'The Devil himself.', 1, 0, 1 UNION ALL
SELECT 50, N'The World of Warcraft.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 51, N'Dick Cheney.', 1, 0, 1 UNION ALL
SELECT 52, N'MechaHitler.', 1, 0, 1 UNION ALL
SELECT 53, N'Being fabulous.', 1, 0, 1 UNION ALL
SELECT 54, N'Pictures of boobs.', 1, 0, 1 UNION ALL
SELECT 55, N'A caress of the inner thigh.', 1, 0, 1 UNION ALL
SELECT 56, N'The Amish.', 1, 0, 1 UNION ALL
SELECT 57, N'Pabst Blue Ribbon.', 1, 0, 1 UNION ALL
SELECT 58, N'Lance Armstrong''s missing testicle.', 1, 0, 1 UNION ALL
SELECT 59, N'Pedophiles.', 1, 0, 1 UNION ALL
SELECT 60, N'The Pope.', 1, 0, 1 UNION ALL
SELECT 61, N'Flying sex snakes.', 1, 0, 1 UNION ALL
SELECT 62, N'Sarah Palin.', 1, 0, 1 UNION ALL
SELECT 63, N'Feeding Rosie O Donnell.', 1, 0, 1 UNION ALL
SELECT 64, N'Sexy pillow fights.', 1, 0, 1 UNION ALL
SELECT 65, N'Another goddamn vampire movie.', 1, 0, 1 UNION ALL
SELECT 66, N'Cybernetic enhancements.', 1, 0, 1 UNION ALL
SELECT 67, N'Civilian casualties.', 1, 0, 1 UNION ALL
SELECT 68, N'Scrubbing under the folds.', 1, 0, 1 UNION ALL
SELECT 69, N'The female orgasm.', 1, 0, 1 UNION ALL
SELECT 70, N'Bitches.', 1, 0, 1 UNION ALL
SELECT 71, N'The Boy Scouts of America.', 1, 0, 1 UNION ALL
SELECT 72, N'Auschwitz.', 1, 0, 1 UNION ALL
SELECT 73, N'Finger painting.', 1, 0, 1 UNION ALL
SELECT 74, N'The Care Bear Stare.', 1, 0, 1 UNION ALL
SELECT 75, N'The Jews.', 1, 0, 1 UNION ALL
SELECT 76, N'Being marginalized.', 1, 0, 1 UNION ALL
SELECT 77, N'The Blood of Christ.', 1, 0, 1 UNION ALL
SELECT 78, N'Dead parents.', 1, 0, 1 UNION ALL
SELECT 79, N'Seduction.', 1, 0, 1 UNION ALL
SELECT 80, N'Dying of dysentery.', 1, 0, 1 UNION ALL
SELECT 81, N'Mr. Clean, right behind you.', 1, 0, 1 UNION ALL
SELECT 82, N'The Virginia Tech Massacre.', 1, 0, 1 UNION ALL
SELECT 83, N'Jewish fraternities.', 1, 0, 1 UNION ALL
SELECT 84, N'Hot Pockets®.', 1, 0, 1 UNION ALL
SELECT 85, N'Natalie Portman.', 1, 0, 1 UNION ALL
SELECT 86, N'Agriculture.', 1, 0, 1 UNION ALL
SELECT 87, N'Judge Judy.', 1, 0, 1 UNION ALL
SELECT 88, N'Surprise Sex!', 1, 0, 1 UNION ALL
SELECT 89, N'The homosexual lifestyle.', 1, 0, 1 UNION ALL
SELECT 90, N'Robert Downey, Jr.', 1, 0, 1 UNION ALL
SELECT 91, N'The Trail of Tears.', 1, 0, 1 UNION ALL
SELECT 92, N'An M. Night Shyamalan plot twist.', 1, 0, 1 UNION ALL
SELECT 93, N'A big hoopla about nothing.', 1, 0, 1 UNION ALL
SELECT 94, N'Electricity.', 1, 0, 1 UNION ALL
SELECT 95, N'Amputees.', 1, 0, 1 UNION ALL
SELECT 96, N'Throwing a virgin into a volcano.', 1, 0, 1 UNION ALL
SELECT 97, N'Italians.', 1, 0, 1 UNION ALL
SELECT 98, N'Explosions.', 1, 0, 1 UNION ALL
SELECT 99, N'A good sniff.', 1, 0, 1 UNION ALL
SELECT 100, N'Destroying the evidence.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 2.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 101, N'Children on leashes.', 1, 0, 1 UNION ALL
SELECT 102, N'Catapults.', 1, 0, 1 UNION ALL
SELECT 103, N'One trillion dollars.', 1, 0, 1 UNION ALL
SELECT 104, N'Friends with benefits.', 1, 0, 1 UNION ALL
SELECT 105, N'Dying.', 1, 0, 1 UNION ALL
SELECT 106, N'Silence.', 1, 0, 1 UNION ALL
SELECT 107, N'An honest cop with nothing left to lose.', 1, 0, 1 UNION ALL
SELECT 108, N'YOU MUST CONSTRUCT ADDITIONAL PYLONS.', 1, 0, 1 UNION ALL
SELECT 109, N'Justin Bieber.', 1, 0, 1 UNION ALL
SELECT 110, N'The holy Bible.', 1, 0, 1 UNION ALL
SELECT 111, N'Balls.', 1, 0, 1 UNION ALL
SELECT 112, N'Praying the gay away.', 1, 0, 1 UNION ALL
SELECT 113, N'Teenage pregnancy.', 1, 0, 1 UNION ALL
SELECT 114, N'German dungeon porn.', 1, 0, 1 UNION ALL
SELECT 115, N'The invisible hand.', 1, 0, 1 UNION ALL
SELECT 116, N'My inner demons.', 1, 0, 1 UNION ALL
SELECT 117, N'Powerful thighs.', 1, 0, 1 UNION ALL
SELECT 118, N'Getting naked and watching Nickelodeon.', 1, 0, 1 UNION ALL
SELECT 119, N'Crippling debt.', 1, 0, 1 UNION ALL
SELECT 120, N'Kamikaze pilots.', 1, 0, 1 UNION ALL
SELECT 121, N'Teaching a robot to love.', 1, 0, 1 UNION ALL
SELECT 122, N'Police brutality.', 1, 0, 1 UNION ALL
SELECT 123, N'Horse meat.', 1, 0, 1 UNION ALL
SELECT 124, N'All-you-can-eat shrimp for $4.99.', 1, 0, 1 UNION ALL
SELECT 125, N'Heteronormativity.', 1, 0, 1 UNION ALL
SELECT 126, N'Michael Jackson.', 1, 0, 1 UNION ALL
SELECT 127, N'A really cool hat.', 1, 0, 1 UNION ALL
SELECT 128, N'Copping a feel.', 1, 0, 1 UNION ALL
SELECT 129, N'Crystal meth.', 1, 0, 1 UNION ALL
SELECT 130, N'Shapeshifters.', 1, 0, 1 UNION ALL
SELECT 131, N'Fingering.', 1, 0, 1 UNION ALL
SELECT 132, N'A disappointing birthday party.', 1, 0, 1 UNION ALL
SELECT 133, N'Dental dams.', 1, 0, 1 UNION ALL
SELECT 134, N'My soul.', 1, 0, 1 UNION ALL
SELECT 135, N'A sausage festival.', 1, 0, 1 UNION ALL
SELECT 136, N'The chronic.', 1, 0, 1 UNION ALL
SELECT 137, N'Eugenics.', 1, 0, 1 UNION ALL
SELECT 138, N'Synergistic management solutions.', 1, 0, 1 UNION ALL
SELECT 139, N'RoboCop.', 1, 0, 1 UNION ALL
SELECT 140, N'Serfdom.', 1, 0, 1 UNION ALL
SELECT 141, N'Stephen Hawking talking dirty.', 1, 0, 1 UNION ALL
SELECT 142, N'Tangled Slinkys.', 1, 0, 1 UNION ALL
SELECT 143, N'Fiery poops.', 1, 0, 1 UNION ALL
SELECT 144, N'Public ridicule.', 1, 0, 1 UNION ALL
SELECT 145, N'That thing that electrocutes your abs.', 1, 0, 1 UNION ALL
SELECT 146, N'Picking up girls at the abortion clinic.', 1, 0, 1 UNION ALL
SELECT 147, N'Object permanence.', 1, 0, 1 UNION ALL
SELECT 148, N'GoGurt®.', 1, 0, 1 UNION ALL
SELECT 149, N'Lockjaw.', 1, 0, 1 UNION ALL
SELECT 150, N'Attitude.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 3.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 151, N'Passable transvestites.', 1, 0, 1 UNION ALL
SELECT 152, N'Wet dreams.', 1, 0, 1 UNION ALL
SELECT 153, N'The Dance of the Sugar Plum Fairy.', 1, 0, 1 UNION ALL
SELECT 154, N'Firing a rifle into the air while balls deep in a squealing hog.', 1, 0, 1 UNION ALL
SELECT 155, N'Panda sex.', 1, 0, 1 UNION ALL
SELECT 156, N'Necrophilia.', 1, 0, 1 UNION ALL
SELECT 157, N'Grave robbing.', 1, 0, 1 UNION ALL
SELECT 158, N'A bleached asshole.', 1, 0, 1 UNION ALL
SELECT 159, N'Muhammad (Praise Be Unto Him).', 1, 0, 1 UNION ALL
SELECT 160, N'Multiple stab wounds.', 1, 0, 1 UNION ALL
SELECT 161, N'Stranger danger.', 1, 0, 1 UNION ALL
SELECT 162, N'A monkey smoking a cigar.', 1, 0, 1 UNION ALL
SELECT 163, N'Smegma.', 1, 0, 1 UNION ALL
SELECT 164, N'A live studio audience.', 1, 0, 1 UNION ALL
SELECT 165, N'Making a pouty face.', 1, 0, 1 UNION ALL
SELECT 166, N'The violation of our most basic human rights.', 1, 0, 1 UNION ALL
SELECT 167, N'Unfathomable stupidity.', 1, 0, 1 UNION ALL
SELECT 168, N'Sunshine and rainbows.', 1, 0, 1 UNION ALL
SELECT 169, N'Whipping it out.', 1, 0, 1 UNION ALL
SELECT 170, N'The token minority.', 1, 0, 1 UNION ALL
SELECT 171, N'The terrorists.', 1, 0, 1 UNION ALL
SELECT 172, N'The Three-Fifths compromise.', 1, 0, 1 UNION ALL
SELECT 173, N'A snapping turtle biting the tip of your penis.', 1, 0, 1 UNION ALL
SELECT 174, N'Vehicular manslaughter.', 1, 0, 1 UNION ALL
SELECT 175, N'Jibber-jabber.', 1, 0, 1 UNION ALL
SELECT 176, N'Emotions.', 1, 0, 1 UNION ALL
SELECT 177, N'Getting so angry that you pop a boner.', 1, 0, 1 UNION ALL
SELECT 178, N'Same-sex ice dancing.', 1, 0, 1 UNION ALL
SELECT 179, N'An M16 assault rifle.', 1, 0, 1 UNION ALL
SELECT 180, N'Man meat.', 1, 0, 1 UNION ALL
SELECT 181, N'Incest.', 1, 0, 1 UNION ALL
SELECT 182, N'A foul mouth.', 1, 0, 1 UNION ALL
SELECT 183, N'Flightless birds.', 1, 0, 1 UNION ALL
SELECT 184, N'Doing the right thing.', 1, 0, 1 UNION ALL
SELECT 185, N'When you fart and a little bit comes out.', 1, 0, 1 UNION ALL
SELECT 186, N'Frolicking.', 1, 0, 1 UNION ALL
SELECT 187, N'Being a dick to children.', 1, 0, 1 UNION ALL
SELECT 188, N'Poopy diapers.', 1, 0, 1 UNION ALL
SELECT 189, N'Filling Sean Hannity with helium and watching him float away.', 1, 0, 1 UNION ALL
SELECT 190, N'Raptor attacks.', 1, 0, 1 UNION ALL
SELECT 191, N'Swooping.', 1, 0, 1 UNION ALL
SELECT 192, N'Concealing a boner.', 1, 0, 1 UNION ALL
SELECT 193, N'Full frontal nudity.', 1, 0, 1 UNION ALL
SELECT 194, N'Vigorous jazz hands.', 1, 0, 1 UNION ALL
SELECT 195, N'Nipple blades.', 1, 0, 1 UNION ALL
SELECT 196, N'A bitch slap.', 1, 0, 1 UNION ALL
SELECT 197, N'Michelle Obama''s arms.', 1, 0, 1 UNION ALL
SELECT 198, N'Mouth Herpes.', 1, 0, 1 UNION ALL
SELECT 199, N'A robust mongoloid.', 1, 0, 1 UNION ALL
SELECT 200, N'Mutually-assured destruction.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 4.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 201, N'The Rapture.', 1, 0, 1 UNION ALL
SELECT 202, N'Road head.', 1, 0, 1 UNION ALL
SELECT 203, N'Stalin.', 1, 0, 1 UNION ALL
SELECT 204, N'Lactation.', 1, 0, 1 UNION ALL
SELECT 205, N'Hurricane Katrina.', 1, 0, 1 UNION ALL
SELECT 206, N'The true meaning of Christmas.', 1, 0, 1 UNION ALL
SELECT 207, N'Self-loathing.', 1, 0, 1 UNION ALL
SELECT 208, N'A brain tumor.', 1, 0, 1 UNION ALL
SELECT 209, N'Dead babies.', 1, 0, 1 UNION ALL
SELECT 210, N'New Age music.', 1, 0, 1 UNION ALL
SELECT 211, N'A thermonuclear detonation.', 1, 0, 1 UNION ALL
SELECT 212, N'Geese.', 1, 0, 1 UNION ALL
SELECT 213, N'Kanye West.', 1, 0, 1 UNION ALL
SELECT 214, N'God.', 1, 0, 1 UNION ALL
SELECT 215, N'A spastic nerd.', 1, 0, 1 UNION ALL
SELECT 216, N'Harry Potter erotica.', 1, 0, 1 UNION ALL
SELECT 217, N'Kids with ass cancer.', 1, 0, 1 UNION ALL
SELECT 218, N'Lumberjack fantasies.', 1, 0, 1 UNION ALL
SELECT 219, N'The American Dream.', 1, 0, 1 UNION ALL
SELECT 220, N'Sweet, sweet vengeance.', 1, 0, 1 UNION ALL
SELECT 221, N'Winking at old people.', 1, 0, 1 UNION ALL
SELECT 222, N'The taint; the grundle; the fleshy fun-bridge.', 1, 0, 1 UNION ALL
SELECT 223, N'Oompa-Loompas.', 1, 0, 1 UNION ALL
SELECT 224, N'Authentic Mexican cuisine.', 1, 0, 1 UNION ALL
SELECT 225, N'Preteens.', 1, 0, 1 UNION ALL
SELECT 226, N'The Little Engine That Could.', 1, 0, 1 UNION ALL
SELECT 227, N'Guys who don''t call.', 1, 0, 1 UNION ALL
SELECT 228, N'Erectile Dysfunction.', 1, 0, 1 UNION ALL
SELECT 229, N'Parting the Red Sea.', 1, 0, 1 UNION ALL
SELECT 230, N'Rush Limbaugh''s soft, shitty body.', 1, 0, 1 UNION ALL
SELECT 231, N'Saxophone solos.', 1, 0, 1 UNION ALL
SELECT 232, N'Land mines.', 1, 0, 1 UNION ALL
SELECT 233, N'Capturing Newt Gingrich and forcing him to dance in a monkey suit.', 1, 0, 1 UNION ALL
SELECT 234, N'Me time.', 1, 0, 1 UNION ALL
SELECT 235, N'Nickelback.', 1, 0, 1 UNION ALL
SELECT 236, N'Vigilante justice.', 1, 0, 1 UNION ALL
SELECT 237, N'The South.', 1, 0, 1 UNION ALL
SELECT 238, N'Opposable thumbs.', 1, 0, 1 UNION ALL
SELECT 239, N'Ghosts.', 1, 0, 1 UNION ALL
SELECT 240, N'Alcoholism.', 1, 0, 1 UNION ALL
SELECT 241, N'Poorly-time Holocaust jokes.', 1, 0, 1 UNION ALL
SELECT 242, N'Inappropriate yodeling.', 1, 0, 1 UNION ALL
SELECT 243, N'Battlefield amputations.', 1, 0, 1 UNION ALL
SELECT 244, N'Exactly what you''d expect.', 1, 0, 1 UNION ALL
SELECT 245, N'A time travel paradox.', 1, 0, 1 UNION ALL
SELECT 246, N'AXE Body Spray.', 1, 0, 1 UNION ALL
SELECT 247, N'Actually taking candy from a baby.', 1, 0, 1 UNION ALL
SELECT 248, N'Leaving an awkward voicemail.', 1, 0, 1 UNION ALL
SELECT 249, N'A sassy black woman.', 1, 0, 1 UNION ALL
SELECT 250, N'Being a motherfucking sorcerer.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 5.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 251, N'A mopey zoo lion.', 1, 0, 1 UNION ALL
SELECT 252, N'A murder most foul.', 1, 0, 1 UNION ALL
SELECT 253, N'A falcon with a cap on its head.', 1, 0, 1 UNION ALL
SELECT 254, N'Farting and walking away.', 1, 0, 1 UNION ALL
SELECT 255, N'A mating display.', 1, 0, 1 UNION ALL
SELECT 256, N'The Chinese gymnastics team.', 1, 0, 1 UNION ALL
SELECT 257, N'Friction.', 1, 0, 1 UNION ALL
SELECT 258, N'Asians who aren''t good at math.', 1, 0, 1 UNION ALL
SELECT 259, N'Fear itself.', 1, 0, 1 UNION ALL
SELECT 260, N'A can of whoop-ass.', 1, 0, 1 UNION ALL
SELECT 261, N'Yeast.', 1, 0, 1 UNION ALL
SELECT 262, N'Lunchables™.', 1, 0, 1 UNION ALL
SELECT 263, N'Licking things to claim them as your own.', 1, 0, 1 UNION ALL
SELECT 264, N'Vikings.', 1, 0, 1 UNION ALL
SELECT 265, N'The Kool-Aid Man.', 1, 0, 1 UNION ALL
SELECT 266, N'Hot cheese.', 1, 0, 1 UNION ALL
SELECT 267, N'Nicolas Cage.', 1, 0, 1 UNION ALL
SELECT 268, N'A defective condom.', 1, 0, 1 UNION ALL
SELECT 269, N'The inevitable heat death of the universe.', 1, 0, 1 UNION ALL
SELECT 270, N'Republicans.', 1, 0, 1 UNION ALL
SELECT 271, N'William Shatner.', 1, 0, 1 UNION ALL
SELECT 272, N'Tentacle porn.', 1, 0, 1 UNION ALL
SELECT 273, N'Sperm whales.', 1, 0, 1 UNION ALL
SELECT 274, N'Lady Gaga.', 1, 0, 1 UNION ALL
SELECT 275, N'Chunks of dead prostitute.', 1, 0, 1 UNION ALL
SELECT 276, N'Gloryholes.', 1, 0, 1 UNION ALL
SELECT 277, N'Daddy issues.', 1, 0, 1 UNION ALL
SELECT 278, N'A mime having a stroke.', 1, 0, 1 UNION ALL
SELECT 279, N'White people.', 1, 0, 1 UNION ALL
SELECT 280, N'A lifetime of sadness.', 1, 0, 1 UNION ALL
SELECT 281, N'Tasteful sideboob.', 1, 0, 1 UNION ALL
SELECT 282, N'A sea of troubles.', 1, 0, 1 UNION ALL
SELECT 283, N'Nazis.', 1, 0, 1 UNION ALL
SELECT 284, N'A cooler full of organs.', 1, 0, 1 UNION ALL
SELECT 285, N'Giving 110%.', 1, 0, 1 UNION ALL
SELECT 286, N'Doing'' it in the butt.', 1, 0, 1 UNION ALL
SELECT 287, N'John Wilkes Booth.', 1, 0, 1 UNION ALL
SELECT 288, N'Obesity.', 1, 0, 1 UNION ALL
SELECT 289, N'A homoerotic volleyball montage.', 1, 0, 1 UNION ALL
SELECT 290, N'Puppies!', 1, 0, 1 UNION ALL
SELECT 291, N'Natural male enhancement.', 1, 0, 1 UNION ALL
SELECT 292, N'Brown people.', 1, 0, 1 UNION ALL
SELECT 293, N'Dropping a chandelier on your enemies and riding the rope up.', 1, 0, 1 UNION ALL
SELECT 294, N'Soup that is too hot.', 1, 0, 1 UNION ALL
SELECT 295, N'Porn stars.', 1, 0, 1 UNION ALL
SELECT 296, N'Hormone injections.', 1, 0, 1 UNION ALL
SELECT 297, N'Pulling out.', 1, 0, 1 UNION ALL
SELECT 298, N'The Big Bang.', 1, 0, 1 UNION ALL
SELECT 299, N'Switching to Geico®.', 1, 0, 1 UNION ALL
SELECT 300, N'Wearing underwear inside-out to avoid doing laundry.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 6.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 301, N'Rehab.', 1, 0, 1 UNION ALL
SELECT 302, N'Christopher Walken.', 1, 0, 1 UNION ALL
SELECT 303, N'Count Chocula.', 1, 0, 1 UNION ALL
SELECT 304, N'The Hamburglar.', 1, 0, 1 UNION ALL
SELECT 305, N'Not reciprocating oral sex.', 1, 0, 1 UNION ALL
SELECT 306, N'Aaron Burr.', 1, 0, 1 UNION ALL
SELECT 307, N'Hot people.', 1, 0, 1 UNION ALL
SELECT 308, N'Foreskin.', 1, 0, 1 UNION ALL
SELECT 309, N'Assless Chaps.', 1, 0, 1 UNION ALL
SELECT 310, N'The miracle of childbirth.', 1, 0, 1 UNION ALL
SELECT 311, N'Waiting ''til marriage.', 1, 0, 1 UNION ALL
SELECT 312, N'Two midgets shitting into a bucket.', 1, 0, 1 UNION ALL
SELECT 313, N'Adderall™.', 1, 0, 1 UNION ALL
SELECT 314, N'A sad handjob.', 1, 0, 1 UNION ALL
SELECT 315, N'Cheating in the Special Olympics.', 1, 0, 1 UNION ALL
SELECT 316, N'The glass Ceiling.', 1, 0, 1 UNION ALL
SELECT 317, N'The Hustle.', 1, 0, 1 UNION ALL
SELECT 318, N'Getting drunk on mouthwash.', 1, 0, 1 UNION ALL
SELECT 319, N'Bling.', 1, 0, 1 UNION ALL
SELECT 320, N'Breaking out into song and dance.', 1, 0, 1 UNION ALL
SELECT 321, N'A Super Soaker™ full of cat pee.', 1, 0, 1 UNION ALL
SELECT 322, N'The Underground Railroad.', 1, 0, 1 UNION ALL
SELECT 323, N'Home video of Oprah sobbing into Lean Cuisine®.', 1, 0, 1 UNION ALL
SELECT 324, N'The Rev. Dr. Martin Luther King, Jr.', 1, 0, 1 UNION ALL
SELECT 325, N'Extremely tight pants.', 1, 0, 1 UNION ALL
SELECT 326, N'Third base.', 1, 0, 1 UNION ALL
SELECT 327, N'Waking up half-naked in a Denny''s parking lot.', 1, 0, 1 UNION ALL
SELECT 328, N'Golden Showers.', 1, 0, 1 UNION ALL
SELECT 329, N'White privilege.', 1, 0, 1 UNION ALL
SELECT 330, N'Hope.', 1, 0, 1 UNION ALL
SELECT 331, N'Taking off your shirt.', 1, 0, 1 UNION ALL
SELECT 332, N'Smallpox blankets.', 1, 0, 1 UNION ALL
SELECT 333, N'Ethnic cleansing.', 1, 0, 1 UNION ALL
SELECT 334, N'Queefing.', 1, 0, 1 UNION ALL
SELECT 335, N'Helplessly giggling at the mention of Hutus and Tutsis.', 1, 0, 1 UNION ALL
SELECT 336, N'Getting really high.', 1, 0, 1 UNION ALL
SELECT 337, N'Natural selection.', 1, 0, 1 UNION ALL
SELECT 338, N'A gassy antelope.', 1, 0, 1 UNION ALL
SELECT 339, N'My sex life.', 1, 0, 1 UNION ALL
SELECT 340, N'Arnold Schwarzenegger.', 1, 0, 1 UNION ALL
SELECT 341, N'Pretending to care.', 1, 0, 1 UNION ALL
SELECT 342, N'Ronald Reagan.', 1, 0, 1 UNION ALL
SELECT 343, N'Toni Morrison''s vagina.', 1, 0, 1 UNION ALL
SELECT 344, N'Pterodactyl eggs.', 1, 0, 1 UNION ALL
SELECT 345, N'A death ray.', 1, 0, 1 UNION ALL
SELECT 346, N'BATMAN!!!.', 1, 0, 1 UNION ALL
SELECT 347, N'Homeless people.', 1, 0, 1 UNION ALL
SELECT 348, N'Racially-biased SAT questions.', 1, 0, 1 UNION ALL
SELECT 349, N'Centaurs.', 1, 0, 1 UNION ALL
SELECT 350, N'A salty surprise.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 7.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 351, N'72 virgins.', 1, 0, 1 UNION ALL
SELECT 352, N'Embryonic stem cells.', 1, 0, 1 UNION ALL
SELECT 353, N'Pixelated bukkake.', 1, 0, 1 UNION ALL
SELECT 354, N'Seppuku.', 1, 0, 1 UNION ALL
SELECT 355, N'An icepick lobotomy.', 1, 0, 1 UNION ALL
SELECT 356, N'Stormtroopers.', 1, 0, 1 UNION ALL
SELECT 357, N'Menstrual rage.', 1, 0, 1 UNION ALL
SELECT 358, N'Passing a kidney stone.', 1, 0, 1 UNION ALL
SELECT 359, N'An uppercut.', 1, 0, 1 UNION ALL
SELECT 360, N'Shaquille O''Neal''s acting career.', 1, 0, 1 UNION ALL
SELECT 361, N'Horrifying laser hair removal accidents.', 1, 0, 1 UNION ALL
SELECT 362, N'Autocannibalism.', 1, 0, 1 UNION ALL
SELECT 363, N'A fetus.', 1, 0, 1 UNION ALL
SELECT 364, N'Riding off into the sunset.', 1, 0, 1 UNION ALL
SELECT 365, N'Goblins.', 1, 0, 1 UNION ALL
SELECT 366, N'Eating the last known bison.', 1, 0, 1 UNION ALL
SELECT 367, N'Shiny objects.', 1, 0, 1 UNION ALL
SELECT 368, N'Being rich.', 1, 0, 1 UNION ALL
SELECT 369, N'A Bop It™.', 1, 0, 1 UNION ALL
SELECT 370, N'Leprosy.', 1, 0, 1 UNION ALL
SELECT 371, N'World peace.', 1, 0, 1 UNION ALL
SELECT 372, N'Dick fingers.', 1, 0, 1 UNION ALL
SELECT 373, N'Chainsaws for hands.', 1, 0, 1 UNION ALL
SELECT 374, N'The Make-A-Wish Foundation®.', 1, 0, 1 UNION ALL
SELECT 375, N'Britney Spears at 55.', 1, 0, 1 UNION ALL
SELECT 376, N'Laying an egg.', 1, 0, 1 UNION ALL
SELECT 377, N'The folly of man.', 1, 0, 1 UNION ALL
SELECT 378, N'My genitals.', 1, 0, 1 UNION ALL
SELECT 379, N'Grandma.', 1, 0, 1 UNION ALL
SELECT 380, N'Flesh-eating bacteria.', 1, 0, 1 UNION ALL
SELECT 381, N'Poor people.', 1, 0, 1 UNION ALL
SELECT 382, N'50''000 volts straight to the nipples.', 1, 0, 1 UNION ALL
SELECT 383, N'Active listening.', 1, 0, 1 UNION ALL
SELECT 384, N'The Übermensch.', 1, 0, 1 UNION ALL
SELECT 385, N'Poor life choices.', 1, 0, 1 UNION ALL
SELECT 386, N'Altar boys.', 1, 0, 1 UNION ALL
SELECT 387, N'My vagina.', 1, 0, 1 UNION ALL
SELECT 388, N'Pac-Man uncontrollably guzzling cum.', 1, 0, 1 UNION ALL
SELECT 389, N'Sniffing glue.', 1, 0, 1 UNION ALL
SELECT 390, N'The placenta.', 1, 0, 1 UNION ALL
SELECT 391, N'The profoundly handicapped.', 1, 0, 1 UNION ALL
SELECT 392, N'Spontaneous human combustion.', 1, 0, 1 UNION ALL
SELECT 393, N'The KKK.', 1, 0, 1 UNION ALL
SELECT 394, N'The clitoris.', 1, 0, 1 UNION ALL
SELECT 395, N'Not wearing pants.', 1, 0, 1 UNION ALL
SELECT 396, N'Date rape.', 1, 0, 1 UNION ALL
SELECT 397, N'Black people.', 1, 0, 1 UNION ALL
SELECT 398, N'A bucket of fish heads.', 1, 0, 1 UNION ALL
SELECT 399, N'Hospice care.', 1, 0, 1 UNION ALL
SELECT 400, N'Passive-aggressive Post-it notes.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 8.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 401, N'Fancy Feast®.', 1, 0, 1 UNION ALL
SELECT 402, N'The heart of a child.', 1, 0, 1 UNION ALL
SELECT 403, N'Sharing needles.', 1, 0, 1 UNION ALL
SELECT 404, N'Scalping.', 1, 0, 1 UNION ALL
SELECT 405, N'A look-see.', 1, 0, 1 UNION ALL
SELECT 406, N'Getting married, having kids, buying some stuff, retiring to Florida, and dying.', 1, 0, 1 UNION ALL
SELECT 407, N'Sean Penn.', 1, 0, 1 UNION ALL
SELECT 408, N'Sean Connery.', 1, 0, 1 UNION ALL
SELECT 409, N'Expecting a burp and vomiting on the floor.', 1, 0, 1 UNION ALL
SELECT 410, N'Wifely duties.', 1, 0, 1 UNION ALL
SELECT 411, N'A pyramid of severed heads.', 1, 0, 1 UNION ALL
SELECT 412, N'Genghis Khan.', 1, 0, 1 UNION ALL
SELECT 413, N'Historically black colleges.', 1, 0, 1 UNION ALL
SELECT 414, N'Raping and pillaging.', 1, 0, 1 UNION ALL
SELECT 415, N'A subscription to Men''s Fitness.', 1, 0, 1 UNION ALL
SELECT 416, N'The milk man.', 1, 0, 1 UNION ALL
SELECT 417, N'Friendly fire.', 1, 0, 1 UNION ALL
SELECT 418, N'Women''s suffrage.', 1, 0, 1 UNION ALL
SELECT 419, N'AIDS.', 1, 0, 1 UNION ALL
SELECT 420, N'Former President George W. Bush.', 1, 0, 1 UNION ALL
SELECT 421, N'8 oz. of sweet Mexican black-tar heroin.', 1, 0, 1 UNION ALL
SELECT 422, N'Half-assed foreplay.', 1, 0, 1 UNION ALL
SELECT 423, N'Edible underpants.', 1, 0, 1 UNION ALL
SELECT 424, N'My collection of high-tech sex toys.', 1, 0, 1 UNION ALL
SELECT 425, N'The Force.', 1, 0, 1 UNION ALL
SELECT 426, N'Bees?', 1, 0, 1 UNION ALL
SELECT 427, N'Loose lips.', 1, 0, 1 UNION ALL
SELECT 428, N'Jerking off into a pool of children''s tears.', 1, 0, 1 UNION ALL
SELECT 429, N'A micropig wearing a tiny raincoat and booties.', 1, 0, 1 UNION ALL
SELECT 430, N'A hot mess.', 1, 0, 1 UNION ALL
SELECT 431, N'Masturbation.', 1, 0, 1 UNION ALL
SELECT 432, N'Tom Cruise.', 1, 0, 1 UNION ALL
SELECT 433, N'A balanced breakfast.', 1, 0, 1 UNION ALL
SELECT 434, N'Anal beads.', 1, 0, 1 UNION ALL
SELECT 435, N'Drinking alone.', 1, 0, 1 UNION ALL
SELECT 436, N'Cards Against Humanity.', 1, 0, 1 UNION ALL
SELECT 437, N'Coat hanger abortions.', 1, 0, 1 UNION ALL
SELECT 438, N'Used panties.', 1, 0, 1 UNION ALL
SELECT 439, N'Cuddling.', 1, 0, 1 UNION ALL
SELECT 440, N'Wiping her butt.', 1, 0, 1 UNION ALL
SELECT 441, N'Domino''s™ Oreo™ Dessert Pizza.', 1, 0, 1 UNION ALL
SELECT 442, N'A zesty breakfast burrito.', 1, 0, 1 UNION ALL
SELECT 443, N'Morgan Freeman''s voice.', 1, 0, 1 UNION ALL
SELECT 444, N'A middle-aged man on roller skates.', 1, 0, 1 UNION ALL
SELECT 445, N'Gandhi.', 1, 0, 1 UNION ALL
SELECT 446, N'The penny whistle solo ||My Heart Will Go On||.', 1, 0, 1 UNION ALL
SELECT 447, N'Spectacular abs.', 1, 0, 1 UNION ALL
SELECT 448, N'Keanu Reeves.', 1, 0, 1 UNION ALL
SELECT 449, N'Child beauty pageants.', 1, 0, 1 UNION ALL
SELECT 450, N'Child abuse.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 9.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 451, N'Bill Nye the Science Guy.', 1, 0, 1 UNION ALL
SELECT 452, N'Science.', 1, 0, 1 UNION ALL
SELECT 453, N'A tribe of warrior women.', 1, 0, 1 UNION ALL
SELECT 454, N'Viagra®.', 1, 0, 1 UNION ALL
SELECT 455, N'Her Majesty, Queen Elizabeth II.', 1, 0, 1 UNION ALL
SELECT 456, N'The entire Mormon Tabernacle Choir.', 1, 0, 1 UNION ALL
SELECT 457, N'Hulk Hogan.', 1, 0, 1 UNION ALL
SELECT 458, N'Take-backsies.', 1, 0, 1 UNION ALL
SELECT 459, N'An erection that lasts longer than four hours.', 1, 0, 1 UNION ALL
SELECT 460, N'How did I lose my virginity?', 0, 0, 1 UNION ALL
SELECT 461, N'Why can''t I sleep at night?', 0, 0, 1 UNION ALL
SELECT 462, N'What''s that smell?', 0, 0, 1 UNION ALL
SELECT 463, N'I got 99 problems but _____ ain''t.', 0, 0, 1 UNION ALL
SELECT 464, N'Maybe she''s born with it. Maybe it''s _____.', 0, 0, 1 UNION ALL
SELECT 465, N'What''s the next Happy Meal® toy?', 0, 0, 1 UNION ALL
SELECT 466, N'Here is the church Here is the steeple Open the doors And there is _____.', 0, 0, 1 UNION ALL
SELECT 467, N'It''s a pity that kids these days are all getting involved with _____.', 0, 0, 1 UNION ALL
SELECT 468, N'During his childhood, Salvador Dali produced hundreds of paintings of _____.', 0, 0, 1 UNION ALL
SELECT 469, N'Alternative medicine is now embracing the curative powers of _____.', 0, 0, 1 UNION ALL
SELECT 470, N'And the Academy Award for _____ goes to _____.', 0, 1, 1 UNION ALL
SELECT 471, N'What''s that sound?', 0, 0, 1 UNION ALL
SELECT 472, N'What ended my last relationship?', 0, 0, 1 UNION ALL
SELECT 473, N'MTV''s new reality show features eight wash-up celebrities living with _____.', 0, 0, 1 UNION ALL
SELECT 474, N'I drink to forget _____.', 0, 0, 1 UNION ALL
SELECT 475, N'I''m sorry, Professor, but I couldn''t complete my homework because of _____.', 0, 0, 1 UNION ALL
SELECT 476, N'What is Batman''s guilty pleasure?', 0, 0, 1 UNION ALL
SELECT 477, N'This is the way the world ends. This is the way the world ends. Not with a bang but with _____.', 0, 0, 1 UNION ALL
SELECT 478, N'What''s a girl''s best friend?', 0, 0, 1 UNION ALL
SELECT 479, N'TSA guidelines now prohibit _____ on airplanes.', 0, 0, 1 UNION ALL
SELECT 480, N'_____. That''s how I want to die.', 0, 0, 1 UNION ALL
SELECT 481, N'For my next trick, I will pull _____ out of _____.', 0, 1, 1 UNION ALL
SELECT 482, N'In the new Disney Channel Original Movie, Hannah Montana struggles with _____ for the first time.', 0, 0, 1 UNION ALL
SELECT 483, N'_____ is a slippery slope that leads to _____', 0, 1, 1 UNION ALL
SELECT 484, N'What does Dick Cheney prefer?', 0, 0, 1 UNION ALL
SELECT 485, N'Dear Abby, I''m having some trouble with _____ and would like your advice.', 0, 0, 1 UNION ALL
SELECT 486, N'Instead of coal, Santa now gives the bad children _____.', 0, 0, 1 UNION ALL
SELECT 487, N'What''s the most emo?', 0, 0, 1 UNION ALL
SELECT 488, N'In 1,000 years, when paper money is a distant memory, how will we pay for goods and services?', 0, 0, 1 UNION ALL
SELECT 489, N'What''s the next superhero/sidekick duo?', 0, 1, 1 UNION ALL
SELECT 490, N'In M. Night Shyamalan''s new movie, Bruce Willis discovers that _____ had really been _____ all along.', 0, 1, 1 UNION ALL
SELECT 491, N'A romantic, candlelit dinner would be incomplete without _____.', 0, 0, 1 UNION ALL
SELECT 492, N'_____. Betcha can''t have just one!', 0, 0, 1 UNION ALL
SELECT 493, N'White people like _____.', 0, 0, 1 UNION ALL
SELECT 494, N'_____. High five, bro.', 0, 0, 1 UNION ALL
SELECT 495, N'Next from J.K. Rowling: Harry Potter and the Chamber of _____.', 0, 0, 1 UNION ALL
SELECT 496, N'BILLY MAYS HERE FOR _____.', 0, 0, 1 UNION ALL
SELECT 497, N'In a world ravaged by _____, our only solace is _____.', 0, 1, 1 UNION ALL
SELECT 498, N'War! What is it good for?', 0, 0, 1 UNION ALL
SELECT 499, N'During sex, I like to think about _____.', 0, 0, 1 UNION ALL
SELECT 500, N'What are my parents hiding from me?', 0, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 10.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 501, N'What will always get you laid?', 0, 0, 1 UNION ALL
SELECT 502, N'In L.A. County Jail, word is you can trade 200 cigarettes for _____.', 0, 0, 1 UNION ALL
SELECT 503, N'What did I bring back from Mexico?', 0, 0, 1 UNION ALL
SELECT 504, N'What don''t you want to find in your Chinese food?', 0, 0, 1 UNION ALL
SELECT 505, N'What will I bring back in time to convince people that I am a powerful wizard?', 0, 0, 1 UNION ALL
SELECT 506, N'How am I maintaining my relationship status?', 0, 0, 1 UNION ALL
SELECT 507, N'_____. It''s a trap!', 0, 0, 1 UNION ALL
SELECT 508, N'Coming to Broadway this season, _____: The Musical.', 0, 0, 1 UNION ALL
SELECT 509, N'While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on _____.', 0, 0, 1 UNION ALL
SELECT 510, N'After the earthquake, Sean Penn brought _____ to the people of Haiti.', 0, 0, 1 UNION ALL
SELECT 511, N'Next on ESPN2, the World Series of _____.', 0, 0, 1 UNION ALL
SELECT 512, N'Step 1: _____. Step 2: _____. Step 3: Profit.', 0, 1, 1 UNION ALL
SELECT 513, N'Rumor has it that Vladimir Putin''s favorite delicacy is _____ stuffed with _____.', 0, 1, 1 UNION ALL
SELECT 514, N'But before I kill you, Mr. Bond, I must show you _____.', 0, 0, 1 UNION ALL
SELECT 515, N'What gives me uncontrollable gas?', 0, 0, 1 UNION ALL
SELECT 516, N'What do old people smell like?', 0, 0, 1 UNION ALL
SELECT 517, N'The class field trip was completely ruined by _____.', 0, 0, 1 UNION ALL
SELECT 518, N'When Pharaoh remained unmoved Moses called down a Plague of _____.', 0, 0, 1 UNION ALL
SELECT 519, N'What''s my secret power?', 0, 0, 1 UNION ALL
SELECT 520, N'What''s there a ton of in heaven?', 0, 0, 1 UNION ALL
SELECT 521, N'What would grandma find disturbing, yet oddly charming?', 0, 0, 1 UNION ALL
SELECT 522, N'I never truly understood _____ until I encountered _____.', 0, 1, 1 UNION ALL
SELECT 523, N'What did the U.S. airdrop to the children of Afghanistan?', 0, 0, 1 UNION ALL
SELECT 524, N'What help Obama unwind?', 0, 0, 1 UNION ALL
SELECT 525, N'What did Vin Diesel eat for dinner?', 0, 0, 1 UNION ALL
SELECT 526, N'_____: good to the last drop.', 0, 0, 1 UNION ALL
SELECT 527, N'Why am I sticky?', 0, 0, 1 UNION ALL
SELECT 528, N'What gets better with age?', 0, 0, 1 UNION ALL
SELECT 529, N'_____: kid-tested, mother-approved.', 0, 0, 1 UNION ALL
SELECT 530, N'Daddy, why is mommy crying?', 0, 0, 1 UNION ALL
SELECT 531, N'What''s Teach for America using to inspire inner city students to succeed?', 0, 0, 1 UNION ALL
SELECT 532, N'Studies show that lab rats navigate mazes 50% faster after being exposed to _____.', 0, 0, 1 UNION ALL
SELECT 533, N'Life for American Indians was forever changed when the White Man introduced them to _____.', 0, 0, 1 UNION ALL
SELECT 534, N'Make a haiku.', 0, 2, 1 UNION ALL
SELECT 535, N'I do not know with what weapons World War III will be fought, but World War IV will be fought with _____.', 0, 0, 1 UNION ALL
SELECT 536, N'Why do I hurt all over?', 0, 0, 1 UNION ALL
SELECT 537, N'What am I giving up for Lent?', 0, 0, 1 UNION ALL
SELECT 538, N'In Michael Jackson''s final moments, he thought about _____.', 0, 0, 1 UNION ALL
SELECT 539, N'The Smithsonian Museum of Natural History has just opened an interactive exhibit on _____.', 0, 0, 1 UNION ALL
SELECT 540, N'When I am President of the United States, I will create the Department of _____.', 0, 0, 1 UNION ALL
SELECT 541, N'Lifetime® presents _____, the story of _____.', 0, 1, 1 UNION ALL
SELECT 542, N'When I am a billionaire, I shall erect a 50-foot statue to commemorate _____.', 0, 0, 1 UNION ALL
SELECT 543, N'When I was tripping on acid, _____ turned into _____', 0, 1, 1 UNION ALL
SELECT 544, N'That''s right, I killed _____. How, you ask? _____.', 0, 1, 1 UNION ALL
SELECT 545, N'What''s my anti-drug?', 0, 0, 1 UNION ALL
SELECT 546, N'_____ + _____ = _____', 0, 2, 1 UNION ALL
SELECT 547, N'What never fails to liven up the party?', 0, 0, 1 UNION ALL
SELECT 548, N'What''s the new fad diet?', 0, 0, 1 UNION ALL
SELECT 549, N'Major League Baseball has banned _____ for giving players an unfair advantage.', 0, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 11.....Done!', 10, 1) WITH NOWAIT;

SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO
GO 

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

IF OBJECT_ID('[dbo].[Deck]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[Deck](
			[DeckID] [int] IDENTITY(1,1) NOT NULL,
			[Type] [int] NOT NULL,
			[Title] [varchar](255) NULL,
			[IsPrivate] [bit] NOT NULL,
			[CreatedBy_UserId] [int] NULL,
		 CONSTRAINT [PK_dbo.Deck] PRIMARY KEY CLUSTERED 
		(
			[DeckID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[Deck]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Deck_dbo.UserProfile_CreatedBy_UserId] FOREIGN KEY([CreatedBy_UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])

		ALTER TABLE [dbo].[Deck] CHECK CONSTRAINT [FK_dbo.Deck_dbo.UserProfile_CreatedBy_UserId]
	END
GO 

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

IF OBJECT_ID('[dbo].[Deck_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Deck_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/6/2013
-- Description:	Select decks based on game IDs
-- ===============================================
CREATE PROC [dbo].[Deck_Select]
	@GameIDs			XML		=	NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT D.[DeckID],
		   D.[Title],
		   D.[Type],
		   D.[IsPrivate],
		   D.[CreatedBy_UserId],
		   GD.[GameID]
	FROM [dbo].[Deck] D
	INNER JOIN [dbo].[GameDeck] GD ON GD.[DeckID] = D.[DeckID]
	WHERE GD.[GameID] IN (SELECT ids.id.value('@value', 'int')
						  FROM	 @GameIDs.nodes('ids/id') AS ids ( id ))

	COMMIT
GO
GO 

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

IF NOT EXISTS (SELECT TOP 1 [DeckID] FROM [dbo].[Deck])
BEGIN

SET IDENTITY_INSERT [dbo].[Deck] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Deck]([DeckID], [Type], [Title], [IsPrivate], [CreatedBy_UserId])
SELECT 1, 0, N'Main', 0, 1
COMMIT;
RAISERROR (N'[dbo].[Deck]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;

SET IDENTITY_INSERT [dbo].[Deck] OFF;

END

GO
GO 

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

IF OBJECT_ID('[dbo].[DeckCard]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[DeckCard](
			[DeckID] [int] NOT NULL,
			[CardID] [int] NOT NULL,
		 CONSTRAINT [PK_dbo.DeckCard] PRIMARY KEY CLUSTERED 
		(
			[CardID] ASC,
			[DeckID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
		
		ALTER TABLE [dbo].[DeckCard]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DeckCard_dbo.Card_CardID] FOREIGN KEY([CardID])
		REFERENCES [dbo].[Card] ([CardID])
		ON DELETE CASCADE

		ALTER TABLE [dbo].[DeckCard] CHECK CONSTRAINT [FK_dbo.DeckCard_dbo.Card_CardID]

		ALTER TABLE [dbo].[DeckCard]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DeckCard_dbo.Deck_DeckID] FOREIGN KEY([DeckID])
		REFERENCES [dbo].[Deck] ([DeckID])
		ON DELETE CASCADE

		ALTER TABLE [dbo].[DeckCard] CHECK CONSTRAINT [FK_dbo.DeckCard_dbo.Deck_DeckID]

		CREATE NONCLUSTERED INDEX [NonClusteredIndex-20130909-211136] ON [dbo].[DeckCard]
		(
			[DeckID] ASC,
			[CardID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
GO 

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
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard])
BEGIN

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 1, 1 UNION ALL
SELECT 2, 1 UNION ALL
SELECT 3, 1 UNION ALL
SELECT 4, 1 UNION ALL
SELECT 5, 1 UNION ALL
SELECT 6, 1 UNION ALL
SELECT 7, 1 UNION ALL
SELECT 8, 1 UNION ALL
SELECT 9, 1 UNION ALL
SELECT 10, 1 UNION ALL
SELECT 11, 1 UNION ALL
SELECT 12, 1 UNION ALL
SELECT 13, 1 UNION ALL
SELECT 14, 1 UNION ALL
SELECT 15, 1 UNION ALL
SELECT 16, 1 UNION ALL
SELECT 17, 1 UNION ALL
SELECT 18, 1 UNION ALL
SELECT 19, 1 UNION ALL
SELECT 20, 1 UNION ALL
SELECT 21, 1 UNION ALL
SELECT 22, 1 UNION ALL
SELECT 23, 1 UNION ALL
SELECT 24, 1 UNION ALL
SELECT 25, 1 UNION ALL
SELECT 26, 1 UNION ALL
SELECT 27, 1 UNION ALL
SELECT 28, 1 UNION ALL
SELECT 29, 1 UNION ALL
SELECT 30, 1 UNION ALL
SELECT 31, 1 UNION ALL
SELECT 32, 1 UNION ALL
SELECT 33, 1 UNION ALL
SELECT 34, 1 UNION ALL
SELECT 35, 1 UNION ALL
SELECT 36, 1 UNION ALL
SELECT 37, 1 UNION ALL
SELECT 38, 1 UNION ALL
SELECT 39, 1 UNION ALL
SELECT 40, 1 UNION ALL
SELECT 41, 1 UNION ALL
SELECT 42, 1 UNION ALL
SELECT 43, 1 UNION ALL
SELECT 44, 1 UNION ALL
SELECT 45, 1 UNION ALL
SELECT 46, 1 UNION ALL
SELECT 47, 1 UNION ALL
SELECT 48, 1 UNION ALL
SELECT 49, 1 UNION ALL
SELECT 50, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 51, 1 UNION ALL
SELECT 52, 1 UNION ALL
SELECT 53, 1 UNION ALL
SELECT 54, 1 UNION ALL
SELECT 55, 1 UNION ALL
SELECT 56, 1 UNION ALL
SELECT 57, 1 UNION ALL
SELECT 58, 1 UNION ALL
SELECT 59, 1 UNION ALL
SELECT 60, 1 UNION ALL
SELECT 61, 1 UNION ALL
SELECT 62, 1 UNION ALL
SELECT 63, 1 UNION ALL
SELECT 64, 1 UNION ALL
SELECT 65, 1 UNION ALL
SELECT 66, 1 UNION ALL
SELECT 67, 1 UNION ALL
SELECT 68, 1 UNION ALL
SELECT 69, 1 UNION ALL
SELECT 70, 1 UNION ALL
SELECT 71, 1 UNION ALL
SELECT 72, 1 UNION ALL
SELECT 73, 1 UNION ALL
SELECT 74, 1 UNION ALL
SELECT 75, 1 UNION ALL
SELECT 76, 1 UNION ALL
SELECT 77, 1 UNION ALL
SELECT 78, 1 UNION ALL
SELECT 79, 1 UNION ALL
SELECT 80, 1 UNION ALL
SELECT 81, 1 UNION ALL
SELECT 82, 1 UNION ALL
SELECT 83, 1 UNION ALL
SELECT 84, 1 UNION ALL
SELECT 85, 1 UNION ALL
SELECT 86, 1 UNION ALL
SELECT 87, 1 UNION ALL
SELECT 88, 1 UNION ALL
SELECT 89, 1 UNION ALL
SELECT 90, 1 UNION ALL
SELECT 91, 1 UNION ALL
SELECT 92, 1 UNION ALL
SELECT 93, 1 UNION ALL
SELECT 94, 1 UNION ALL
SELECT 95, 1 UNION ALL
SELECT 96, 1 UNION ALL
SELECT 97, 1 UNION ALL
SELECT 98, 1 UNION ALL
SELECT 99, 1 UNION ALL
SELECT 100, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 2.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 101, 1 UNION ALL
SELECT 102, 1 UNION ALL
SELECT 103, 1 UNION ALL
SELECT 104, 1 UNION ALL
SELECT 105, 1 UNION ALL
SELECT 106, 1 UNION ALL
SELECT 107, 1 UNION ALL
SELECT 108, 1 UNION ALL
SELECT 109, 1 UNION ALL
SELECT 110, 1 UNION ALL
SELECT 111, 1 UNION ALL
SELECT 112, 1 UNION ALL
SELECT 113, 1 UNION ALL
SELECT 114, 1 UNION ALL
SELECT 115, 1 UNION ALL
SELECT 116, 1 UNION ALL
SELECT 117, 1 UNION ALL
SELECT 118, 1 UNION ALL
SELECT 119, 1 UNION ALL
SELECT 120, 1 UNION ALL
SELECT 121, 1 UNION ALL
SELECT 122, 1 UNION ALL
SELECT 123, 1 UNION ALL
SELECT 124, 1 UNION ALL
SELECT 125, 1 UNION ALL
SELECT 126, 1 UNION ALL
SELECT 127, 1 UNION ALL
SELECT 128, 1 UNION ALL
SELECT 129, 1 UNION ALL
SELECT 130, 1 UNION ALL
SELECT 131, 1 UNION ALL
SELECT 132, 1 UNION ALL
SELECT 133, 1 UNION ALL
SELECT 134, 1 UNION ALL
SELECT 135, 1 UNION ALL
SELECT 136, 1 UNION ALL
SELECT 137, 1 UNION ALL
SELECT 138, 1 UNION ALL
SELECT 139, 1 UNION ALL
SELECT 140, 1 UNION ALL
SELECT 141, 1 UNION ALL
SELECT 142, 1 UNION ALL
SELECT 143, 1 UNION ALL
SELECT 144, 1 UNION ALL
SELECT 145, 1 UNION ALL
SELECT 146, 1 UNION ALL
SELECT 147, 1 UNION ALL
SELECT 148, 1 UNION ALL
SELECT 149, 1 UNION ALL
SELECT 150, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 3.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 151, 1 UNION ALL
SELECT 152, 1 UNION ALL
SELECT 153, 1 UNION ALL
SELECT 154, 1 UNION ALL
SELECT 155, 1 UNION ALL
SELECT 156, 1 UNION ALL
SELECT 157, 1 UNION ALL
SELECT 158, 1 UNION ALL
SELECT 159, 1 UNION ALL
SELECT 160, 1 UNION ALL
SELECT 161, 1 UNION ALL
SELECT 162, 1 UNION ALL
SELECT 163, 1 UNION ALL
SELECT 164, 1 UNION ALL
SELECT 165, 1 UNION ALL
SELECT 166, 1 UNION ALL
SELECT 167, 1 UNION ALL
SELECT 168, 1 UNION ALL
SELECT 169, 1 UNION ALL
SELECT 170, 1 UNION ALL
SELECT 171, 1 UNION ALL
SELECT 172, 1 UNION ALL
SELECT 173, 1 UNION ALL
SELECT 174, 1 UNION ALL
SELECT 175, 1 UNION ALL
SELECT 176, 1 UNION ALL
SELECT 177, 1 UNION ALL
SELECT 178, 1 UNION ALL
SELECT 179, 1 UNION ALL
SELECT 180, 1 UNION ALL
SELECT 181, 1 UNION ALL
SELECT 182, 1 UNION ALL
SELECT 183, 1 UNION ALL
SELECT 184, 1 UNION ALL
SELECT 185, 1 UNION ALL
SELECT 186, 1 UNION ALL
SELECT 187, 1 UNION ALL
SELECT 188, 1 UNION ALL
SELECT 189, 1 UNION ALL
SELECT 190, 1 UNION ALL
SELECT 191, 1 UNION ALL
SELECT 192, 1 UNION ALL
SELECT 193, 1 UNION ALL
SELECT 194, 1 UNION ALL
SELECT 195, 1 UNION ALL
SELECT 196, 1 UNION ALL
SELECT 197, 1 UNION ALL
SELECT 198, 1 UNION ALL
SELECT 199, 1 UNION ALL
SELECT 200, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 4.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 201, 1 UNION ALL
SELECT 202, 1 UNION ALL
SELECT 203, 1 UNION ALL
SELECT 204, 1 UNION ALL
SELECT 205, 1 UNION ALL
SELECT 206, 1 UNION ALL
SELECT 207, 1 UNION ALL
SELECT 208, 1 UNION ALL
SELECT 209, 1 UNION ALL
SELECT 210, 1 UNION ALL
SELECT 211, 1 UNION ALL
SELECT 212, 1 UNION ALL
SELECT 213, 1 UNION ALL
SELECT 214, 1 UNION ALL
SELECT 215, 1 UNION ALL
SELECT 216, 1 UNION ALL
SELECT 217, 1 UNION ALL
SELECT 218, 1 UNION ALL
SELECT 219, 1 UNION ALL
SELECT 220, 1 UNION ALL
SELECT 221, 1 UNION ALL
SELECT 222, 1 UNION ALL
SELECT 223, 1 UNION ALL
SELECT 224, 1 UNION ALL
SELECT 225, 1 UNION ALL
SELECT 226, 1 UNION ALL
SELECT 227, 1 UNION ALL
SELECT 228, 1 UNION ALL
SELECT 229, 1 UNION ALL
SELECT 230, 1 UNION ALL
SELECT 231, 1 UNION ALL
SELECT 232, 1 UNION ALL
SELECT 233, 1 UNION ALL
SELECT 234, 1 UNION ALL
SELECT 235, 1 UNION ALL
SELECT 236, 1 UNION ALL
SELECT 237, 1 UNION ALL
SELECT 238, 1 UNION ALL
SELECT 239, 1 UNION ALL
SELECT 240, 1 UNION ALL
SELECT 241, 1 UNION ALL
SELECT 242, 1 UNION ALL
SELECT 243, 1 UNION ALL
SELECT 244, 1 UNION ALL
SELECT 245, 1 UNION ALL
SELECT 246, 1 UNION ALL
SELECT 247, 1 UNION ALL
SELECT 248, 1 UNION ALL
SELECT 249, 1 UNION ALL
SELECT 250, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 5.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 251, 1 UNION ALL
SELECT 252, 1 UNION ALL
SELECT 253, 1 UNION ALL
SELECT 254, 1 UNION ALL
SELECT 255, 1 UNION ALL
SELECT 256, 1 UNION ALL
SELECT 257, 1 UNION ALL
SELECT 258, 1 UNION ALL
SELECT 259, 1 UNION ALL
SELECT 260, 1 UNION ALL
SELECT 261, 1 UNION ALL
SELECT 262, 1 UNION ALL
SELECT 263, 1 UNION ALL
SELECT 264, 1 UNION ALL
SELECT 265, 1 UNION ALL
SELECT 266, 1 UNION ALL
SELECT 267, 1 UNION ALL
SELECT 268, 1 UNION ALL
SELECT 269, 1 UNION ALL
SELECT 270, 1 UNION ALL
SELECT 271, 1 UNION ALL
SELECT 272, 1 UNION ALL
SELECT 273, 1 UNION ALL
SELECT 274, 1 UNION ALL
SELECT 275, 1 UNION ALL
SELECT 276, 1 UNION ALL
SELECT 277, 1 UNION ALL
SELECT 278, 1 UNION ALL
SELECT 279, 1 UNION ALL
SELECT 280, 1 UNION ALL
SELECT 281, 1 UNION ALL
SELECT 282, 1 UNION ALL
SELECT 283, 1 UNION ALL
SELECT 284, 1 UNION ALL
SELECT 285, 1 UNION ALL
SELECT 286, 1 UNION ALL
SELECT 287, 1 UNION ALL
SELECT 288, 1 UNION ALL
SELECT 289, 1 UNION ALL
SELECT 290, 1 UNION ALL
SELECT 291, 1 UNION ALL
SELECT 292, 1 UNION ALL
SELECT 293, 1 UNION ALL
SELECT 294, 1 UNION ALL
SELECT 295, 1 UNION ALL
SELECT 296, 1 UNION ALL
SELECT 297, 1 UNION ALL
SELECT 298, 1 UNION ALL
SELECT 299, 1 UNION ALL
SELECT 300, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 6.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 301, 1 UNION ALL
SELECT 302, 1 UNION ALL
SELECT 303, 1 UNION ALL
SELECT 304, 1 UNION ALL
SELECT 305, 1 UNION ALL
SELECT 306, 1 UNION ALL
SELECT 307, 1 UNION ALL
SELECT 308, 1 UNION ALL
SELECT 309, 1 UNION ALL
SELECT 310, 1 UNION ALL
SELECT 311, 1 UNION ALL
SELECT 312, 1 UNION ALL
SELECT 313, 1 UNION ALL
SELECT 314, 1 UNION ALL
SELECT 315, 1 UNION ALL
SELECT 316, 1 UNION ALL
SELECT 317, 1 UNION ALL
SELECT 318, 1 UNION ALL
SELECT 319, 1 UNION ALL
SELECT 320, 1 UNION ALL
SELECT 321, 1 UNION ALL
SELECT 322, 1 UNION ALL
SELECT 323, 1 UNION ALL
SELECT 324, 1 UNION ALL
SELECT 325, 1 UNION ALL
SELECT 326, 1 UNION ALL
SELECT 327, 1 UNION ALL
SELECT 328, 1 UNION ALL
SELECT 329, 1 UNION ALL
SELECT 330, 1 UNION ALL
SELECT 331, 1 UNION ALL
SELECT 332, 1 UNION ALL
SELECT 333, 1 UNION ALL
SELECT 334, 1 UNION ALL
SELECT 335, 1 UNION ALL
SELECT 336, 1 UNION ALL
SELECT 337, 1 UNION ALL
SELECT 338, 1 UNION ALL
SELECT 339, 1 UNION ALL
SELECT 340, 1 UNION ALL
SELECT 341, 1 UNION ALL
SELECT 342, 1 UNION ALL
SELECT 343, 1 UNION ALL
SELECT 344, 1 UNION ALL
SELECT 345, 1 UNION ALL
SELECT 346, 1 UNION ALL
SELECT 347, 1 UNION ALL
SELECT 348, 1 UNION ALL
SELECT 349, 1 UNION ALL
SELECT 350, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 7.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 351, 1 UNION ALL
SELECT 352, 1 UNION ALL
SELECT 353, 1 UNION ALL
SELECT 354, 1 UNION ALL
SELECT 355, 1 UNION ALL
SELECT 356, 1 UNION ALL
SELECT 357, 1 UNION ALL
SELECT 358, 1 UNION ALL
SELECT 359, 1 UNION ALL
SELECT 360, 1 UNION ALL
SELECT 361, 1 UNION ALL
SELECT 362, 1 UNION ALL
SELECT 363, 1 UNION ALL
SELECT 364, 1 UNION ALL
SELECT 365, 1 UNION ALL
SELECT 366, 1 UNION ALL
SELECT 367, 1 UNION ALL
SELECT 368, 1 UNION ALL
SELECT 369, 1 UNION ALL
SELECT 370, 1 UNION ALL
SELECT 371, 1 UNION ALL
SELECT 372, 1 UNION ALL
SELECT 373, 1 UNION ALL
SELECT 374, 1 UNION ALL
SELECT 375, 1 UNION ALL
SELECT 376, 1 UNION ALL
SELECT 377, 1 UNION ALL
SELECT 378, 1 UNION ALL
SELECT 379, 1 UNION ALL
SELECT 380, 1 UNION ALL
SELECT 381, 1 UNION ALL
SELECT 382, 1 UNION ALL
SELECT 383, 1 UNION ALL
SELECT 384, 1 UNION ALL
SELECT 385, 1 UNION ALL
SELECT 386, 1 UNION ALL
SELECT 387, 1 UNION ALL
SELECT 388, 1 UNION ALL
SELECT 389, 1 UNION ALL
SELECT 390, 1 UNION ALL
SELECT 391, 1 UNION ALL
SELECT 392, 1 UNION ALL
SELECT 393, 1 UNION ALL
SELECT 394, 1 UNION ALL
SELECT 395, 1 UNION ALL
SELECT 396, 1 UNION ALL
SELECT 397, 1 UNION ALL
SELECT 398, 1 UNION ALL
SELECT 399, 1 UNION ALL
SELECT 400, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 8.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 401, 1 UNION ALL
SELECT 402, 1 UNION ALL
SELECT 403, 1 UNION ALL
SELECT 404, 1 UNION ALL
SELECT 405, 1 UNION ALL
SELECT 406, 1 UNION ALL
SELECT 407, 1 UNION ALL
SELECT 408, 1 UNION ALL
SELECT 409, 1 UNION ALL
SELECT 410, 1 UNION ALL
SELECT 411, 1 UNION ALL
SELECT 412, 1 UNION ALL
SELECT 413, 1 UNION ALL
SELECT 414, 1 UNION ALL
SELECT 415, 1 UNION ALL
SELECT 416, 1 UNION ALL
SELECT 417, 1 UNION ALL
SELECT 418, 1 UNION ALL
SELECT 419, 1 UNION ALL
SELECT 420, 1 UNION ALL
SELECT 421, 1 UNION ALL
SELECT 422, 1 UNION ALL
SELECT 423, 1 UNION ALL
SELECT 424, 1 UNION ALL
SELECT 425, 1 UNION ALL
SELECT 426, 1 UNION ALL
SELECT 427, 1 UNION ALL
SELECT 428, 1 UNION ALL
SELECT 429, 1 UNION ALL
SELECT 430, 1 UNION ALL
SELECT 431, 1 UNION ALL
SELECT 432, 1 UNION ALL
SELECT 433, 1 UNION ALL
SELECT 434, 1 UNION ALL
SELECT 435, 1 UNION ALL
SELECT 436, 1 UNION ALL
SELECT 437, 1 UNION ALL
SELECT 438, 1 UNION ALL
SELECT 439, 1 UNION ALL
SELECT 440, 1 UNION ALL
SELECT 441, 1 UNION ALL
SELECT 442, 1 UNION ALL
SELECT 443, 1 UNION ALL
SELECT 444, 1 UNION ALL
SELECT 445, 1 UNION ALL
SELECT 446, 1 UNION ALL
SELECT 447, 1 UNION ALL
SELECT 448, 1 UNION ALL
SELECT 449, 1 UNION ALL
SELECT 450, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 9.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 451, 1 UNION ALL
SELECT 452, 1 UNION ALL
SELECT 453, 1 UNION ALL
SELECT 454, 1 UNION ALL
SELECT 455, 1 UNION ALL
SELECT 456, 1 UNION ALL
SELECT 457, 1 UNION ALL
SELECT 458, 1 UNION ALL
SELECT 459, 1 UNION ALL
SELECT 460, 1 UNION ALL
SELECT 461, 1 UNION ALL
SELECT 462, 1 UNION ALL
SELECT 463, 1 UNION ALL
SELECT 464, 1 UNION ALL
SELECT 465, 1 UNION ALL
SELECT 466, 1 UNION ALL
SELECT 467, 1 UNION ALL
SELECT 468, 1 UNION ALL
SELECT 469, 1 UNION ALL
SELECT 470, 1 UNION ALL
SELECT 471, 1 UNION ALL
SELECT 472, 1 UNION ALL
SELECT 473, 1 UNION ALL
SELECT 474, 1 UNION ALL
SELECT 475, 1 UNION ALL
SELECT 476, 1 UNION ALL
SELECT 477, 1 UNION ALL
SELECT 478, 1 UNION ALL
SELECT 479, 1 UNION ALL
SELECT 480, 1 UNION ALL
SELECT 481, 1 UNION ALL
SELECT 482, 1 UNION ALL
SELECT 483, 1 UNION ALL
SELECT 484, 1 UNION ALL
SELECT 485, 1 UNION ALL
SELECT 486, 1 UNION ALL
SELECT 487, 1 UNION ALL
SELECT 488, 1 UNION ALL
SELECT 489, 1 UNION ALL
SELECT 490, 1 UNION ALL
SELECT 491, 1 UNION ALL
SELECT 492, 1 UNION ALL
SELECT 493, 1 UNION ALL
SELECT 494, 1 UNION ALL
SELECT 495, 1 UNION ALL
SELECT 496, 1 UNION ALL
SELECT 497, 1 UNION ALL
SELECT 498, 1 UNION ALL
SELECT 499, 1 UNION ALL
SELECT 500, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 10.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 501, 1 UNION ALL
SELECT 502, 1 UNION ALL
SELECT 503, 1 UNION ALL
SELECT 504, 1 UNION ALL
SELECT 505, 1 UNION ALL
SELECT 506, 1 UNION ALL
SELECT 507, 1 UNION ALL
SELECT 508, 1 UNION ALL
SELECT 509, 1 UNION ALL
SELECT 510, 1 UNION ALL
SELECT 511, 1 UNION ALL
SELECT 512, 1 UNION ALL
SELECT 513, 1 UNION ALL
SELECT 514, 1 UNION ALL
SELECT 515, 1 UNION ALL
SELECT 516, 1 UNION ALL
SELECT 517, 1 UNION ALL
SELECT 518, 1 UNION ALL
SELECT 519, 1 UNION ALL
SELECT 520, 1 UNION ALL
SELECT 521, 1 UNION ALL
SELECT 522, 1 UNION ALL
SELECT 523, 1 UNION ALL
SELECT 524, 1 UNION ALL
SELECT 525, 1 UNION ALL
SELECT 526, 1 UNION ALL
SELECT 527, 1 UNION ALL
SELECT 528, 1 UNION ALL
SELECT 529, 1 UNION ALL
SELECT 530, 1 UNION ALL
SELECT 531, 1 UNION ALL
SELECT 532, 1 UNION ALL
SELECT 533, 1 UNION ALL
SELECT 534, 1 UNION ALL
SELECT 535, 1 UNION ALL
SELECT 536, 1 UNION ALL
SELECT 537, 1 UNION ALL
SELECT 538, 1 UNION ALL
SELECT 539, 1 UNION ALL
SELECT 540, 1 UNION ALL
SELECT 541, 1 UNION ALL
SELECT 542, 1 UNION ALL
SELECT 543, 1 UNION ALL
SELECT 544, 1 UNION ALL
SELECT 545, 1 UNION ALL
SELECT 546, 1 UNION ALL
SELECT 547, 1 UNION ALL
SELECT 548, 1 UNION ALL
SELECT 549, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 11.....Done!', 10, 1) WITH NOWAIT;

END
GO 

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

IF OBJECT_ID('[dbo].[Game]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[Game](
			[GameID]				[int] IDENTITY(1,1) NOT NULL,
			[Title]					[nvarchar](255) NULL,
			[IsPrivate]				[bit] NOT NULL,
			[Passphrase]			[nvarchar](100) NULL,
			[PointsToWin]			[int] NOT NULL,
			[MaxNumberOfPlayers]	[int] NOT NULL,
			[GameCreator_UserId]	[int] NOT NULL,
			[DateCreated]			[datetime] NOT NULL,
			[PlayedLast]			[datetime] NULL,
			[GameOver]				[datetime] NULL,
			[AnswerShuffleCount]	[int] NOT NULL,
			[QuestionShuffleCount]	[int] NOT NULL,
		 CONSTRAINT [PK_dbo.Game] PRIMARY KEY CLUSTERED 
		(
			[GameID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((6)) FOR [MaxNumberOfPlayers]
		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((8)) FOR [PointsToWin]
		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((1)) FOR [AnswerShuffleCount]
		ALTER TABLE [dbo].[Game] ADD  DEFAULT ((1)) FOR [QuestionShuffleCount]
		ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Game_dbo.UserProfile_GameCreator_UserId] FOREIGN KEY([GameCreator_UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])
		ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_dbo.Game_dbo.UserProfile_GameCreator_UserId]
	END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'AnswerShuffleCount' 
				AND Object_ID = Object_ID(N'Game'))
BEGIN
    ALTER TABLE [dbo].[Game] ADD [AnswerShuffleCount] [int] NOT NULL DEFAULT 1	
END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'QuestionShuffleCount' 
				AND Object_ID = Object_ID(N'Game'))
BEGIN
    ALTER TABLE [dbo].[Game] ADD [QuestionShuffleCount] [int] NOT NULL DEFAULT 1
END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'MaxNumberOfSpectators' 
				AND Object_ID = Object_ID(N'Game'))
BEGIN
    ALTER TABLE [dbo].[Game] ADD [MaxNumberOfSpectators] [int] NOT NULL DEFAULT 0
END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'SecondsToPlay' 
				AND Object_ID = Object_ID(N'Game'))
BEGIN
    ALTER TABLE [dbo].[Game] ADD [SecondsToPlay] [int] NOT NULL DEFAULT -1
END
GO 

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
	@SecondsToPlay			int			  = -1,
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
		   ,[MaxNumberOfSpectators]
		   ,[SecondsToPlay])
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
		   @MaxNumberOfSpectators,
		   @SecondsToPlay
	
	SET @NewID = @@IDENTITY

	INSERT INTO [dbo].[GameDeck]
				(GameID, 
				DeckID)
	SELECT		@NewID,
				ids.id.value('@value', 'int')
	FROM		@GameDeckIDs.nodes('ids/id') AS ids ( id )

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[Game_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Game_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new User
-- ===============================================
CREATE PROC [dbo].[Game_Select]
	@GameID			int			  =	NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

    SELECT	G.[GameID],
			G.[Title],
			G.[IsPrivate],
			G.[Passphrase],
			G.[PointsToWin],
			G.[MaxNumberOfPlayers],
			G.[GameCreator_UserId],
			G.[DateCreated],
			G.[PlayedLast],
			G.[GameOver],
			G.[AnswerShuffleCount],
			G.[QuestionShuffleCount],
			G.[SecondsToPlay],
			(SELECT COUNT(UserID) 
			 FROM [dbo].[GamePlayer] GP
			 WHERE GP.[GameID] = G.[GameID]
			 AND   GP.[Type] = 1) AS PlayerCount,
			(SELECT COUNT([Game_GameID]) 
			 FROM [dbo].[GameRound] GR
			 WHERE GR.[Game_GameID] = G.[GameID]) AS RoundCount,
			G.MaxNumberOfSpectators,
			(SELECT COUNT(UserID) 
			 FROM [dbo].[GamePlayer] GP
			 WHERE GP.[GameID] = G.[GameID]
			 AND   GP.[Type] = 2) AS SpectatorCount
	 FROM [dbo].[Game] G
	 WHERE (G.[GameID] = @GameID OR @GameID IS NULL)
	 AND    G.[GameOver] IS NULL
	 ORDER BY G.[PlayedLast] DESC

	COMMIT
GO

GO 

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

IF OBJECT_ID('[dbo].[Game_Update]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[Game_Update] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/03/2013
-- Description:	Update the game record
-- ===============================================
CREATE PROC [dbo].[Game_Update] 
	@GameID					int,
	@PlayedLast				datetime,
	@GameOver				datetime  =	NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Game]
	SET [GameOver] = @GameOver,
		[PlayedLast] = @PlayedLast
	WHERE [GameID] = @GameID

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GameDeck]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[GameDeck](
			[GameID] [int] NOT NULL,
			[DeckID] [int] NOT NULL,
		 CONSTRAINT [PK_dbo.GameDeck] PRIMARY KEY CLUSTERED 
		(
			[GameID] ASC,
			[DeckID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[GameDeck]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GameDeck_dbo.Deck_DeckID] FOREIGN KEY([DeckID])
		REFERENCES [dbo].[Deck] ([DeckID])
		ON DELETE CASCADE

		ALTER TABLE [dbo].[GameDeck] CHECK CONSTRAINT [FK_dbo.GameDeck_dbo.Deck_DeckID]

		ALTER TABLE [dbo].[GameDeck]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GameDeck_dbo.Game_GameID] FOREIGN KEY([GameID])
		REFERENCES [dbo].[Game] ([GameID])
		ON DELETE CASCADE

		ALTER TABLE [dbo].[GameDeck] CHECK CONSTRAINT [FK_dbo.GameDeck_dbo.Game_GameID]
	END
GO 

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

IF OBJECT_ID('[dbo].[GamePlayer]') IS NULL
	BEGIN
		CREATE TABLE [dbo].[GamePlayer](
			[GameID]		[int] NOT NULL,
			[UserId]		[int] NOT NULL,
			[Points]		[int] NOT NULL,
			[JoinDate]		[datetime] NOT NULL,
			[Type]			[int] NOT NULL
		 CONSTRAINT [PK_dbo.GamePlayer] PRIMARY KEY CLUSTERED 
		(
			[GameID] ASC,
			[UserId] ASC,
			[Type]   ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[GamePlayer] ADD  DEFAULT ((0)) FOR [Points]
		ALTER TABLE [dbo].[GamePlayer] ADD  DEFAULT ((1)) FOR [Type]

		ALTER TABLE [dbo].[GamePlayer]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GamePlayer_dbo.Game_GameID] FOREIGN KEY([GameID])
		REFERENCES [dbo].[Game] ([GameID])
		ON DELETE CASCADE

		ALTER TABLE [dbo].[GamePlayer] CHECK CONSTRAINT [FK_dbo.GamePlayer_dbo.Game_GameID]

		ALTER TABLE [dbo].[GamePlayer]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GamePlayer_dbo.UserProfile_UserId] FOREIGN KEY([UserId])
		REFERENCES [dbo].[UserProfile] ([UserId])

		ALTER TABLE [dbo].[GamePlayer] CHECK CONSTRAINT [FK_dbo.GamePlayer_dbo.UserProfile_UserId]
	END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'Type' 
				AND Object_ID = Object_ID(N'GamePlayer'))
BEGIN
    ALTER TABLE [dbo].[GamePlayer] ADD [Type] [int] NOT NULL DEFAULT 1
END

IF NOT EXISTS(	SELECT * 
				FROM sys.columns 
				WHERE Name = N'IdlePlayCount' 
				AND Object_ID = Object_ID(N'GamePlayer'))
BEGIN
    ALTER TABLE [dbo].[GamePlayer] ADD [IdlePlayCount] [int] NOT NULL DEFAULT 0
END
GO 

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

			DELETE
			FROM [dbo].[GamePlayer] 
			WHERE [GameID] = @GameID 
			AND   [UserId] = @UserId
			AND   [Type]   = @Type

		END
		
		IF @Type = 1
			BEGIN
				DELETE
				FROM [dbo].[GamePlayerCard]
				WHERE [GameID] = @GameID AND [UserId] = @UserId
			END

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GamePlayer_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 8/26/2013
-- Description:	Creates a new game player
-- ===============================================
CREATE PROC [dbo].[GamePlayer_Insert] 
	@GameID			int,
	@UserId			int,
	@Points			int,
	@JoinDate		datetime,
	@Type			int,
	@IdlePlayCount  int,
	@TotalPlayers	int OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	DECLARE @maxPlayers INT

	INSERT INTO [dbo].[GamePlayer]
	(
		GameID,
		UserId,
		Points,
		JoinDate,
		Type,
		IdlePlayCount
	)
	SELECT	@GameID,
			@UserId,
			@Points,
			@JoinDate,
			@Type,
			@IdlePlayCount

	SELECT @TotalPlayers = COUNT(UserId) 
	FROM [dbo].[GamePlayer] GP
	WHERE GP.[GameID] = @GameID
	AND	  GP.[Type]	  = @Type

	SELECT @maxPlayers = 
			CASE WHEN @Type = 1
				THEN
					G.[MaxNumberOfPlayers]
				ELSE 
					G.[MaxNumberOfSpectators]
				END
	FROM [dbo].[Game] G
	WHERE G.[GameID] = @GameID

	IF @TotalPlayers > @maxPlayers
		BEGIN
			SET @TotalPlayers = -1

			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			COMMIT TRAN
		END
GO
GO 

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
	ORDER BY GP.[JoinDate] ASC

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GamePlayer_SelectForUser]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_SelectForUser] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/06/2013
-- Description:	Select all for a user
-- ===============================================
CREATE PROC [dbo].[GamePlayer_SelectForUser]
	@UserId			int,
	@Type			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

    SELECT	G.[GameID],
			G.[Title],
			G.[IsPrivate],
			G.[GameOver],
			GP.[Points],
			GP.[GameID],
			GP.[UserId],
			GP.[JoinDate],
			GP.[Type],
			GP.[IdlePlayCount]
	 FROM [dbo].[GamePlayer] GP
	 INNER JOIN [dbo].[Game] G ON G.[GameID] = GP.[GameID]
	 WHERE GP.[UserId] = @UserId
	 AND   GP.[Type]   = @Type

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GamePlayer_UpdateIdlePlayCount]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_UpdateIdlePlayCount] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 2/8/2014
-- Description:	Update player idle play count
-- ===============================================
CREATE PROC [dbo].[GamePlayer_UpdateIdlePlayCount] 
	@GameID			int,
	@UserId			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN 

	UPDATE [dbo].[GamePlayer]
	SET IdlePlayCount = (IdlePlayCount + 1)
	WHERE	GameID = @GameID
	AND		UserId = @UserId
	AND		Type   = 1

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GamePlayer_UpdatePoints]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayer_UpdatePoints] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/28/2013
-- Description:	Update player points
-- ===============================================
CREATE PROC [dbo].[GamePlayer_UpdatePoints] 
	@GameID			int,
	@UserId			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	UPDATE [dbo].[GamePlayer]
	SET Points = (Points + 1)
	WHERE	GameID = @GameID
	AND		UserId = @UserId
	AND		Type   = 1

	DECLARE @pointScale int

	--Selects the scale for winning one round
	SELECT @pointScale = LPS.Value
	FROM dbo.LeaderboardPointScale LPS
	WHERE LPS.LeaderboardPointScaleID = 4

	UPDATE [dbo].[Leaderboard]
	SET Points = (Points + (1 *@pointScale))
	WHERE [UserId] = @UserId

	COMMIT
GO
GO 

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
GO 

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

IF OBJECT_ID('[dbo].[GamePlayerCard_Delete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayerCard_Delete] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/19/2013
-- Description:	Delete GamePlayerCards
-- ===============================================
CREATE PROC [dbo].[GamePlayerCard_Delete]
	@GameID			int,
	@UserId			int,
	@CardIDs		XML
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	DELETE
	FROM [dbo].[GamePlayerCard]
	WHERE [CardID] IN (SELECT ids.id.value('@value', 'int')
					   FROM	 @CardIDs.nodes('ids/id') AS ids ( id ))
	AND [GameID] = @GameID
	AND [UserId] = @UserId

	COMMIT
GO

GO 

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

IF OBJECT_ID('[dbo].[GamePlayerCard_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayerCard_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/19/2013
-- Description:	Select GamePlayerCards
-- ===============================================
CREATE PROC [dbo].[GamePlayerCard_Select]
	@GameID			int,
	@UserId			int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT	GPC.[CardID],
			GPC.[GameID],
			GPC.[UserId],
			C.[Content],
			C.[Instructions],
			C.[Type],
			C.[CreatedBy_UserId]
	FROM [dbo].[GamePlayerCard] GPC
	INNER JOIN [dbo].[Card] C ON C.[CardID] = GPC.[CardID]
	WHERE	GPC.[GameID] = @GameID
	AND		(GPC.[UserId] = @UserId OR @UserId IS NULL)

	COMMIT
GO

GO 

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
IF OBJECT_ID('[dbo].[GameRound]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[GameRound](
		[GameRoundID]			[int] IDENTITY(1,1) NOT NULL,
		[Started]				[datetime] NOT NULL,
		[Game_GameID]			[int] NOT NULL,
		[CardCommander_UserId]	[int] NOT NULL,
	 CONSTRAINT [PK_dbo.GameRound] PRIMARY KEY CLUSTERED 
	(
		[GameRoundID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[GameRound]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GameRound_dbo.UserProfile_CardCommander_UserId] FOREIGN KEY([CardCommander_UserId])
	REFERENCES [dbo].[UserProfile] ([UserId])

	ALTER TABLE [dbo].[GameRound] CHECK CONSTRAINT [FK_dbo.GameRound_dbo.UserProfile_CardCommander_UserId]

	ALTER TABLE [dbo].[GameRound]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GameRound_dbo.Game_Game_GameID] FOREIGN KEY([Game_GameID])
	REFERENCES [dbo].[Game] ([GameID])
	ON DELETE CASCADE

	ALTER TABLE [dbo].[GameRound] CHECK CONSTRAINT [FK_dbo.GameRound_dbo.Game_Game_GameID]

	END
GO 

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

IF OBJECT_ID('[dbo].[GameRound_Delete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_Delete] 
END 
GO

-- =====================================================
-- Author:		Kevin McRell
-- Create date: 10/02/2013
-- Description:	Delete a round and all the cards played
-- ======================================================
CREATE PROC [dbo].[GameRound_Delete] 
	@GameRoundID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM [dbo].[GameRoundCard]
	WHERE [GameRound_GameRoundID] = @GameRoundID

	DELETE
	FROM [dbo].[GameRound]
	WHERE [GameRoundID] = @GameRoundID

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GameRound_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/15/2013
-- Description:	Creates a new game round
-- ===============================================
CREATE PROC [dbo].[GameRound_Insert] 
	@Started				datetime,
	@Game_GameID			int,
	@CardCommander_UserId	int,
	@NewID					int				OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	DECLARE @maxPlayers INT

	INSERT INTO [dbo].[GameRound]
	(
		[Started],
		[Game_GameID],
		[CardCommander_UserId]
	)
	SELECT	@Started,
			@Game_GameID,
			@CardCommander_UserId

	SET @NewID = @@IDENTITY

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GameRound_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/16/2013
-- Description:	Selects rounds based on game id
-- ===============================================
CREATE PROC [dbo].[GameRound_Select] 
	@GameID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT	GR.[GameRoundID],
			GR.[Started],
			GR.[Game_GameID],
			GR.[CardCommander_UserId] AS UserId,
			UP.[UserName],
			UP.[PictureUrl],
			C.[CardID],
			C.[Content],
			C.[Instructions],
			C.[Type],
			C.[CreatedBy_UserId]
	FROM [dbo].[GameRound] GR
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = GR.[CardCommander_UserId]
	INNER JOIN [dbo].[GameRoundCard] GRC ON GRC.[GameRound_GameRoundID] = GR.[GameRoundID]
	INNER JOIN [dbo].[Card] C ON C.[CardID] = GRC.[Card_CardID] AND C.[Type] = 0
	WHERE GR.[Game_GameID] = @GameID

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GameRound_SelectCompleted]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_SelectCompleted] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 3/2/2014
-- Description:	Selects completed rounds based on game id
-- ===============================================
CREATE PROC [dbo].[GameRound_SelectCompleted] 
	@GameID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT DISTINCT	GR.[GameRoundID],
					GR.[Started],
					GR.[Game_GameID],
					UP.[UserId],
					UP.[UserName]
	FROM [dbo].[GameRound] GR
	INNER JOIN [dbo].[GameRoundCard] GRC ON GRC.[GameRound_GameRoundID] = GR.[GameRoundID] 
										AND GRC.[Winner] = 1
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = GRC.[PlayedBy_UserId]
	WHERE GR.[Game_GameID] = @GameID
	ORDER BY GR.[GameRoundID] DESC

	COMMIT
GO
GO 

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

IF OBJECT_ID('[dbo].[GameRound_SelectCurrent]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRound_SelectCurrent] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/16/2013
-- Description:	Selects current round based on game id
-- ===============================================
CREATE PROC [dbo].[GameRound_SelectCurrent] 
	@GameID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT TOP 1	GR.[GameRoundID],
					GR.[Started],
					GR.[Game_GameID],
					GR.[CardCommander_UserId] AS UserId,
					UP.[UserName],
					UP.[PictureUrl],
					C.[CardID],
					C.[Content],
					C.[Instructions],
					C.[Type],
					C.[CreatedBy_UserId],
					(
						SELECT COUNT(DISTINCT GPC.[UserId])
						FROM [dbo].[GamePlayerCard] GPC
						WHERE GPC.[GameID] = @GameID
						AND	  GPC.[UserId] <> GR.[CardCommander_UserId]
					) AS CurrentPlayers,
					(
						SELECT COUNT(DISTINCT GRC2.[PlayedBy_UserId])
						FROM [dbo].[GameRoundCard] GRC2
						WHERE GRC2.[GameRound_GameRoundID] = GR.[GameRoundID]
						AND	  GRC2.[PlayedBy_UserId] <> GR.[CardCommander_UserId]
					) AS Played
	FROM [dbo].[GameRound] GR
	INNER JOIN [dbo].[UserProfile] UP ON UP.[UserId] = GR.[CardCommander_UserId]
	INNER JOIN [dbo].[GameRoundCard] GRC ON GRC.[GameRound_GameRoundID] = GR.[GameRoundID]
	INNER JOIN [dbo].[Card] C ON C.[CardID] = GRC.[Card_CardID] AND C.[Type] = 0
	WHERE GR.[Game_GameID] = @GameID 
	ORDER BY GR.[GameRoundID] DESC

	COMMIT
GO
GO 

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
GO 

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

IF OBJECT_ID('[dbo].[GameRoundCard_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GameRoundCard_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 9/19/2013
-- Description:	Select GameRoundCard
-- ===============================================
CREATE PROC [dbo].[GameRoundCard_Select]
	@GameRoundID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	SELECT	GRC.[Card_CardID] AS CardID,
			GRC.[DatePlayed],
			GRC.[Game_GameID],
			GRC.[GameRound_GameRoundID],
			GRC.[GameRoundCardID],
			GRC.[PlayedBy_UserId],
			GRC.[PlayOrder],
			GRC.[Winner],
			GRC.[AutoPlayed],
			C.[Content],
			C.[Instructions],
			C.[Type],
			C.[CreatedBy_UserId],
			UP.[UserId],
			UP.[UserName],
			UP.[PictureUrl]
	FROM [dbo].[GameRoundCard] GRC
	INNER JOIN [dbo].[Card] C ON C.[CardID] = GRC.[Card_CardID]
	INNER JOIN [dbo].[UserProfile] UP ON GRC.[PlayedBy_UserId] = UP.[UserId]
	WHERE	GRC.[GameRound_GameRoundID] = @GameRoundID

	COMMIT
GO

GO 

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
GO 

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

IF OBJECT_ID('[dbo].[GamePlayerKickVote]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[GamePlayerKickVote](
		[GameID]		[int] NOT NULL,
		[KickUserId]	[int] NOT NULL,
		[VotedUserId]	[int] NOT NULL,
		[Vote]			[bit] NOT NULL,
	 CONSTRAINT [PK_dbo.GamePlayerKickVote] PRIMARY KEY CLUSTERED 
	(
		[GameID] ASC,
		[KickUserId] ASC,
		[VotedUserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[GamePlayerKickVote]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerKickVote_dbo.UserProfile_KickUserId] FOREIGN KEY([KickUserId])
	REFERENCES [dbo].[UserProfile] ([UserId])

	ALTER TABLE [dbo].[GamePlayerKickVote] CHECK CONSTRAINT [FK_dbo.GamePlayerKickVote_dbo.UserProfile_KickUserId]
	
	ALTER TABLE [dbo].[GamePlayerKickVote]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerKickVote_dbo.UserProfile_VotedUserId] FOREIGN KEY([VotedUserId])
	REFERENCES [dbo].[UserProfile] ([UserId])

	ALTER TABLE [dbo].[GamePlayerKickVote] CHECK CONSTRAINT [FK_dbo.GamePlayerKickVote_dbo.UserProfile_VotedUserId]

	ALTER TABLE [dbo].[GamePlayerKickVote]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo.GamePlayerKickVote_dbo.Game_GameID] FOREIGN KEY([GameID])
	REFERENCES [dbo].[Game] ([GameID])
END
GO 

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
	@VotesToKick	int OUTPUT,
	@TotalPlayers   int OUTPUT
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

	SELECT @TotalPlayers = COUNT(GP.[UserId])
	FROM [GamePlayer] GP
	WHERE GP.[GameID] = @GameID
	AND	  GP.[Type]   = 1
	
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
GO 

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

IF OBJECT_ID('[dbo].[GamePlayerKickVote_Select]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayerKickVote_Select] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/16/2013
-- Description:	Select all votes to kick a user
-- ===============================================
CREATE PROC [dbo].[GamePlayerKickVote_Select] 
	@GameID			int,
	@KickUserId		int,
	@PlayerType		int,
	@TotalPlayers	int output
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 
	
	SELECT @TotalPlayers = COUNT(GP.[UserId])
	FROM [GamePlayer] GP
	WHERE GP.[GameID] = @GameID
	AND	  GP.[Type]   = @PlayerType

	SELECT	GPKV.[GameID],
			GPKV.[KickUserId],
			GPKV.[Vote],
			GPKV.[VotedUserId]
	FROM [GamePlayerKickVote] GPKV
	WHERE GPKV.[GameID] = @GameID 
	AND GPKV.[KickUserId] = @KickUserId

	DELETE
	FROM [GamePlayerKickVote]
	WHERE [GameID] = @GameID 
	AND [KickUserId] = @KickUserId

	COMMIT TRAN
		
GO
GO 

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

IF OBJECT_ID('[dbo].[GamePlayerKickVote_SelectForGame]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[GamePlayerKickVote_SelectForGame] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 10/19/2013
-- Description:	Select all votes to kick users in a game
-- ===============================================
CREATE PROC [dbo].[GamePlayerKickVote_SelectForGame] 
	@GameID			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN 

	SELECT	GPKV.[GameID],
			GPKV.[KickUserId],
			GPKV.[Vote],
			GPKV.[VotedUserId]
	FROM [GamePlayerKickVote] GPKV
	WHERE GPKV.[GameID] = @GameID

	COMMIT TRAN
		
GO
GO 

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

IF OBJECT_ID('[dbo].[LeaderboardPointScale]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[LeaderboardPointScale](
		[LeaderboardPointScaleID]	[int] IDENTITY(1,1) NOT NULL,
		[Name]						[varchar](255) NOT NULL,
		[Value]						[int] NOT NULL,
	 CONSTRAINT [PK_dbo.LeaderboardPointScale] PRIMARY KEY CLUSTERED 
	(
		[LeaderboardPointScaleID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS (	SELECT LPS.LeaderboardPointScaleID
			FROM dbo.LeaderboardPointScale LPS
			WHERE LPS.[LeaderboardPointScaleID] = 1
		  )
	BEGIN
		INSERT INTO dbo.LeaderboardPointScale
		(
			Name,
			Value
		)
				SELECT 'Won Round',				5
		UNION	SELECT 'Won Game',				15
		UNION	SELECT 'Card Votes',			5
		UNION	SELECT 'Card Selected For Deck',100 
	END
GO 

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

IF OBJECT_ID('[dbo].[Leaderboard]') IS NULL
	BEGIN

	CREATE TABLE [dbo].[Leaderboard](
		[LeaderboardID]				[bigint] IDENTITY(1,1) NOT NULL,
		[UserId]					[int] NOT NULL,
		[Points]					[bigint] NOT NULL,
	 CONSTRAINT [PK_dbo.Leaderboard] PRIMARY KEY CLUSTERED 
	(
		[LeaderboardID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[Leaderboard] ADD  DEFAULT ((0)) FOR [Points]

	ALTER TABLE [dbo].[Leaderboard] WITH NOCHECK ADD  CONSTRAINT [FK_dbo.Leaderboard_dbo.UserProfile_UserId] FOREIGN KEY([UserId])
	REFERENCES [dbo].[UserProfile] ([UserId])
END
GO 

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

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

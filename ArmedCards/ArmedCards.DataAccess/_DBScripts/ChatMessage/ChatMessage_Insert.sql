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

IF OBJECT_ID('[dbo].[ChatMessage_Insert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[ChatMessage_Insert] 
END 
GO

-- ==============================================
-- Author:		Kevin McRell
-- Create date: 7/11/2014
-- Description:	Creates a new chat message
-- ===============================================
CREATE PROC [dbo].[ChatMessage_Insert] 
			@SentByUserId			int,
			@SentByUserName			nvarchar(56),
			@Message				nvarchar(max),
			@DateSent				datetime,
			@GameID					int = NULL,
			@Global					bit,
			@ConnectionType			int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	INSERT INTO [dbo].[ChatMessage]
           ([SentByUserId],
			[SentByUserName],
			[Message],
			[DateSent],
			[GameID],
			[Global],
			[ConnectionType])
     SELECT
            @SentByUserId	,
			@SentByUserName	,
			@Message		,
			@DateSent		,
			@GameID			,
			@Global			,
			@ConnectionType	

	COMMIT
GO

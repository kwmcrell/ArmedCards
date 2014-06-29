IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 1011)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 1011,N'25 shitty jokes about House of Cards.', 1, 0, 1 UNION ALL
	SELECT 1012,N'An origami swan thatâs some kind of symbol?', 1, 0, 1 UNION ALL
	SELECT 1013,N'A homoerotic subplot.', 1, 0, 1 UNION ALL
	SELECT 1014,N'Forcing a handjob on a dying man.', 1, 0, 1 UNION ALL
	SELECT 1015,N'Ribs so good they transcend race and class.', 1, 0, 1 UNION ALL
	SELECT 1016,N'The sensitive European photographer who''s fucking my wife.', 1, 0, 1 UNION ALL
	SELECT 1017,N'Carbon monoxide poisoning.', 1, 0, 1 UNION ALL
	SELECT 1018,N'Discharging a firearm in a residential area.', 1, 0, 1 UNION ALL
	SELECT 1019,N'Getting eaten out while on the phone with Dad.', 1, 0, 1 UNION ALL
	SELECT 1020,N'Making it look like a suicide.', 1, 0, 1 UNION ALL
	SELECT 1021,N'A much younger woman.', 1, 0, 1 UNION ALL
	SELECT 1022,N'An older man.', 1, 0, 1 UNION ALL
	SELECT 1023,N'Strangling a dog to make a point to the audience.', 1, 0, 1 UNION ALL
	SELECT 1024,N'A childless marriage.', 1, 0, 1 UNION ALL
	SELECT 1025,N'My constituents.', 1, 0, 1 UNION ALL
	SELECT 1026,N'Punching a congressman in the face.', 1, 0, 1 UNION ALL
	SELECT 1027,N'I can''t believe Netflix is using _____ to promote House of Cards.', 0, 0, 1 UNION ALL
	SELECT 1028,N'I''m not going to lie. I despise _____. There, I said it.', 0, 0, 1 UNION ALL
	SELECT 1029,N'A wise man said, "Everything is about sex. Except sex. Sex is about _____."', 0, 0, 1 UNION ALL
	SELECT 1030,N'Corruption. Betrayal. _____. Coming soon to Netflix, "House of _____."', 0, 1, 1 UNION ALL
	SELECT 1031,N'Our relationship is strictly professional. Let''s not complicate things with _____.', 0, 0, 1 UNION ALL
	SELECT 1032,N'Because you enjoyed _____, we thought you''d like _____.', 0, 1, 1 UNION ALL
	SELECT 1033,N'We''re not like other news organizations. Here at Slugline, we welcome _____ in the office.', 0, 0, 1 UNION ALL
	SELECT 1034,N'Cancel all my meetings. We''ve got a situation with _____ that requires my immediate attention.', 0, 0, 1 UNION ALL
	SELECT 1035,N'If you need him to, Remy Danton can pull some strings and get you _____, but it''ll cost you.', 0, 0, 1			

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Holiday House Of Cards Against Hummanity', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

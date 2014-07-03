IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 950)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 950,N'Santa''s heavy sack.', 1, 0, 1 UNION ALL
	SELECT 951,N'Clearing a bloody path through Walmart with a scimitar.', 1, 0, 1 UNION ALL
	SELECT 952,N'Another shitty year.', 1, 0, 1 UNION ALL
	SELECT 953,N'Whatever Kwanzaa is supposed to be about.', 1, 0, 1 UNION ALL
	SELECT 954,N'A Christmas stocking full of coleslaw.', 1, 0, 1 UNION ALL
	SELECT 955,N'Elf cum.', 1, 0, 1 UNION ALL
	SELECT 956,N'The tiny, calloused hands of the Chinese children that made this card.', 1, 0, 1 UNION ALL
	SELECT 957,N'Taking down Santa with a surface-to-air missle.', 1, 0, 1 UNION ALL
	SELECT 958,N'Socks.', 1, 0, 1 UNION ALL
	SELECT 959,N'Pretending to be happy.', 1, 0, 1 UNION ALL
	SELECT 960,N'Krampus, the Austrian Christmas monster.', 1, 0, 1 UNION ALL
	SELECT 961,N'The Star Wars Holiday Special.', 1, 0, 1 UNION ALL
	SELECT 962,N'My hot cousin.', 1, 0, 1 UNION ALL
	SELECT 963,N'Mall Santa.', 1, 0, 1 UNION ALL
	SELECT 964,N'Several intertwining love stories featuring Hugh Grant.', 1, 0, 1 UNION ALL
	SELECT 965,N'A Hungry-Man™ Frozen Christmas Dinner for One.', 1, 0, 1 UNION ALL
	SELECT 966,N'Gift-wrapping a live hamster.', 1, 0, 1 UNION ALL
	SELECT 967,N'Space Jam on VHS.', 1, 0, 1 UNION ALL
	SELECT 968,N'Immaculate conception.', 1, 0, 1 UNION ALL
	SELECT 969,N'Fucking up "Silent Night" in front of 300 parents.', 1, 0, 1 UNION ALL
	SELECT 970,N'A visually arresting turtleneck.', 1, 0, 1 UNION ALL
	SELECT 971,N'A toxic family environment.', 1, 0, 1 UNION ALL
	SELECT 972,N'Eating an entire snowman.', 1, 0, 1 UNION ALL
	SELECT 973,N'After blacking out during New Year''s Eve, I was awoken by _____.', 0, 0, 1 UNION ALL
	SELECT 974,N'This holiday season, Tim Allen must overcome his fear of _____ to save Christmas.', 0, 0, 1 UNION ALL
	SELECT 975,N'Jesus is _____.', 0, 0, 1 UNION ALL
	SELECT 976,N'Every Christmas, my uncle gets drunk and tells the story about _____.', 0, 0, 1 UNION ALL
	SELECT 978,N'What keeps me warm during the cold, cold winter?', 0, 0, 1 UNION ALL
	SELECT 979,N'On the third day of Christmas, my true love gave to me: three French hens, two turtle doves, and _____.', 0, 0, 1 UNION ALL
	SELECT 980,N'Wake up, America. Christmas is under attack by secular liberals and their _____.', 0, 0, 1

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Holiday Pack 2012', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

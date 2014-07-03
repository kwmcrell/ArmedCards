IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 981)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 981 , N'Giving money and personal information to strangers on the Internet.', 1, 0, 1 UNION ALL
	SELECT 982 , N'A magical tablet containing a world of unlimited pornography.', 1, 0, 1 UNION ALL
	SELECT 983 , N'These low, low prices!', 1, 0, 1 UNION ALL
	SELECT 984 , N'Piece of shit Christmas cards with no money in them.', 1, 0, 1 UNION ALL
	SELECT 985 , N'Moses gargling Jesus''s balls while Shiva and the Buddha penetrate his divine hand holes.', 1, 0, 1 UNION ALL
	SELECT 986 , N'The Hawaiian goddess Kapo and her flying detachable vagina.', 1, 0, 1 UNION ALL
	SELECT 987 , N'The shittier, Jewish version of Christmas.', 1, 0, 1 UNION ALL
	SELECT 988 , N'Making up for 10 years of shitty parenting with a PlayStation.', 1, 0, 1 UNION ALL
	SELECT 989 , N'Swapping bodies with mom for a day.', 1, 0, 1 UNION ALL
	SELECT 990 , N'Slicing a ham in icy silence.', 1, 0, 1 UNION ALL
	SELECT 991 , N'Finding out that Santa isn''t real.', 1, 0, 1 UNION ALL
	SELECT 992 , N'Rudolph''s bright red balls.', 1, 0, 1 UNION ALL
	SELECT 993 , N'The Grinch''s musty, cum-stained pelt.', 1, 0, 1 UNION ALL
	SELECT 994 , N'Breeding elves for their priceless semen.', 1, 0, 1 UNION ALL
	SELECT 995 , N'Jizzing into Santa''s beard.', 1, 0, 1 UNION ALL
	SELECT 996 , N'A simultaneous nightmare and wet dream starring Sigourney Weaver.', 1, 0, 1 UNION ALL
	SELECT 997 , N'Being blind and deaf and having no limbs.', 1, 0, 1 UNION ALL
	SELECT 998 , N'People with cake in their mouths talking about how good cake is.', 1, 0, 1 UNION ALL
	SELECT 999 , N'Congress''s flaccid penises withering away beneath their suit pants.', 1, 0, 1 UNION ALL
	SELECT 1000, N'The royal afterbirth.', 1, 0, 1 UNION ALL
	SELECT 1001, N'Having a strong opinion about Obamacare.', 1, 0, 1 UNION ALL
	SELECT 1002, N'But wait, there''s more! If you order _____ in the next 15 minutes, we''ll throw in _____ absolutely free!', 0, 1, 1 UNION ALL
	SELECT 1003, N'Blessed are you, Lord our God, creator of the universe, who has granted us _____.', 0, 0, 1 UNION ALL
	SELECT 1004, N'Because they are forbidden from masturbating, Mormons channel their repressed sexual energy into _____.', 0, 0, 1 UNION ALL
	SELECT 1005, N'I really hope my grandmother doesn''t ask me to explain _____ again.', 0, 0, 1 UNION ALL
	SELECT 1006,N'What''s the one thing that makes an elf instantly ejaculate?', 0, 0, 1 UNION ALL
	SELECT 1007,N'GREETINGS HUMANS <br /> I AM _____ BOT <br /> EXECUTING PROGRAM', 0, 0, 1 UNION ALL
	SELECT 1008,N'Kids these days with their iPods and their Internet. In my day, all we needed to pass the time was _____.', 0, 0, 1 UNION ALL
	SELECT 1009,N'Revealed: <br /> Why He Really Resigned! <br /> Pope Benedict''s Secret Struggle with _____!', 0, 0, 1 UNION ALL
	SELECT 1010,N'Here''s what you can expect for the new year. <br /> Out: _____. <br /> In: _____.', 0, 1, 1

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Holiday Bullshit 2013', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

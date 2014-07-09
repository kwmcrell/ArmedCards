IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 750)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 750,N'The primal, ball-slapping sex your parents are having right now.', 1, 0, 1 UNION ALL
	SELECT 751,N'A cat video so cute that your eyes roll back and your spine slides out of your anus.', 1, 0, 1 UNION ALL
	SELECT 752,N'Cock.', 1, 0, 1 UNION ALL
	SELECT 753,N'A cop who is also a dog.', 1, 0, 1 UNION ALL
	SELECT 754,N'Dying alone and in pain.', 1, 0, 1 UNION ALL
	SELECT 755,N'Gay aliens.', 1, 0, 1 UNION ALL
	SELECT 756,N'The way white people is.', 1, 0, 1 UNION ALL
	SELECT 757,N'Reverse cowgirl.', 1, 0, 1 UNION ALL
	SELECT 758,N'The Quesadilla Explosion Salad™ from Chili''s®.', 1, 0, 1 UNION ALL
	SELECT 759,N'Actually getting shot, for real.', 1, 0, 1 UNION ALL
	SELECT 760,N'Not having sex.', 1, 0, 1 UNION ALL
	SELECT 761,N'Vietnam flashbacks.', 1, 0, 1 UNION ALL
	SELECT 762,N'Running naked through a mall, pissing and shitting everywhere.', 1, 0, 1 UNION ALL
	SELECT 763,N'Nothing.', 1, 0, 1 UNION ALL
	SELECT 764,N'Warm, velvety muppet sex.', 1, 0, 1 UNION ALL
	SELECT 765,N'Self-flagellation.', 1, 0, 1 UNION ALL
	SELECT 766,N'The systematic destruction of an entire people and their way of life.', 1, 0, 1 UNION ALL
	SELECT 767,N'Samuel L. Jackson.', 1, 0, 1 UNION ALL
	SELECT 768,N'A boo-boo.', 1, 0, 1 UNION ALL
	SELECT 769,N'Going around punching people.', 1, 0, 1 UNION ALL
	SELECT 770,N'The entire Internet.', 1, 0, 1 UNION ALL
	SELECT 771,N'Some kind of bird-man.', 1, 0, 1 UNION ALL
	SELECT 772,N'Chugging a lava lamp.', 1, 0, 1 UNION ALL
	SELECT 773,N'Having sex on top of a pizza.', 1, 0, 1 UNION ALL
	SELECT 774,N'Indescribable loneliness.', 1, 0, 1 UNION ALL
	SELECT 775,N'An ass disaster.', 1, 0, 1 UNION ALL
	SELECT 776,N'Shutting the fuck up.', 1, 0, 1 UNION ALL
	SELECT 777,N'All my friends dying.', 1, 0, 1 UNION ALL
	SELECT 778,N'Putting an entire peanut butter and jelly sandwich into the VCR.', 1, 0, 1 UNION ALL
	SELECT 779,N'Spending lots of money.', 1, 0, 1 UNION ALL
	SELECT 780,N'Some douche with an acoustic guitar.', 1, 0, 1 UNION ALL
	SELECT 781,N'Flying robots that kill people.', 1, 0, 1 UNION ALL
	SELECT 782,N'A greased-up Matthew McConaughey.', 1, 0, 1 UNION ALL
	SELECT 783,N'An unstoppable wave of fire ants.', 1, 0, 1 UNION ALL
	SELECT 784,N'Not contributing to society in any meaningful way.', 1, 0, 1 UNION ALL
	SELECT 785,N'An all-midget production of Shakespeare''s Richard III.', 1, 0, 1 UNION ALL
	SELECT 786,N'Screaming like a maniac.', 1, 0, 1 UNION ALL
	SELECT 787,N'The moist, demanding chasm of his mouth.', 1, 0, 1 UNION ALL
	SELECT 788,N'Filling every orifice with butterscotch pudding.', 1, 0, 1 UNION ALL
	SELECT 789,N'Unlimited soup, salad, and breadsticks.', 1, 0, 1 UNION ALL
	SELECT 790,N'Crying into the pages of Sylvia Plath.', 1, 0, 1 UNION ALL
	SELECT 791,N'Velcro™.', 1, 0, 1 UNION ALL
	SELECT 792,N'A PowerPoint presentation.', 1, 0, 1 UNION ALL
	SELECT 793,N'A surprising amount of hair.', 1, 0, 1 UNION ALL
	SELECT 794,N'Eating Tom Selleck''s mustache to gain his powers.', 1, 0, 1 UNION ALL
	SELECT 795,N'Roland the Farter, flatulist to the king.', 1, 0, 1 UNION ALL
	SELECT 796,N'That ass.', 1, 0, 1 UNION ALL
	SELECT 797,N'A pile of squirming bodies.', 1, 0, 1 UNION ALL
	SELECT 798,N'Buying the right pants to be cool.', 1, 0, 1 UNION ALL
	SELECT 799,N'Blood farts.', 1, 0, 1 UNION ALL
	SELECT 800,N'Three months in the hole.', 1, 0, 1 UNION ALL
	SELECT 801,N'A botched circumcision.', 1, 0, 1 UNION ALL
	SELECT 802,N'The Land of Chocolate.', 1, 0, 1 UNION ALL
	SELECT 803,N'Slapping a racist old lady.', 1, 0, 1 UNION ALL
	SELECT 804,N'A lamprey swimming up the toilet and latching onto your taint.', 1, 0, 1 UNION ALL
	SELECT 805,N'Jumping out at people.', 1, 0, 1 UNION ALL
	SELECT 806,N'A black male in his early 20s, last seen wearing a hoodie.', 1, 0, 1 UNION ALL
	SELECT 807,N'Mufasa''s death scene.', 1, 0, 1 UNION ALL
	SELECT 808,N'Bill Clinton, naked on a bearskin rug with a saxophone.', 1, 0, 1 UNION ALL
	SELECT 809,N'Demonic possession.', 1, 0, 1 UNION ALL
	SELECT 810,N'The Harlem Globetrotters.', 1, 0, 1 UNION ALL
	SELECT 811,N'Vomiting mid-blowjob.', 1, 0, 1 UNION ALL
	SELECT 812,N'My manservant, Claude.', 1, 0, 1 UNION ALL
	SELECT 813,N'Having shotguns for legs.', 1, 0, 1 UNION ALL
	SELECT 814,N'Letting everyone down.', 1, 0, 1 UNION ALL
	SELECT 815,N'A spontaneous conga line.', 1, 0, 1 UNION ALL
	SELECT 816,N'A vagina that leads to another dimension.', 1, 0, 1 UNION ALL
	SELECT 817,N'Disco fever.', 1, 0, 1 UNION ALL
	SELECT 818,N'Getting your dick stuck in a Chinese finger trap with another dick.', 1, 0, 1 UNION ALL
	SELECT 819,N'Fisting.', 1, 0, 1 UNION ALL
	SELECT 820,N'The thin veneer of situational causality that underlies porn.', 1, 0, 1 UNION ALL
	SELECT 821,N'Girls that always be textin''.', 1, 0, 1 UNION ALL
	SELECT 822,N'Blowing some dudes in an alley.', 1, 0, 1 UNION ALL
	SELECT 823,N'Drinking ten 5-hour ENERGYs® to get fifty continuous hours of energy.', 1, 0, 1 UNION ALL
	SELECT 824,N'Sneezing, farting, and coming at the same time.', 1, 0, 1 UNION ALL
	SELECT 825,N'_____: Hours of fun. Easy to use. Perfect for _____!', 0, 1, 1 UNION ALL
	SELECT 826,N'Turns out that _____-Man was neither the hero we needed nor wanted.', 0, 0, 1 UNION ALL
	SELECT 827,N'What left this stain on my couch?', 0, 0, 1 UNION ALL
	SELECT 828,N'Call the law offices of Goldstein & Goldstein, because no one should have to tolerate _____ in the workplace.', 0, 0, 1 UNION ALL
	SELECT 829,N'A successful job interview begins with a firm handshake and ends with _____.', 0, 0, 1 UNION ALL
	SELECT 830,N'Lovin'' you is easy ''cause you''re _____.', 0, 0, 1 UNION ALL
	SELECT 831,N'Money can''t buy me love, but it can buy me _____.', 0, 0, 1 UNION ALL
	SELECT 832,N'Listen, son. If you want to get involved with _____, I won''t stop you. Just steer clear of _____.', 0, 1, 1 UNION ALL
	SELECT 833,N'During high school, I never really fit in until I found _____ club.', 0, 0, 1 UNION ALL
	SELECT 834,N'Hey baby, come back to my place and I''ll show you _____.', 0, 0, 1 UNION ALL
	SELECT 835,N'My life is ruled by a vicious cycle of _____ and _____.', 0, 1, 1 UNION ALL
	SELECT 836,N'To prepare for his upcoming role, Daniel Day-Lewis immersed himself in the world of _____.', 0, 0, 1 UNION ALL
	SELECT 837,N'Finally! A service that delivers _____ right to your door.', 0, 0, 1 UNION ALL
	SELECT 838,N'My gym teacher got fired for adding _____ to the obstacle course.', 0, 0, 1 UNION ALL
	SELECT 839,N'When you get right down to it, _____ is just _____.', 0, 1, 1 UNION ALL
	SELECT 840,N'As part of his daily regimen, Anderson Cooper sets aside 15 minutes for _____.', 0, 0, 1 UNION ALL
	SELECT 841,N'In the seventh circle of Hell, sinners must endure _____ for all eternity.', 0, 0, 1 UNION ALL
	SELECT 842,N'After months of practice with _____, I think I''m finally ready for _____.', 0, 1, 1 UNION ALL
	SELECT 843,N'The blind date was going horribly until we discovered our shared interest in _____.', 0, 0, 1 UNION ALL
	SELECT 844,N'_____. Awesome in theory, kind of a mess in practice.', 0, 0, 1 UNION ALL
	SELECT 845,N'With enough time and pressure, _____ will turn into _____.', 0, 1, 1 UNION ALL
	SELECT 846,N'I''m not like the rest of you. I''m too rich and busy for _____.', 0, 0, 1 UNION ALL
	SELECT 847,N'And what did you bring for show and tell?', 0, 0, 1 UNION ALL
	SELECT 848,N'Having problems with _____? Try _____!', 0, 1, 1 UNION ALL
	SELECT 849,N'As part of his contract, Prince won''t perform without _____ in his dressing room.', 0, 0, 1
	
	COMMIT;

	RAISERROR (N'[dbo].[Card]: Insert Batch: Expansion 3', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

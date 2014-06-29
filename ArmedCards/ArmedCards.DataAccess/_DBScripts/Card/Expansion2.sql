IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 650)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 650,N'A bigger, blacker dick.', 1, 0, 1 UNION ALL
	SELECT 651,N'The mere concept of Applebee''s®.', 1, 0, 1 UNION ALL
	SELECT 652,N'A sad fat dragon with no friends.', 1, 0, 1 UNION ALL
	SELECT 653,N'Catastrophic urethral trauma.', 1, 0, 1 UNION ALL
	SELECT 654,N'Hillary Clinton''s death stare.', 1, 0, 1 UNION ALL
	SELECT 655,N'Existing.', 1, 0, 1 UNION ALL
	SELECT 656,N'A piñata full of scorpions.', 1, 0, 1 UNION ALL
	SELECT 657,N'Mooing.', 1, 0, 1 UNION ALL
	SELECT 658,N'Swiftly achieving orgasm.', 1, 0, 1 UNION ALL
	SELECT 659,N'Daddy''s belt.', 1, 0, 1 UNION ALL
	SELECT 660,N'Double penetration.', 1, 0, 1 UNION ALL
	SELECT 661,N'Weapons-grade plutonium.', 1, 0, 1 UNION ALL
	SELECT 662,N'Some really fucked-up shit.', 1, 0, 1 UNION ALL
	SELECT 663,N'Subduing a grizzly bear and making her your wife.', 1, 0, 1 UNION ALL
	SELECT 664,N'Rising from the grave.', 1, 0, 1 UNION ALL
	SELECT 665,N'The mixing of the races.', 1, 0, 1 UNION ALL
	SELECT 666,N'Taking a man''s eyes and balls out and putting his eyes where his balls go and then his balls in the eye holes.', 1, 0, 1 UNION ALL
	SELECT 667,N'Scrotal frostbite.', 1, 0, 1 UNION ALL
	SELECT 668,N'All of this blood.', 1, 0, 1 UNION ALL
	SELECT 669,N'Loki, the trickster god.', 1, 0, 1 UNION ALL
	SELECT 670,N'Whining like a little bitch.', 1, 0, 1 UNION ALL
	SELECT 671,N'Pumping out a baby every nine months.', 1, 0, 1 UNION ALL
	SELECT 672,N'Tongue.', 1, 0, 1 UNION ALL
	SELECT 673,N'Finding Waldo.', 1, 0, 1 UNION ALL
	SELECT 674,N'Upgrading homeless people to mobile hotspots.', 1, 0, 1 UNION ALL
	SELECT 675,N'Wearing an octopus for a hat.', 1, 0, 1 UNION ALL
	SELECT 676,N'An unhinged ferris wheel rolling toward the sea.', 1, 0, 1 UNION ALL
	SELECT 677,N'Living in a trashcan.', 1, 0, 1 UNION ALL
	SELECT 678,N'The corporations.', 1, 0, 1 UNION ALL
	SELECT 679,N'A magic hippie love cloud.', 1, 0, 1 UNION ALL
	SELECT 680,N'Fuck Mountain.', 1, 0, 1 UNION ALL
	SELECT 681,N'Survivor''s guilt.', 1, 0, 1 UNION ALL
	SELECT 682,N'Me.', 1, 0, 1 UNION ALL
	SELECT 683,N'Getting hilariously gang-banged by the Blue Man Group.', 1, 0, 1 UNION ALL
	SELECT 684,N'Jeff Goldblum.', 1, 0, 1 UNION ALL
	SELECT 685,N'Making a friend.', 1, 0, 1 UNION ALL
	SELECT 686,N'A soulful rendition of "Ol'' Man River."', 1, 0, 1 UNION ALL
	SELECT 687,N'Intimacy problems.', 1, 0, 1 UNION ALL
	SELECT 688,N'A sweaty, panting leather daddy.', 1, 0, 1 UNION ALL
	SELECT 689,N'Spring break!', 1, 0, 1 UNION ALL
	SELECT 690,N'Being awesome at sex.', 1, 0, 1 UNION ALL
	SELECT 691,N'Dining with cardboard cutouts of the cast of "Friends."', 1, 0, 1 UNION ALL
	SELECT 692,N'Another shot of morphine.', 1, 0, 1 UNION ALL
	SELECT 693,N'Beefin'' over turf.', 1, 0, 1 UNION ALL
	SELECT 694,N'A squadron of moles wearing aviator goggles.', 1, 0, 1 UNION ALL
	SELECT 695,N'Bullshit.', 1, 0, 1 UNION ALL
	SELECT 696,N'The Google.', 1, 0, 1 UNION ALL
	SELECT 697,N'Pretty Pretty Princess Dress-Up Board Game®.', 1, 0, 1 UNION ALL
	SELECT 698,N'The new Radiohead album.', 1, 0, 1 UNION ALL
	SELECT 699,N'An army of skeletons.', 1, 0, 1 UNION ALL
	SELECT 700,N'A man in yoga pants with a ponytail and feather earrings.', 1, 0, 1 UNION ALL
	SELECT 701,N'Mild autism.', 1, 0, 1 UNION ALL
	SELECT 702,N'Nunchuck moves.', 1, 0, 1 UNION ALL
	SELECT 703,N'Whipping a disobedient slave.', 1, 0, 1 UNION ALL
	SELECT 704,N'An ether-soaked rag.', 1, 0, 1 UNION ALL
	SELECT 705,N'A sweet spaceship.', 1, 0, 1 UNION ALL
	SELECT 706,N'A 55-gallon drum of lube.', 1, 0, 1 UNION ALL
	SELECT 707,N'Special musical guest, Cher.', 1, 0, 1 UNION ALL
	SELECT 708,N'The human body.', 1, 0, 1 UNION ALL
	SELECT 709,N'Boris the Soviet Love Hammer.', 1, 0, 1 UNION ALL
	SELECT 710,N'The grey nutrient broth that sustains Mitt Romney.', 1, 0, 1 UNION ALL
	SELECT 711,N'Tiny nipples.', 1, 0, 1 UNION ALL
	SELECT 712,N'Power.', 1, 0, 1 UNION ALL
	SELECT 713,N'Oncoming traffic.', 1, 0, 1 UNION ALL
	SELECT 714,N'A dollop of sour cream.', 1, 0, 1 UNION ALL
	SELECT 715,N'A slightly shittier parallel universe.', 1, 0, 1 UNION ALL
	SELECT 716,N'My first kill.', 1, 0, 1 UNION ALL
	SELECT 717,N'Graphic violence, adult language, and some sexual content.', 1, 0, 1 UNION ALL
	SELECT 718,N'Fetal alcohol syndrome.', 1, 0, 1 UNION ALL
	SELECT 719,N'The day the birds attacked.', 1, 0, 1 UNION ALL
	SELECT 720,N'One Ring to rule them all.', 1, 0, 1 UNION ALL
	SELECT 721,N'Grandpa''s ashes.', 1, 0, 1 UNION ALL
	SELECT 722,N'Basic human decency.', 1, 0, 1 UNION ALL
	SELECT 723,N'A Burmese tiger pit.', 1, 0, 1 UNION ALL
	SELECT 724,N'Death by Steven Seagal.', 1, 0, 1 UNION ALL
	SELECT 725,N'During his midlife crisis, my dad got really into _____.', 0, 0, 1 UNION ALL
	SELECT 726,N'_____ would be woefully incomplete without _____.', 0, 1, 1 UNION ALL
	SELECT 727,N'My new favorite porn star is Joey "_____" McGee.', 0, 0, 1 UNION ALL
	SELECT 728,N'Before I run for president, I must destroy all evidence of my involvement with _____.', 0, 0, 1 UNION ALL
	SELECT 729,N'This is your captain speaking. Fasten your seatbelts and prepare for _____.', 0, 0, 1 UNION ALL
	SELECT 730,N'In his newest and most difficult stunt, David Blaine must escape from _____.', 0, 0, 1 UNION ALL
	SELECT 731,N'The Five Stages of Grief: denial, anger, bargaining, _____, acceptance.', 0, 0, 1 UNION ALL
	SELECT 732,N'My mom freaked out when she looked at my browser history and found _____.com/_____.', 0, 1, 1 UNION ALL
	SELECT 733,N'I went from _____ to _____, all thanks to _____.', 0, 2, 1 UNION ALL
	SELECT 734,N'Members of New York''s social elite are paying thousands of dollars just to experience _____.', 0, 0, 1 UNION ALL
	SELECT 735,N'This month''s Cosmo: "Spice up your sex life by bringing _____ into the bedroom."', 0, 0, 1 UNION ALL
	SELECT 736,N'Little Miss Muffet Sat on a tuffet, Eating her curds and _____.', 0, 0, 1 UNION ALL
	SELECT 737,N'If God didn''t want us to enjoy _____, he wouldn''t have given us _____.', 0, 1, 1 UNION ALL
	SELECT 738,N'My country, ''tis of thee, sweet land of _____.', 0, 0, 1 UNION ALL
	SELECT 739,N'After months of debate, the Occupy Wall Street General Assembly could only agree on "More _____!"', 0, 0, 1 UNION ALL
	SELECT 740,N'I spent my whole life working toward _____, only to have it ruined by _____.', 0, 1, 1 UNION ALL
	SELECT 741,N'Next time on Dr. Phil: How to talk to your child about _____.', 0, 0, 1 UNION ALL
	SELECT 742,N'Only two things in life are certain: death and _____.', 0, 0, 1 UNION ALL
	SELECT 743,N'Everyone down on the ground! We don''t want to hurt anyone. We''re just here for _____.', 0, 0, 1 UNION ALL
	SELECT 744,N'The healing process began when I joined a support group for victims of _____.', 0, 0, 1 UNION ALL
	SELECT 745,N'The votes are in, and the new high school mascot is _____.', 0, 0, 1 UNION ALL
	SELECT 746,N'Charades was ruined for me forever when my mom had to act out _____.', 0, 0, 1 UNION ALL
	SELECT 747,N'Before _____, all we had was _____.', 0, 1, 1 UNION ALL
	SELECT 748,N'Tonight on 20/20: What you don''t know about _____ could kill you.', 0, 0, 1 UNION ALL
	SELECT 749,N'You haven''t truly lived until you''ve experienced _____ and _____ at the same time.', 0, 1, 1

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Expansion 2', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

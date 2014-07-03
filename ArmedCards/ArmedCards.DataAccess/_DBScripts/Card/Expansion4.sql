IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 850)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 850,N'A bunch of idiots playing a card game instead of interacting like normal humans.', 1, 0, 1 UNION ALL
	SELECT 851,N'A sex goblin with a carnival penis.', 1, 0, 1 UNION ALL
	SELECT 852,N'Lots and lots of abortions.', 1, 0, 1 UNION ALL
	SELECT 853,N'Injecting speed into one arm and horse tranquilizer into the other.', 1, 0, 1 UNION ALL
	SELECT 854,N'Sharks with legs.', 1, 0, 1 UNION ALL
	SELECT 855,N'A sex comet from Neptune that plunges the Earth into eternal sexiness.', 1, 0, 1 UNION ALL
	SELECT 856,N'How awesome I am.', 1, 0, 1 UNION ALL
	SELECT 857,N'Smoking crack, for instance.', 1, 0, 1 UNION ALL
	SELECT 858,N'A dance move that''s just sex.', 1, 0, 1 UNION ALL
	SELECT 859,N'A hopeless amount of spiders.', 1, 0, 1 UNION ALL
	SELECT 860,N'Drinking responsibly.', 1, 0, 1 UNION ALL
	SELECT 861,N'Angelheaded hipsters burning for the ancient heavenly connection to the starry dynamo in the machinery of night.', 1, 0, 1 UNION ALL
	SELECT 862,N'Bouncing up and down.', 1, 0, 1 UNION ALL
	SELECT 863,N'A shiny rock that proves I love you.', 1, 0, 1 UNION ALL
	SELECT 864,N'Crazy opium eyes.', 1, 0, 1 UNION ALL
	SELECT 865,N'Moderate-to-severe joint pain.', 1, 0, 1 UNION ALL
	SELECT 866,N'Finally finishing off the Indians.', 1, 0, 1 UNION ALL
	SELECT 867,N'Actual mutants with medical conditions and no superpowers.', 1, 0, 1 UNION ALL
	SELECT 868,N'The complex geopolitical quagmire that is the Middle East.', 1, 0, 1 UNION ALL
	SELECT 869,N'Neil Diamond''s Greatest Hits.', 1, 0, 1 UNION ALL
	SELECT 870,N'No clothes on, penis in vagina.', 1, 0, 1 UNION ALL
	SELECT 871,N'Whispering all sexy.', 1, 0, 1 UNION ALL
	SELECT 872,N'A horse with no legs.', 1, 0, 1 UNION ALL
	SELECT 873,N'Depression.', 1, 0, 1 UNION ALL
	SELECT 874,N'Almost giving money to a homeless person.', 1, 0, 1 UNION ALL
	SELECT 875,N'Interspecies marriage.', 1, 0, 1 UNION ALL
	SELECT 876,N'Blackula.', 1, 0, 1 UNION ALL
	SELECT 877,N'What Jesus would do.', 1, 0, 1 UNION ALL
	SELECT 878,N'A manhole.', 1, 0, 1 UNION ALL
	SELECT 879,N'My dad''s dumb fucking face.', 1, 0, 1 UNION ALL
	SELECT 880,N'A Ugandan warlord.', 1, 0, 1 UNION ALL
	SELECT 881,N'My worthless son.', 1, 0, 1 UNION ALL
	SELECT 882,N'A Native American who solves crimes by going into the spirit world.', 1, 0, 1 UNION ALL
	SELECT 883,N'A kiss on the lips.', 1, 0, 1 UNION ALL
	SELECT 884,N'A fart.', 1, 0, 1 UNION ALL
	SELECT 885,N'The peaceful and nonthreatening rise of China.', 1, 0, 1 UNION ALL
	SELECT 886,N'Snorting coke off a clown''s boner.', 1, 0, 1 UNION ALL
	SELECT 887,N'Three consecutive seconds of happiness.', 1, 0, 1 UNION ALL
	SELECT 888,N'Falling into the toilet.', 1, 0, 1 UNION ALL
	SELECT 889,N'Ass to mouth.', 1, 0, 1 UNION ALL
	SELECT 890,N'Some sort of Asian.', 1, 0, 1 UNION ALL
	SELECT 891,N'The size of my penis.', 1, 0, 1 UNION ALL
	SELECT 892,N'The safe word.', 1, 0, 1 UNION ALL
	SELECT 893,N'Party Mexicans.', 1, 0, 1 UNION ALL
	SELECT 894,N'Ambiguous sarcasm.', 1, 0, 1 UNION ALL
	SELECT 895,N'Jizz.', 1, 0, 1 UNION ALL
	SELECT 896,N'An interracial handshake.', 1, 0, 1 UNION ALL
	SELECT 897,N'10 Incredible Facts About the Anus.', 1, 0, 1 UNION ALL
	SELECT 898,N'The secret formula for ultimate female satisfaction.', 1, 0, 1 UNION ALL
	SELECT 899,N'Sugar madness.', 1, 0, 1 UNION ALL
	SELECT 900,N'Calculating every mannerism so as not to suggest homosexuality.', 1, 0, 1 UNION ALL
	SELECT 901,N'Fucking a corpse back to life.', 1, 0, 1 UNION ALL
	SELECT 902,N'All the single ladies.', 1, 0, 1 UNION ALL
	SELECT 903,N'Whatever a McRib® is made of.', 1, 0, 1 UNION ALL
	SELECT 904,N'Africa.', 1, 0, 1 UNION ALL
	SELECT 905,N'The euphoric rush of strangling a drifter.', 1, 0, 1 UNION ALL
	SELECT 906,N'Khakis.', 1, 0, 1 UNION ALL
	SELECT 907,N'A gender identity that can only be conveyed through slam poetry.', 1, 0, 1 UNION ALL
	SELECT 908,N'Stuff a child''s face with Fun Dip® until he starts having fun.', 1, 0, 1 UNION ALL
	SELECT 909,N'A for-real lizard that spits blood from its eyes.', 1, 0, 1 UNION ALL
	SELECT 910,N'The tiniest shred of evidence that God is real.', 1, 0, 1 UNION ALL
	SELECT 911,N'Prince Ali, <br /> fabulous he, <br/> Ali Ababwa.', 1, 0, 1 UNION ALL
	SELECT 912,N'Dem titties.', 1, 0, 1 UNION ALL
	SELECT 913,N'Exploding pigeons.', 1, 0, 1 UNION ALL
	SELECT 914,N'My sex dungeon.', 1, 0, 1 UNION ALL
	SELECT 915,N'Child Protective Services.', 1, 0, 1 UNION ALL
	SELECT 916,N'Doo-doo.', 1, 0, 1 UNION ALL
	SELECT 917,N'Sports.', 1, 0, 1 UNION ALL
	SELECT 918,N'Unquestioning obedience.', 1, 0, 1 UNION ALL
	SELECT 919,N'Grammar nazis who are also regular Nazis.', 1, 0, 1 UNION ALL
	SELECT 920,N'What''s fun until it gets weird?', 0, 0, 1 UNION ALL
	SELECT 921,N'In the beginning, there was _____. <br /> And the Lord said, "Let there be _____."', 0, 1, 1 UNION ALL
	SELECT 922,N'Wes Anderson''s new film tells the story of a precocious child coming to terms with _____.', 0, 0, 1 UNION ALL
	SELECT 923,N'_____ will never be the same after _____.', 0, 1, 1 UNION ALL
	SELECT 924,N'I''m sorry, sir, but we don''t allow _____ at the country club.', 0, 0, 1 UNION ALL
	SELECT 925,N'How am I compensating for my tiny penis?', 0, 0, 1 UNION ALL
	SELECT 926,N'You''ve seen the bearded lady! <br /> You''ve seen the ring of fire! <br /> Now, ladies and gentlemen, feast your eyes upon _____!', 0, 0, 1 UNION ALL
	SELECT 927,N'We never did find _____, but along the way we sure learned a lot about _____.', 0, 1, 1 UNION ALL
	SELECT 928,N'She''s up all night for good fun. <br /> I''m up all night for _____.', 0, 0, 1 UNION ALL
	SELECT 929,N'_____ may pass, but _____ will last forever.', 0, 1, 1 UNION ALL
	SELECT 930,N'Dear Leader Kim Jong-un, <br /> our village praises your infinite wisdom with a humble offering of _____.', 0, 0, 1 UNION ALL
	SELECT 931,N'Man, this is bullshit. Fuck _____.', 0, 0, 1 UNION ALL
	SELECT 932,N'You guys, I saw this crazy movie last night. It opens on _____, and then there''s some stuff about _____, and then it ends with _____.', 0, 2, 1 UNION ALL
	SELECT 933,N'In return for my soul, the Devil promised me _____, but all I got was _____.', 0, 1, 1 UNION ALL
	SELECT 934,N'The Japanese have developed a smaller, more efficient version of _____.', 0, 0, 1 UNION ALL
	SELECT 935,N'Alright, bros. Our frat house is condemned, and all the hot slampieces are over at Gamma Phi. The time has come to commence Operation _____.', 0, 0, 1 UNION ALL
	SELECT 936,N'This is the prime of my life. I''m young, hot, and full of _____.', 0, 0, 1 UNION ALL
	SELECT 937,N'I''m pretty sure I''m high right now, because I''m absolutely mesmerized by _____.', 0, 0, 1 UNION ALL
	SELECT 938,N'It lurks in the night. It hungers for flesh. This summer, no one is safe from _____.', 0, 0, 1 UNION ALL
	SELECT 939,N'If you can''t handle _____, you''d better stay away from _____.', 0, 1, 1 UNION ALL
	SELECT 940,N'Forget everything you know about _____, because now we''ve supercharged it with _____!', 0, 1, 1 UNION ALL
	SELECT 941,N'Honey, I have a new role-play I want to try tonight! You can be _____, and I''ll be _____.', 0, 1, 1 UNION ALL
	SELECT 942,N'This year''s hottest album is "_____" by _____.', 0, 1, 1 UNION ALL
	SELECT 943,N'Every step towards _____ gets me a little closer to _____.', 0, 1, 1 UNION ALL
	SELECT 944,N'Oprah''s book of the month is "_____ For _____: A Story of Hope."', 0, 1, 1 UNION ALL
	SELECT 945,N'Do not fuck with me! I am literally _____ right now.', 0, 0, 1 UNION ALL
	SELECT 946,N'2 AM in the city that never sleeps. The door swings open and she walks in, legs up to here. Something in her eyes tells me she''s looking for _____.', 0, 0, 1 UNION ALL
	SELECT 947,N'As king, how will I keep the peasants in line?', 0, 0, 1 UNION ALL
	SELECT 948,N'Adventure. <br /> Romance. <br /> _____. <br /> From Paramount Pictures, "_____."', 0, 1, 1 UNION ALL
	SELECT 949,N'I am become _____, destroyer of _____!', 0, 1, 1

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Expansion 4', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

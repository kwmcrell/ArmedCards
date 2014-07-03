IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card] WHERE [CardID] = 550)
BEGIN

	SET IDENTITY_INSERT [dbo].[Card] ON;

	BEGIN TRANSACTION;

	INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
	SELECT 550,N'A big black dick.', 1, 0, 1 UNION ALL
	SELECT 551,N'A beached whale.', 1, 0, 1 UNION ALL
	SELECT 552,N'A bloody pacifier.', 1, 0, 1 UNION ALL
	SELECT 553,N'A crappy little hand.', 1, 0, 1 UNION ALL
	SELECT 554,N'A low standard of living.', 1, 0, 1 UNION ALL
	SELECT 555,N'A nuanced critique.', 1, 0, 1 UNION ALL
	SELECT 556,N'Panty raids.', 1, 0, 1 UNION ALL
	SELECT 557,N'A passionate Latino lover.', 1, 0, 1 UNION ALL
	SELECT 558,N'A rival dojo.', 1, 0, 1 UNION ALL
	SELECT 559,N'A web of lies.', 1, 0, 1 UNION ALL
	SELECT 560,N'A woman scorned.', 1, 0, 1 UNION ALL
	SELECT 561,N'Clams.', 1, 0, 1 UNION ALL
	SELECT 562,N'Apologizing.', 1, 0, 1 UNION ALL
	SELECT 563,N'Appreciative snapping.', 1, 0, 1 UNION ALL
	SELECT 564,N'Neil Patrick Harris.', 1, 0, 1 UNION ALL
	SELECT 565,N'Beating your wives.', 1, 0, 1 UNION ALL
	SELECT 566,N'Being a dinosaur.', 1, 0, 1 UNION ALL
	SELECT 567,N'Shaft.', 1, 0, 1 UNION ALL
	SELECT 568,N'Bosnian chicken farmers.', 1, 0, 1 UNION ALL
	SELECT 569,N'Nubile slave boys.', 1, 0, 1 UNION ALL
	SELECT 570,N'Carnies.', 1, 0, 1 UNION ALL
	SELECT 571,N'Coughing into a vagina.', 1, 0, 1 UNION ALL
	SELECT 572,N'Suicidal thoughts.', 1, 0, 1 UNION ALL
	SELECT 573,N'Dancing with a broom.', 1, 0, 1 UNION ALL
	SELECT 574,N'Deflowering the princess.', 1, 0, 1 UNION ALL
	SELECT 575,N'Dorito breath.', 1, 0, 1 UNION ALL
	SELECT 576,N'Eating an albino.', 1, 0, 1 UNION ALL
	SELECT 577,N'Enormous Scandinavian women.', 1, 0, 1 UNION ALL
	SELECT 578,N'Fabricating statistics.', 1, 0, 1 UNION ALL
	SELECT 579,N'Finding a skeleton.', 1, 0, 1 UNION ALL
	SELECT 580,N'Gandalf.', 1, 0, 1 UNION ALL
	SELECT 581,N'Genetically engineered super-soldiers.', 1, 0, 1 UNION ALL
	SELECT 582,N'George Clooney''s musk.', 1, 0, 1 UNION ALL
	SELECT 583,N'Getting abducted by Peter Pan.', 1, 0, 1 UNION ALL
	SELECT 584,N'Getting in her pants, politely.', 1, 0, 1 UNION ALL
	SELECT 585,N'Gladiatorial combat.', 1, 0, 1 UNION ALL
	SELECT 586,N'Good grammar.', 1, 0, 1 UNION ALL
	SELECT 587,N'Hipsters.', 1, 0, 1 UNION ALL
	SELECT 588,N'Historical revisionism.', 1, 0, 1 UNION ALL
	SELECT 589,N'Insatiable bloodlust.', 1, 0, 1 UNION ALL
	SELECT 590,N'Jafar.', 1, 0, 1 UNION ALL
	SELECT 591,N'Jean-Claude Van Damme.', 1, 0, 1 UNION ALL
	SELECT 592,N'Just the tip.', 1, 0, 1 UNION ALL
	SELECT 593,N'Mad hacky-sack skills.', 1, 0, 1 UNION ALL
	SELECT 594,N'Leveling up.', 1, 0, 1 UNION ALL
	SELECT 595,N'Literally eating shit.', 1, 0, 1 UNION ALL
	SELECT 596,N'Making the penises kiss.', 1, 0, 1 UNION ALL
	SELECT 597,N'Media coverage.', 1, 0, 1 UNION ALL
	SELECT 598,N'Medieval Times® Dinner & Tournament.', 1, 0, 1 UNION ALL
	SELECT 599,N'Moral ambiguity.', 1, 0, 1 UNION ALL
	SELECT 600,N'My machete.', 1, 0, 1 UNION ALL
	SELECT 601,N'One thousand Slim Jims.', 1, 0, 1 UNION ALL
	SELECT 602,N'Ominous background music.', 1, 0, 1 UNION ALL
	SELECT 603,N'Overpowering your father.', 1, 0, 1 UNION ALL
	SELECT 604,N'Pistol-whipping a hostage.', 1, 0, 1 UNION ALL
	SELECT 605,N'Quiche.', 1, 0, 1 UNION ALL
	SELECT 606,N'Quivering jowls.', 1, 0, 1 UNION ALL
	SELECT 607,N'Revenge fucking.', 1, 0, 1 UNION ALL
	SELECT 608,N'Ripping into a man''s chest and pulling out his still-beating heart.', 1, 0, 1 UNION ALL
	SELECT 609,N'Ryan Gosling riding in on a white horse.', 1, 0, 1 UNION ALL
	SELECT 610,N'Santa Claus.', 1, 0, 1 UNION ALL
	SELECT 611,N'Scrotum tickling.', 1, 0, 1 UNION ALL
	SELECT 612,N'Sexual humiliation.', 1, 0, 1 UNION ALL
	SELECT 613,N'Sexy Siamese twins.', 1, 0, 1 UNION ALL
	SELECT 614,N'Slow motion.', 1, 0, 1 UNION ALL
	SELECT 615,N'Space muffins.', 1, 0, 1 UNION ALL
	SELECT 616,N'Statistically validated stereotypes.', 1, 0, 1 UNION ALL
	SELECT 617,N'Sudden Poop Explosion Disease.', 1, 0, 1 UNION ALL
	SELECT 618,N'The boners of the elderly.', 1, 0, 1 UNION ALL
	SELECT 619,N'The economy.', 1, 0, 1 UNION ALL
	SELECT 620,N'The Fanta® girls.', 1, 0, 1 UNION ALL
	SELECT 621,N'The Gulags.', 1, 0, 1 UNION ALL
	SELECT 622,N'The harsh light of day.', 1, 0, 1 UNION ALL
	SELECT 623,N'The hiccups.', 1, 0, 1 UNION ALL
	SELECT 624,N'The shambling corpse of Larry King.', 1, 0, 1 UNION ALL
	SELECT 625,N'The four arms of Vishnu.', 1, 0, 1 UNION ALL
	SELECT 626,N'Being a busy adult with many important things to do.', 1, 0, 1 UNION ALL
	SELECT 627,N'Tripping balls.', 1, 0, 1 UNION ALL
	SELECT 628,N'Words, words, words.', 1, 0, 1 UNION ALL
	SELECT 629,N'Zeus''s sexual appetites.', 1, 0, 1 UNION ALL
	SELECT 630,N'He who controls _____ controls the world.', 0, 0, 1 UNION ALL
	SELECT 631,N'The CIA now interrogates enemy agents by repeatedly subjecting them to _____.', 0, 0, 1 UNION ALL
	SELECT 632,N'Dear Sir or Madam, We regret to inform you that the Office of _____ has denied your request for _____.', 0, 1, 1 UNION ALL
	SELECT 633,N'In Rome, there are whisperings that the Vatican has a secret room devoted to _____.', 0, 0, 1 UNION ALL
	SELECT 634,N'Science will never explain the origin of _____.', 0, 0, 1 UNION ALL
	SELECT 635,N'When all else fails, I can always masturbate to _____.', 0, 0, 1 UNION ALL
	SELECT 636,N'I learned the hard way that you can''t cheer up a grieving friend with _____.', 0, 0, 1 UNION ALL
	SELECT 637,N'In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated _____.', 0, 0, 1 UNION ALL
	SELECT 638,N'An international tribunal has found _____ guilty of _____.', 0, 1, 1 UNION ALL
	SELECT 639,N'The socialist governments of Scandinavia have declared that access to _____ is a basic human right.', 0, 0, 1 UNION ALL
	SELECT 640,N'In his new self-produced album, Kanye West raps over the sounds of _____.', 0, 0, 1 UNION ALL
	SELECT 641,N'What''s the gift that keeps on giving?', 0, 0, 1 UNION ALL
	SELECT 642,N'This season on Man vs. Wild, Bear Grylls must survive in the depths of the Amazon with only _____ and his wits.', 0, 0, 1 UNION ALL
	SELECT 643,N'When I pooped, what came out of my butt?', 0, 0, 1 UNION ALL
	SELECT 644,N'In the distant future, historians will agree that _____ marked the beginning of America''s decline.', 0, 0, 1 UNION ALL
	SELECT 645,N'In a pinch, _____ can be a suitable substitute for _____.', 0, 1, 1 UNION ALL
	SELECT 646,N'What has been making life difficult at the nudist colony?', 0, 0, 1 UNION ALL
	SELECT 647,N'Michael Bay''s new three-hour action epic pits _____ against _____.', 0, 1, 1 UNION ALL
	SELECT 648,N'And I would have gotten away with it, too, if it hadn''t been for _____!', 0, 0, 1 UNION ALL
	SELECT 649,N'What brought the orgy to a grinding halt?', 0, 0, 1

	COMMIT;
	
	RAISERROR (N'[dbo].[Card]: Insert Batch: Expansion 1', 10, 1) WITH NOWAIT;

	SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

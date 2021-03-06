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
--First Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 550)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 550, 2 UNION ALL
	SELECT 551, 2 UNION ALL
	SELECT 552, 2 UNION ALL
	SELECT 553, 2 UNION ALL
	SELECT 554, 2 UNION ALL
	SELECT 555, 2 UNION ALL
	SELECT 556, 2 UNION ALL
	SELECT 557, 2 UNION ALL
	SELECT 558, 2 UNION ALL
	SELECT 559, 2 UNION ALL
	SELECT 560, 2 UNION ALL
	SELECT 561, 2 UNION ALL
	SELECT 562, 2 UNION ALL
	SELECT 563, 2 UNION ALL
	SELECT 564, 2 UNION ALL
	SELECT 565, 2 UNION ALL
	SELECT 566, 2 UNION ALL
	SELECT 567, 2 UNION ALL
	SELECT 568, 2 UNION ALL
	SELECT 569, 2 UNION ALL
	SELECT 570, 2 UNION ALL
	SELECT 571, 2 UNION ALL
	SELECT 572, 2 UNION ALL
	SELECT 573, 2 UNION ALL
	SELECT 574, 2 UNION ALL
	SELECT 575, 2 UNION ALL
	SELECT 576, 2 UNION ALL
	SELECT 577, 2 UNION ALL
	SELECT 578, 2 UNION ALL
	SELECT 579, 2 UNION ALL
	SELECT 580, 2 UNION ALL
	SELECT 581, 2 UNION ALL
	SELECT 582, 2 UNION ALL
	SELECT 583, 2 UNION ALL
	SELECT 584, 2 UNION ALL
	SELECT 585, 2 UNION ALL
	SELECT 586, 2 UNION ALL
	SELECT 587, 2 UNION ALL
	SELECT 588, 2 UNION ALL
	SELECT 589, 2 UNION ALL
	SELECT 590, 2 UNION ALL
	SELECT 591, 2 UNION ALL
	SELECT 592, 2 UNION ALL
	SELECT 593, 2 UNION ALL
	SELECT 594, 2 UNION ALL
	SELECT 595, 2 UNION ALL
	SELECT 596, 2 UNION ALL
	SELECT 597, 2 UNION ALL
	SELECT 598, 2 UNION ALL
	SELECT 599, 2 UNION ALL
	SELECT 600, 2 UNION ALL
	SELECT 601, 2 UNION ALL
	SELECT 602, 2 UNION ALL
	SELECT 603, 2 UNION ALL
	SELECT 604, 2 UNION ALL
	SELECT 605, 2 UNION ALL
	SELECT 606, 2 UNION ALL
	SELECT 607, 2 UNION ALL
	SELECT 608, 2 UNION ALL
	SELECT 609, 2 UNION ALL
	SELECT 610, 2 UNION ALL
	SELECT 611, 2 UNION ALL
	SELECT 612, 2 UNION ALL
	SELECT 613, 2 UNION ALL
	SELECT 614, 2 UNION ALL
	SELECT 615, 2 UNION ALL
	SELECT 616, 2 UNION ALL
	SELECT 617, 2 UNION ALL
	SELECT 618, 2 UNION ALL
	SELECT 619, 2 UNION ALL
	SELECT 620, 2 UNION ALL
	SELECT 621, 2 UNION ALL
	SELECT 622, 2 UNION ALL
	SELECT 623, 2 UNION ALL
	SELECT 624, 2 UNION ALL
	SELECT 625, 2 UNION ALL
	SELECT 626, 2 UNION ALL
	SELECT 627, 2 UNION ALL
	SELECT 628, 2 UNION ALL
	SELECT 629, 2 UNION ALL
	SELECT 630, 2 UNION ALL
	SELECT 631, 2 UNION ALL
	SELECT 632, 2 UNION ALL
	SELECT 633, 2 UNION ALL
	SELECT 634, 2 UNION ALL
	SELECT 635, 2 UNION ALL
	SELECT 636, 2 UNION ALL
	SELECT 637, 2 UNION ALL
	SELECT 638, 2 UNION ALL
	SELECT 639, 2 UNION ALL
	SELECT 640, 2 UNION ALL
	SELECT 641, 2 UNION ALL
	SELECT 642, 2 UNION ALL
	SELECT 643, 2 UNION ALL
	SELECT 644, 2 UNION ALL
	SELECT 645, 2 UNION ALL
	SELECT 646, 2 UNION ALL
	SELECT 647, 2 UNION ALL
	SELECT 648, 2 UNION ALL
	SELECT 649, 2
	
	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: First Expansion.....Done!', 10, 1) WITH NOWAIT;
END

--Second Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 650)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 650, 3 UNION ALL
	SELECT 651, 3 UNION ALL
	SELECT 652, 3 UNION ALL
	SELECT 653, 3 UNION ALL
	SELECT 654, 3 UNION ALL
	SELECT 655, 3 UNION ALL
	SELECT 656, 3 UNION ALL
	SELECT 657, 3 UNION ALL
	SELECT 658, 3 UNION ALL
	SELECT 659, 3 UNION ALL
	SELECT 660, 3 UNION ALL
	SELECT 661, 3 UNION ALL
	SELECT 662, 3 UNION ALL
	SELECT 663, 3 UNION ALL
	SELECT 664, 3 UNION ALL
	SELECT 665, 3 UNION ALL
	SELECT 666, 3 UNION ALL
	SELECT 667, 3 UNION ALL
	SELECT 668, 3 UNION ALL
	SELECT 669, 3 UNION ALL
	SELECT 670, 3 UNION ALL
	SELECT 671, 3 UNION ALL
	SELECT 672, 3 UNION ALL
	SELECT 673, 3 UNION ALL
	SELECT 674, 3 UNION ALL
	SELECT 675, 3 UNION ALL
	SELECT 676, 3 UNION ALL
	SELECT 677, 3 UNION ALL
	SELECT 678, 3 UNION ALL
	SELECT 679, 3 UNION ALL
	SELECT 680, 3 UNION ALL
	SELECT 681, 3 UNION ALL
	SELECT 682, 3 UNION ALL
	SELECT 683, 3 UNION ALL
	SELECT 684, 3 UNION ALL
	SELECT 685, 3 UNION ALL
	SELECT 686, 3 UNION ALL
	SELECT 687, 3 UNION ALL
	SELECT 688, 3 UNION ALL
	SELECT 689, 3 UNION ALL
	SELECT 690, 3 UNION ALL
	SELECT 691, 3 UNION ALL
	SELECT 692, 3 UNION ALL
	SELECT 693, 3 UNION ALL
	SELECT 694, 3 UNION ALL
	SELECT 695, 3 UNION ALL
	SELECT 696, 3 UNION ALL
	SELECT 697, 3 UNION ALL
	SELECT 698, 3 UNION ALL
	SELECT 699, 3 UNION ALL
	SELECT 700, 3 UNION ALL
	SELECT 701, 3 UNION ALL
	SELECT 702, 3 UNION ALL
	SELECT 703, 3 UNION ALL
	SELECT 704, 3 UNION ALL
	SELECT 705, 3 UNION ALL
	SELECT 706, 3 UNION ALL
	SELECT 707, 3 UNION ALL
	SELECT 708, 3 UNION ALL
	SELECT 709, 3 UNION ALL
	SELECT 710, 3 UNION ALL
	SELECT 711, 3 UNION ALL
	SELECT 712, 3 UNION ALL
	SELECT 713, 3 UNION ALL
	SELECT 714, 3 UNION ALL
	SELECT 715, 3 UNION ALL
	SELECT 716, 3 UNION ALL
	SELECT 717, 3 UNION ALL
	SELECT 718, 3 UNION ALL
	SELECT 719, 3 UNION ALL
	SELECT 720, 3 UNION ALL
	SELECT 721, 3 UNION ALL
	SELECT 722, 3 UNION ALL
	SELECT 723, 3 UNION ALL
	SELECT 724, 3 UNION ALL
	SELECT 725, 3 UNION ALL
	SELECT 726, 3 UNION ALL
	SELECT 727, 3 UNION ALL
	SELECT 728, 3 UNION ALL
	SELECT 729, 3 UNION ALL
	SELECT 730, 3 UNION ALL
	SELECT 731, 3 UNION ALL
	SELECT 732, 3 UNION ALL
	SELECT 733, 3 UNION ALL
	SELECT 734, 3 UNION ALL
	SELECT 735, 3 UNION ALL
	SELECT 736, 3 UNION ALL
	SELECT 737, 3 UNION ALL
	SELECT 738, 3 UNION ALL
	SELECT 739, 3 UNION ALL
	SELECT 740, 3 UNION ALL
	SELECT 741, 3 UNION ALL
	SELECT 742, 3 UNION ALL
	SELECT 743, 3 UNION ALL
	SELECT 744, 3 UNION ALL
	SELECT 745, 3 UNION ALL
	SELECT 746, 3 UNION ALL
	SELECT 747, 3 UNION ALL
	SELECT 748, 3 UNION ALL
	SELECT 749, 3

	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: Second Expansion.....Done!', 10, 1) WITH NOWAIT;
END

--Third Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 750)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 750, 4 UNION ALL
	SELECT 751, 4 UNION ALL
	SELECT 752, 4 UNION ALL
	SELECT 753, 4 UNION ALL
	SELECT 754, 4 UNION ALL
	SELECT 755, 4 UNION ALL
	SELECT 756, 4 UNION ALL
	SELECT 757, 4 UNION ALL
	SELECT 758, 4 UNION ALL
	SELECT 759, 4 UNION ALL
	SELECT 760, 4 UNION ALL
	SELECT 761, 4 UNION ALL
	SELECT 762, 4 UNION ALL
	SELECT 763, 4 UNION ALL
	SELECT 764, 4 UNION ALL
	SELECT 765, 4 UNION ALL
	SELECT 766, 4 UNION ALL
	SELECT 767, 4 UNION ALL
	SELECT 768, 4 UNION ALL
	SELECT 769, 4 UNION ALL
	SELECT 770, 4 UNION ALL
	SELECT 771, 4 UNION ALL
	SELECT 772, 4 UNION ALL
	SELECT 773, 4 UNION ALL
	SELECT 774, 4 UNION ALL
	SELECT 775, 4 UNION ALL
	SELECT 776, 4 UNION ALL
	SELECT 777, 4 UNION ALL
	SELECT 778, 4 UNION ALL
	SELECT 779, 4 UNION ALL
	SELECT 780, 4 UNION ALL
	SELECT 781, 4 UNION ALL
	SELECT 782, 4 UNION ALL
	SELECT 783, 4 UNION ALL
	SELECT 784, 4 UNION ALL
	SELECT 785, 4 UNION ALL
	SELECT 786, 4 UNION ALL
	SELECT 787, 4 UNION ALL
	SELECT 788, 4 UNION ALL
	SELECT 789, 4 UNION ALL
	SELECT 790, 4 UNION ALL
	SELECT 791, 4 UNION ALL
	SELECT 792, 4 UNION ALL
	SELECT 793, 4 UNION ALL
	SELECT 794, 4 UNION ALL
	SELECT 795, 4 UNION ALL
	SELECT 796, 4 UNION ALL
	SELECT 797, 4 UNION ALL
	SELECT 798, 4 UNION ALL
	SELECT 799, 4 UNION ALL
	SELECT 800, 4 UNION ALL
	SELECT 801, 4 UNION ALL
	SELECT 802, 4 UNION ALL
	SELECT 803, 4 UNION ALL
	SELECT 804, 4 UNION ALL
	SELECT 805, 4 UNION ALL
	SELECT 806, 4 UNION ALL
	SELECT 807, 4 UNION ALL
	SELECT 808, 4 UNION ALL
	SELECT 809, 4 UNION ALL
	SELECT 810, 4 UNION ALL
	SELECT 811, 4 UNION ALL
	SELECT 812, 4 UNION ALL
	SELECT 813, 4 UNION ALL
	SELECT 814, 4 UNION ALL
	SELECT 815, 4 UNION ALL
	SELECT 816, 4 UNION ALL
	SELECT 817, 4 UNION ALL
	SELECT 818, 4 UNION ALL
	SELECT 819, 4 UNION ALL
	SELECT 820, 4 UNION ALL
	SELECT 821, 4 UNION ALL
	SELECT 822, 4 UNION ALL
	SELECT 823, 4 UNION ALL
	SELECT 824, 4 UNION ALL
	SELECT 825, 4 UNION ALL
	SELECT 826, 4 UNION ALL
	SELECT 827, 4 UNION ALL
	SELECT 828, 4 UNION ALL
	SELECT 829, 4 UNION ALL
	SELECT 830, 4 UNION ALL
	SELECT 831, 4 UNION ALL
	SELECT 832, 4 UNION ALL
	SELECT 833, 4 UNION ALL
	SELECT 834, 4 UNION ALL
	SELECT 835, 4 UNION ALL
	SELECT 836, 4 UNION ALL
	SELECT 837, 4 UNION ALL
	SELECT 838, 4 UNION ALL
	SELECT 839, 4 UNION ALL
	SELECT 840, 4 UNION ALL
	SELECT 841, 4 UNION ALL
	SELECT 842, 4 UNION ALL
	SELECT 843, 4 UNION ALL
	SELECT 844, 4 UNION ALL
	SELECT 845, 4 UNION ALL
	SELECT 846, 4 UNION ALL
	SELECT 847, 4 UNION ALL
	SELECT 848, 4 UNION ALL
	SELECT 849, 4

	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: Third Expansion.....Done!', 10, 1) WITH NOWAIT;
END

--Fourth Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 850)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 850, 5 UNION ALL
	SELECT 851, 5 UNION ALL
	SELECT 852, 5 UNION ALL
	SELECT 853, 5 UNION ALL
	SELECT 854, 5 UNION ALL
	SELECT 855, 5 UNION ALL
	SELECT 856, 5 UNION ALL
	SELECT 857, 5 UNION ALL
	SELECT 858, 5 UNION ALL
	SELECT 859, 5 UNION ALL
	SELECT 860, 5 UNION ALL
	SELECT 861, 5 UNION ALL
	SELECT 862, 5 UNION ALL
	SELECT 863, 5 UNION ALL
	SELECT 864, 5 UNION ALL
	SELECT 865, 5 UNION ALL
	SELECT 866, 5 UNION ALL
	SELECT 867, 5 UNION ALL
	SELECT 868, 5 UNION ALL
	SELECT 869, 5 UNION ALL
	SELECT 870, 5 UNION ALL
	SELECT 871, 5 UNION ALL
	SELECT 872, 5 UNION ALL
	SELECT 873, 5 UNION ALL
	SELECT 874, 5 UNION ALL
	SELECT 875, 5 UNION ALL
	SELECT 876, 5 UNION ALL
	SELECT 877, 5 UNION ALL
	SELECT 878, 5 UNION ALL
	SELECT 879, 5 UNION ALL
	SELECT 880, 5 UNION ALL
	SELECT 881, 5 UNION ALL
	SELECT 882, 5 UNION ALL
	SELECT 883, 5 UNION ALL
	SELECT 884, 5 UNION ALL
	SELECT 885, 5 UNION ALL
	SELECT 886, 5 UNION ALL
	SELECT 887, 5 UNION ALL
	SELECT 888, 5 UNION ALL
	SELECT 889, 5 UNION ALL
	SELECT 890, 5 UNION ALL
	SELECT 891, 5 UNION ALL
	SELECT 892, 5 UNION ALL
	SELECT 893, 5 UNION ALL
	SELECT 894, 5 UNION ALL
	SELECT 895, 5 UNION ALL
	SELECT 896, 5 UNION ALL
	SELECT 897, 5 UNION ALL
	SELECT 898, 5 UNION ALL
	SELECT 899, 5 UNION ALL
	SELECT 900, 5 UNION ALL
	SELECT 901, 5 UNION ALL
	SELECT 902, 5 UNION ALL
	SELECT 903, 5 UNION ALL
	SELECT 904, 5 UNION ALL
	SELECT 905, 5 UNION ALL
	SELECT 906, 5 UNION ALL
	SELECT 907, 5 UNION ALL
	SELECT 908, 5 UNION ALL
	SELECT 909, 5 UNION ALL
	SELECT 910, 5 UNION ALL
	SELECT 911, 5 UNION ALL
	SELECT 912, 5 UNION ALL
	SELECT 913, 5 UNION ALL
	SELECT 914, 5 UNION ALL
	SELECT 915, 5 UNION ALL
	SELECT 916, 5 UNION ALL
	SELECT 917, 5 UNION ALL
	SELECT 918, 5 UNION ALL
	SELECT 919, 5 UNION ALL
	SELECT 920, 5 UNION ALL
	SELECT 921, 5 UNION ALL
	SELECT 922, 5 UNION ALL
	SELECT 923, 5 UNION ALL
	SELECT 924, 5 UNION ALL
	SELECT 925, 5 UNION ALL
	SELECT 926, 5 UNION ALL
	SELECT 927, 5 UNION ALL
	SELECT 928, 5 UNION ALL
	SELECT 929, 5 UNION ALL
	SELECT 930, 5 UNION ALL
	SELECT 931, 5 UNION ALL
	SELECT 932, 5 UNION ALL
	SELECT 933, 5 UNION ALL
	SELECT 934, 5 UNION ALL
	SELECT 935, 5 UNION ALL
	SELECT 936, 5 UNION ALL
	SELECT 937, 5 UNION ALL
	SELECT 938, 5 UNION ALL
	SELECT 939, 5 UNION ALL
	SELECT 940, 5 UNION ALL
	SELECT 941, 5 UNION ALL
	SELECT 942, 5 UNION ALL
	SELECT 943, 5 UNION ALL
	SELECT 944, 5 UNION ALL
	SELECT 945, 5 UNION ALL
	SELECT 946, 5 UNION ALL
	SELECT 947, 5 UNION ALL
	SELECT 948, 5 UNION ALL
	SELECT 949, 5

	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: Fourth Expansion.....Done!', 10, 1) WITH NOWAIT;
END

--Holiday Pack 2012 Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 950)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 950, 6 UNION ALL
	SELECT 951, 6 UNION ALL
	SELECT 952, 6 UNION ALL
	SELECT 953, 6 UNION ALL
	SELECT 954, 6 UNION ALL
	SELECT 955, 6 UNION ALL
	SELECT 956, 6 UNION ALL
	SELECT 957, 6 UNION ALL
	SELECT 958, 6 UNION ALL
	SELECT 959, 6 UNION ALL
	SELECT 960, 6 UNION ALL
	SELECT 961, 6 UNION ALL
	SELECT 962, 6 UNION ALL
	SELECT 963, 6 UNION ALL
	SELECT 964, 6 UNION ALL
	SELECT 965, 6 UNION ALL
	SELECT 966, 6 UNION ALL
	SELECT 967, 6 UNION ALL
	SELECT 968, 6 UNION ALL
	SELECT 969, 6 UNION ALL
	SELECT 970, 6 UNION ALL
	SELECT 971, 6 UNION ALL
	SELECT 972, 6 UNION ALL
	SELECT 973, 6 UNION ALL
	SELECT 974, 6 UNION ALL
	SELECT 975, 6 UNION ALL
	SELECT 976, 6 UNION ALL
	SELECT 978, 6 UNION ALL
	SELECT 979, 6 UNION ALL
	SELECT 980, 6 

	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: Holiday Pack 2012.....Done!', 10, 1) WITH NOWAIT;
END

--Holiday Bullshit 2013 Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 981)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 981 , 7 UNION ALL
	SELECT 982 , 7 UNION ALL
	SELECT 983 , 7 UNION ALL
	SELECT 984 , 7 UNION ALL
	SELECT 985 , 7 UNION ALL
	SELECT 986 , 7 UNION ALL
	SELECT 987 , 7 UNION ALL
	SELECT 988 , 7 UNION ALL
	SELECT 989 , 7 UNION ALL
	SELECT 990 , 7 UNION ALL
	SELECT 991 , 7 UNION ALL
	SELECT 992 , 7 UNION ALL
	SELECT 993 , 7 UNION ALL
	SELECT 994 , 7 UNION ALL
	SELECT 995 , 7 UNION ALL
	SELECT 996 , 7 UNION ALL
	SELECT 997 , 7 UNION ALL
	SELECT 998 , 7 UNION ALL
	SELECT 999 , 7 UNION ALL
	SELECT 1000, 7 UNION ALL
	SELECT 1001, 7 UNION ALL
	SELECT 1002, 7 UNION ALL
	SELECT 1003, 7 UNION ALL
	SELECT 1004, 7 UNION ALL
	SELECT 1005, 7 UNION ALL
	SELECT 1006, 7 UNION ALL
	SELECT 1007, 7 UNION ALL
	SELECT 1008, 7 UNION ALL
	SELECT 1009, 7 UNION ALL
	SELECT 1010, 7 
	
	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: Holiday Bullshit 2013.....Done!', 10, 1) WITH NOWAIT;
END

--House Of Cards Against Hummanity Expansion
IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[DeckCard] WHERE CardID = 1011)
BEGIN

	BEGIN TRANSACTION;
	INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
	SELECT 1011, 8 UNION ALL
	SELECT 1012, 8 UNION ALL
	SELECT 1013, 8 UNION ALL
	SELECT 1014, 8 UNION ALL
	SELECT 1015, 8 UNION ALL
	SELECT 1016, 8 UNION ALL
	SELECT 1017, 8 UNION ALL
	SELECT 1018, 8 UNION ALL
	SELECT 1019, 8 UNION ALL
	SELECT 1020, 8 UNION ALL
	SELECT 1021, 8 UNION ALL
	SELECT 1022, 8 UNION ALL
	SELECT 1023, 8 UNION ALL
	SELECT 1024, 8 UNION ALL
	SELECT 1025, 8 UNION ALL
	SELECT 1026, 8 UNION ALL
	SELECT 1027, 8 UNION ALL
	SELECT 1028, 8 UNION ALL
	SELECT 1029, 8 UNION ALL
	SELECT 1030, 8 UNION ALL
	SELECT 1031, 8 UNION ALL
	SELECT 1032, 8 UNION ALL
	SELECT 1033, 8 UNION ALL
	SELECT 1034, 8 UNION ALL
	SELECT 1035, 8

	COMMIT;
	RAISERROR (N'[dbo].[DeckCard]: Insert Batch: House Of Cards Against Hummanity.....Done!', 10, 1) WITH NOWAIT;
END
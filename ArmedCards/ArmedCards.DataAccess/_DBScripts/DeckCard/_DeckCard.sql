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

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 1, 1 UNION ALL
SELECT 2, 1 UNION ALL
SELECT 3, 1 UNION ALL
SELECT 4, 1 UNION ALL
SELECT 5, 1 UNION ALL
SELECT 6, 1 UNION ALL
SELECT 7, 1 UNION ALL
SELECT 8, 1 UNION ALL
SELECT 9, 1 UNION ALL
SELECT 10, 1 UNION ALL
SELECT 11, 1 UNION ALL
SELECT 12, 1 UNION ALL
SELECT 13, 1 UNION ALL
SELECT 14, 1 UNION ALL
SELECT 15, 1 UNION ALL
SELECT 16, 1 UNION ALL
SELECT 17, 1 UNION ALL
SELECT 18, 1 UNION ALL
SELECT 19, 1 UNION ALL
SELECT 20, 1 UNION ALL
SELECT 21, 1 UNION ALL
SELECT 22, 1 UNION ALL
SELECT 23, 1 UNION ALL
SELECT 24, 1 UNION ALL
SELECT 25, 1 UNION ALL
SELECT 26, 1 UNION ALL
SELECT 27, 1 UNION ALL
SELECT 28, 1 UNION ALL
SELECT 29, 1 UNION ALL
SELECT 30, 1 UNION ALL
SELECT 31, 1 UNION ALL
SELECT 32, 1 UNION ALL
SELECT 33, 1 UNION ALL
SELECT 34, 1 UNION ALL
SELECT 35, 1 UNION ALL
SELECT 36, 1 UNION ALL
SELECT 37, 1 UNION ALL
SELECT 38, 1 UNION ALL
SELECT 39, 1 UNION ALL
SELECT 40, 1 UNION ALL
SELECT 41, 1 UNION ALL
SELECT 42, 1 UNION ALL
SELECT 43, 1 UNION ALL
SELECT 44, 1 UNION ALL
SELECT 45, 1 UNION ALL
SELECT 46, 1 UNION ALL
SELECT 47, 1 UNION ALL
SELECT 48, 1 UNION ALL
SELECT 49, 1 UNION ALL
SELECT 50, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 51, 1 UNION ALL
SELECT 52, 1 UNION ALL
SELECT 53, 1 UNION ALL
SELECT 54, 1 UNION ALL
SELECT 55, 1 UNION ALL
SELECT 56, 1 UNION ALL
SELECT 57, 1 UNION ALL
SELECT 58, 1 UNION ALL
SELECT 59, 1 UNION ALL
SELECT 60, 1 UNION ALL
SELECT 61, 1 UNION ALL
SELECT 62, 1 UNION ALL
SELECT 63, 1 UNION ALL
SELECT 64, 1 UNION ALL
SELECT 65, 1 UNION ALL
SELECT 66, 1 UNION ALL
SELECT 67, 1 UNION ALL
SELECT 68, 1 UNION ALL
SELECT 69, 1 UNION ALL
SELECT 70, 1 UNION ALL
SELECT 71, 1 UNION ALL
SELECT 72, 1 UNION ALL
SELECT 73, 1 UNION ALL
SELECT 74, 1 UNION ALL
SELECT 75, 1 UNION ALL
SELECT 76, 1 UNION ALL
SELECT 77, 1 UNION ALL
SELECT 78, 1 UNION ALL
SELECT 79, 1 UNION ALL
SELECT 80, 1 UNION ALL
SELECT 81, 1 UNION ALL
SELECT 82, 1 UNION ALL
SELECT 83, 1 UNION ALL
SELECT 84, 1 UNION ALL
SELECT 85, 1 UNION ALL
SELECT 86, 1 UNION ALL
SELECT 87, 1 UNION ALL
SELECT 88, 1 UNION ALL
SELECT 89, 1 UNION ALL
SELECT 90, 1 UNION ALL
SELECT 91, 1 UNION ALL
SELECT 92, 1 UNION ALL
SELECT 93, 1 UNION ALL
SELECT 94, 1 UNION ALL
SELECT 95, 1 UNION ALL
SELECT 96, 1 UNION ALL
SELECT 97, 1 UNION ALL
SELECT 98, 1 UNION ALL
SELECT 99, 1 UNION ALL
SELECT 100, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 2.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 101, 1 UNION ALL
SELECT 102, 1 UNION ALL
SELECT 103, 1 UNION ALL
SELECT 104, 1 UNION ALL
SELECT 105, 1 UNION ALL
SELECT 106, 1 UNION ALL
SELECT 107, 1 UNION ALL
SELECT 108, 1 UNION ALL
SELECT 109, 1 UNION ALL
SELECT 110, 1 UNION ALL
SELECT 111, 1 UNION ALL
SELECT 112, 1 UNION ALL
SELECT 113, 1 UNION ALL
SELECT 114, 1 UNION ALL
SELECT 115, 1 UNION ALL
SELECT 116, 1 UNION ALL
SELECT 117, 1 UNION ALL
SELECT 118, 1 UNION ALL
SELECT 119, 1 UNION ALL
SELECT 120, 1 UNION ALL
SELECT 121, 1 UNION ALL
SELECT 122, 1 UNION ALL
SELECT 123, 1 UNION ALL
SELECT 124, 1 UNION ALL
SELECT 125, 1 UNION ALL
SELECT 126, 1 UNION ALL
SELECT 127, 1 UNION ALL
SELECT 128, 1 UNION ALL
SELECT 129, 1 UNION ALL
SELECT 130, 1 UNION ALL
SELECT 131, 1 UNION ALL
SELECT 132, 1 UNION ALL
SELECT 133, 1 UNION ALL
SELECT 134, 1 UNION ALL
SELECT 135, 1 UNION ALL
SELECT 136, 1 UNION ALL
SELECT 137, 1 UNION ALL
SELECT 138, 1 UNION ALL
SELECT 139, 1 UNION ALL
SELECT 140, 1 UNION ALL
SELECT 141, 1 UNION ALL
SELECT 142, 1 UNION ALL
SELECT 143, 1 UNION ALL
SELECT 144, 1 UNION ALL
SELECT 145, 1 UNION ALL
SELECT 146, 1 UNION ALL
SELECT 147, 1 UNION ALL
SELECT 148, 1 UNION ALL
SELECT 149, 1 UNION ALL
SELECT 150, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 3.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 151, 1 UNION ALL
SELECT 152, 1 UNION ALL
SELECT 153, 1 UNION ALL
SELECT 154, 1 UNION ALL
SELECT 155, 1 UNION ALL
SELECT 156, 1 UNION ALL
SELECT 157, 1 UNION ALL
SELECT 158, 1 UNION ALL
SELECT 159, 1 UNION ALL
SELECT 160, 1 UNION ALL
SELECT 161, 1 UNION ALL
SELECT 162, 1 UNION ALL
SELECT 163, 1 UNION ALL
SELECT 164, 1 UNION ALL
SELECT 165, 1 UNION ALL
SELECT 166, 1 UNION ALL
SELECT 167, 1 UNION ALL
SELECT 168, 1 UNION ALL
SELECT 169, 1 UNION ALL
SELECT 170, 1 UNION ALL
SELECT 171, 1 UNION ALL
SELECT 172, 1 UNION ALL
SELECT 173, 1 UNION ALL
SELECT 174, 1 UNION ALL
SELECT 175, 1 UNION ALL
SELECT 176, 1 UNION ALL
SELECT 177, 1 UNION ALL
SELECT 178, 1 UNION ALL
SELECT 179, 1 UNION ALL
SELECT 180, 1 UNION ALL
SELECT 181, 1 UNION ALL
SELECT 182, 1 UNION ALL
SELECT 183, 1 UNION ALL
SELECT 184, 1 UNION ALL
SELECT 185, 1 UNION ALL
SELECT 186, 1 UNION ALL
SELECT 187, 1 UNION ALL
SELECT 188, 1 UNION ALL
SELECT 189, 1 UNION ALL
SELECT 190, 1 UNION ALL
SELECT 191, 1 UNION ALL
SELECT 192, 1 UNION ALL
SELECT 193, 1 UNION ALL
SELECT 194, 1 UNION ALL
SELECT 195, 1 UNION ALL
SELECT 196, 1 UNION ALL
SELECT 197, 1 UNION ALL
SELECT 198, 1 UNION ALL
SELECT 199, 1 UNION ALL
SELECT 200, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 4.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 201, 1 UNION ALL
SELECT 202, 1 UNION ALL
SELECT 203, 1 UNION ALL
SELECT 204, 1 UNION ALL
SELECT 205, 1 UNION ALL
SELECT 206, 1 UNION ALL
SELECT 207, 1 UNION ALL
SELECT 208, 1 UNION ALL
SELECT 209, 1 UNION ALL
SELECT 210, 1 UNION ALL
SELECT 211, 1 UNION ALL
SELECT 212, 1 UNION ALL
SELECT 213, 1 UNION ALL
SELECT 214, 1 UNION ALL
SELECT 215, 1 UNION ALL
SELECT 216, 1 UNION ALL
SELECT 217, 1 UNION ALL
SELECT 218, 1 UNION ALL
SELECT 219, 1 UNION ALL
SELECT 220, 1 UNION ALL
SELECT 221, 1 UNION ALL
SELECT 222, 1 UNION ALL
SELECT 223, 1 UNION ALL
SELECT 224, 1 UNION ALL
SELECT 225, 1 UNION ALL
SELECT 226, 1 UNION ALL
SELECT 227, 1 UNION ALL
SELECT 228, 1 UNION ALL
SELECT 229, 1 UNION ALL
SELECT 230, 1 UNION ALL
SELECT 231, 1 UNION ALL
SELECT 232, 1 UNION ALL
SELECT 233, 1 UNION ALL
SELECT 234, 1 UNION ALL
SELECT 235, 1 UNION ALL
SELECT 236, 1 UNION ALL
SELECT 237, 1 UNION ALL
SELECT 238, 1 UNION ALL
SELECT 239, 1 UNION ALL
SELECT 240, 1 UNION ALL
SELECT 241, 1 UNION ALL
SELECT 242, 1 UNION ALL
SELECT 243, 1 UNION ALL
SELECT 244, 1 UNION ALL
SELECT 245, 1 UNION ALL
SELECT 246, 1 UNION ALL
SELECT 247, 1 UNION ALL
SELECT 248, 1 UNION ALL
SELECT 249, 1 UNION ALL
SELECT 250, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 5.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 251, 1 UNION ALL
SELECT 252, 1 UNION ALL
SELECT 253, 1 UNION ALL
SELECT 254, 1 UNION ALL
SELECT 255, 1 UNION ALL
SELECT 256, 1 UNION ALL
SELECT 257, 1 UNION ALL
SELECT 258, 1 UNION ALL
SELECT 259, 1 UNION ALL
SELECT 260, 1 UNION ALL
SELECT 261, 1 UNION ALL
SELECT 262, 1 UNION ALL
SELECT 263, 1 UNION ALL
SELECT 264, 1 UNION ALL
SELECT 265, 1 UNION ALL
SELECT 266, 1 UNION ALL
SELECT 267, 1 UNION ALL
SELECT 268, 1 UNION ALL
SELECT 269, 1 UNION ALL
SELECT 270, 1 UNION ALL
SELECT 271, 1 UNION ALL
SELECT 272, 1 UNION ALL
SELECT 273, 1 UNION ALL
SELECT 274, 1 UNION ALL
SELECT 275, 1 UNION ALL
SELECT 276, 1 UNION ALL
SELECT 277, 1 UNION ALL
SELECT 278, 1 UNION ALL
SELECT 279, 1 UNION ALL
SELECT 280, 1 UNION ALL
SELECT 281, 1 UNION ALL
SELECT 282, 1 UNION ALL
SELECT 283, 1 UNION ALL
SELECT 284, 1 UNION ALL
SELECT 285, 1 UNION ALL
SELECT 286, 1 UNION ALL
SELECT 287, 1 UNION ALL
SELECT 288, 1 UNION ALL
SELECT 289, 1 UNION ALL
SELECT 290, 1 UNION ALL
SELECT 291, 1 UNION ALL
SELECT 292, 1 UNION ALL
SELECT 293, 1 UNION ALL
SELECT 294, 1 UNION ALL
SELECT 295, 1 UNION ALL
SELECT 296, 1 UNION ALL
SELECT 297, 1 UNION ALL
SELECT 298, 1 UNION ALL
SELECT 299, 1 UNION ALL
SELECT 300, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 6.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 301, 1 UNION ALL
SELECT 302, 1 UNION ALL
SELECT 303, 1 UNION ALL
SELECT 304, 1 UNION ALL
SELECT 305, 1 UNION ALL
SELECT 306, 1 UNION ALL
SELECT 307, 1 UNION ALL
SELECT 308, 1 UNION ALL
SELECT 309, 1 UNION ALL
SELECT 310, 1 UNION ALL
SELECT 311, 1 UNION ALL
SELECT 312, 1 UNION ALL
SELECT 313, 1 UNION ALL
SELECT 314, 1 UNION ALL
SELECT 315, 1 UNION ALL
SELECT 316, 1 UNION ALL
SELECT 317, 1 UNION ALL
SELECT 318, 1 UNION ALL
SELECT 319, 1 UNION ALL
SELECT 320, 1 UNION ALL
SELECT 321, 1 UNION ALL
SELECT 322, 1 UNION ALL
SELECT 323, 1 UNION ALL
SELECT 324, 1 UNION ALL
SELECT 325, 1 UNION ALL
SELECT 326, 1 UNION ALL
SELECT 327, 1 UNION ALL
SELECT 328, 1 UNION ALL
SELECT 329, 1 UNION ALL
SELECT 330, 1 UNION ALL
SELECT 331, 1 UNION ALL
SELECT 332, 1 UNION ALL
SELECT 333, 1 UNION ALL
SELECT 334, 1 UNION ALL
SELECT 335, 1 UNION ALL
SELECT 336, 1 UNION ALL
SELECT 337, 1 UNION ALL
SELECT 338, 1 UNION ALL
SELECT 339, 1 UNION ALL
SELECT 340, 1 UNION ALL
SELECT 341, 1 UNION ALL
SELECT 342, 1 UNION ALL
SELECT 343, 1 UNION ALL
SELECT 344, 1 UNION ALL
SELECT 345, 1 UNION ALL
SELECT 346, 1 UNION ALL
SELECT 347, 1 UNION ALL
SELECT 348, 1 UNION ALL
SELECT 349, 1 UNION ALL
SELECT 350, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 7.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 351, 1 UNION ALL
SELECT 352, 1 UNION ALL
SELECT 353, 1 UNION ALL
SELECT 354, 1 UNION ALL
SELECT 355, 1 UNION ALL
SELECT 356, 1 UNION ALL
SELECT 357, 1 UNION ALL
SELECT 358, 1 UNION ALL
SELECT 359, 1 UNION ALL
SELECT 360, 1 UNION ALL
SELECT 361, 1 UNION ALL
SELECT 362, 1 UNION ALL
SELECT 363, 1 UNION ALL
SELECT 364, 1 UNION ALL
SELECT 365, 1 UNION ALL
SELECT 366, 1 UNION ALL
SELECT 367, 1 UNION ALL
SELECT 368, 1 UNION ALL
SELECT 369, 1 UNION ALL
SELECT 370, 1 UNION ALL
SELECT 371, 1 UNION ALL
SELECT 372, 1 UNION ALL
SELECT 373, 1 UNION ALL
SELECT 374, 1 UNION ALL
SELECT 375, 1 UNION ALL
SELECT 376, 1 UNION ALL
SELECT 377, 1 UNION ALL
SELECT 378, 1 UNION ALL
SELECT 379, 1 UNION ALL
SELECT 380, 1 UNION ALL
SELECT 381, 1 UNION ALL
SELECT 382, 1 UNION ALL
SELECT 383, 1 UNION ALL
SELECT 384, 1 UNION ALL
SELECT 385, 1 UNION ALL
SELECT 386, 1 UNION ALL
SELECT 387, 1 UNION ALL
SELECT 388, 1 UNION ALL
SELECT 389, 1 UNION ALL
SELECT 390, 1 UNION ALL
SELECT 391, 1 UNION ALL
SELECT 392, 1 UNION ALL
SELECT 393, 1 UNION ALL
SELECT 394, 1 UNION ALL
SELECT 395, 1 UNION ALL
SELECT 396, 1 UNION ALL
SELECT 397, 1 UNION ALL
SELECT 398, 1 UNION ALL
SELECT 399, 1 UNION ALL
SELECT 400, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 8.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 401, 1 UNION ALL
SELECT 402, 1 UNION ALL
SELECT 403, 1 UNION ALL
SELECT 404, 1 UNION ALL
SELECT 405, 1 UNION ALL
SELECT 406, 1 UNION ALL
SELECT 407, 1 UNION ALL
SELECT 408, 1 UNION ALL
SELECT 409, 1 UNION ALL
SELECT 410, 1 UNION ALL
SELECT 411, 1 UNION ALL
SELECT 412, 1 UNION ALL
SELECT 413, 1 UNION ALL
SELECT 414, 1 UNION ALL
SELECT 415, 1 UNION ALL
SELECT 416, 1 UNION ALL
SELECT 417, 1 UNION ALL
SELECT 418, 1 UNION ALL
SELECT 419, 1 UNION ALL
SELECT 420, 1 UNION ALL
SELECT 421, 1 UNION ALL
SELECT 422, 1 UNION ALL
SELECT 423, 1 UNION ALL
SELECT 424, 1 UNION ALL
SELECT 425, 1 UNION ALL
SELECT 426, 1 UNION ALL
SELECT 427, 1 UNION ALL
SELECT 428, 1 UNION ALL
SELECT 429, 1 UNION ALL
SELECT 430, 1 UNION ALL
SELECT 431, 1 UNION ALL
SELECT 432, 1 UNION ALL
SELECT 433, 1 UNION ALL
SELECT 434, 1 UNION ALL
SELECT 435, 1 UNION ALL
SELECT 436, 1 UNION ALL
SELECT 437, 1 UNION ALL
SELECT 438, 1 UNION ALL
SELECT 439, 1 UNION ALL
SELECT 440, 1 UNION ALL
SELECT 441, 1 UNION ALL
SELECT 442, 1 UNION ALL
SELECT 443, 1 UNION ALL
SELECT 444, 1 UNION ALL
SELECT 445, 1 UNION ALL
SELECT 446, 1 UNION ALL
SELECT 447, 1 UNION ALL
SELECT 448, 1 UNION ALL
SELECT 449, 1 UNION ALL
SELECT 450, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 9.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 451, 1 UNION ALL
SELECT 452, 1 UNION ALL
SELECT 453, 1 UNION ALL
SELECT 454, 1 UNION ALL
SELECT 455, 1 UNION ALL
SELECT 456, 1 UNION ALL
SELECT 457, 1 UNION ALL
SELECT 458, 1 UNION ALL
SELECT 459, 1 UNION ALL
SELECT 460, 1 UNION ALL
SELECT 461, 1 UNION ALL
SELECT 462, 1 UNION ALL
SELECT 463, 1 UNION ALL
SELECT 464, 1 UNION ALL
SELECT 465, 1 UNION ALL
SELECT 466, 1 UNION ALL
SELECT 467, 1 UNION ALL
SELECT 468, 1 UNION ALL
SELECT 469, 1 UNION ALL
SELECT 470, 1 UNION ALL
SELECT 471, 1 UNION ALL
SELECT 472, 1 UNION ALL
SELECT 473, 1 UNION ALL
SELECT 474, 1 UNION ALL
SELECT 475, 1 UNION ALL
SELECT 476, 1 UNION ALL
SELECT 477, 1 UNION ALL
SELECT 478, 1 UNION ALL
SELECT 479, 1 UNION ALL
SELECT 480, 1 UNION ALL
SELECT 481, 1 UNION ALL
SELECT 482, 1 UNION ALL
SELECT 483, 1 UNION ALL
SELECT 484, 1 UNION ALL
SELECT 485, 1 UNION ALL
SELECT 486, 1 UNION ALL
SELECT 487, 1 UNION ALL
SELECT 488, 1 UNION ALL
SELECT 489, 1 UNION ALL
SELECT 490, 1 UNION ALL
SELECT 491, 1 UNION ALL
SELECT 492, 1 UNION ALL
SELECT 493, 1 UNION ALL
SELECT 494, 1 UNION ALL
SELECT 495, 1 UNION ALL
SELECT 496, 1 UNION ALL
SELECT 497, 1 UNION ALL
SELECT 498, 1 UNION ALL
SELECT 499, 1 UNION ALL
SELECT 500, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 10.....Done!', 10, 1) WITH NOWAIT;
GO

BEGIN TRANSACTION;
INSERT INTO [dbo].[DeckCard]([CardID], [DeckID])
SELECT 501, 1 UNION ALL
SELECT 502, 1 UNION ALL
SELECT 503, 1 UNION ALL
SELECT 504, 1 UNION ALL
SELECT 505, 1 UNION ALL
SELECT 506, 1 UNION ALL
SELECT 507, 1 UNION ALL
SELECT 508, 1 UNION ALL
SELECT 509, 1 UNION ALL
SELECT 510, 1 UNION ALL
SELECT 511, 1 UNION ALL
SELECT 512, 1 UNION ALL
SELECT 513, 1 UNION ALL
SELECT 514, 1 UNION ALL
SELECT 515, 1 UNION ALL
SELECT 516, 1 UNION ALL
SELECT 517, 1 UNION ALL
SELECT 518, 1 UNION ALL
SELECT 519, 1 UNION ALL
SELECT 520, 1 UNION ALL
SELECT 521, 1 UNION ALL
SELECT 522, 1 UNION ALL
SELECT 523, 1 UNION ALL
SELECT 524, 1 UNION ALL
SELECT 525, 1 UNION ALL
SELECT 526, 1 UNION ALL
SELECT 527, 1 UNION ALL
SELECT 528, 1 UNION ALL
SELECT 529, 1 UNION ALL
SELECT 530, 1 UNION ALL
SELECT 531, 1 UNION ALL
SELECT 532, 1 UNION ALL
SELECT 533, 1 UNION ALL
SELECT 534, 1 UNION ALL
SELECT 535, 1 UNION ALL
SELECT 536, 1 UNION ALL
SELECT 537, 1 UNION ALL
SELECT 538, 1 UNION ALL
SELECT 539, 1 UNION ALL
SELECT 540, 1 UNION ALL
SELECT 541, 1 UNION ALL
SELECT 542, 1 UNION ALL
SELECT 543, 1 UNION ALL
SELECT 544, 1 UNION ALL
SELECT 545, 1 UNION ALL
SELECT 546, 1 UNION ALL
SELECT 547, 1 UNION ALL
SELECT 548, 1 UNION ALL
SELECT 549, 1
COMMIT;
RAISERROR (N'[dbo].[DeckCard]: Insert Batch: 11.....Done!', 10, 1) WITH NOWAIT;
GO

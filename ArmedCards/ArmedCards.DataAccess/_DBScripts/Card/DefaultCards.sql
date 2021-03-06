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

IF NOT EXISTS (SELECT TOP 1 CardID FROM [dbo].[Card])
BEGIN

SET IDENTITY_INSERT [dbo].[Card] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 1, N'Being on fire.', 1, 0, 1 UNION ALL
SELECT 2, N'Racism.', 1, 0, 1 UNION ALL
SELECT 3, N'Old-people smell.', 1, 0, 1 UNION ALL
SELECT 4, N'A micropenis.', 1, 0, 1 UNION ALL
SELECT 5, N'Women in yogurt commercials.', 1, 0, 1 UNION ALL
SELECT 6, N'Classist undertones.', 1, 0, 1 UNION ALL
SELECT 7, N'Not giving a shit about the Third World.', 1, 0, 1 UNION ALL
SELECT 8, N'Sexting.', 1, 0, 1 UNION ALL
SELECT 9, N'Roofies.', 1, 0, 1 UNION ALL
SELECT 10, N'A windmill full of corpses.', 1, 0, 1 UNION ALL
SELECT 11, N'The gays.', 1, 0, 1 UNION ALL
SELECT 12, N'Oversized lollipops.', 1, 0, 1 UNION ALL
SELECT 13, N'African Children.', 1, 0, 1 UNION ALL
SELECT 14, N'An asymmetric boob job.', 1, 0, 1 UNION ALL
SELECT 15, N'Bingeing and purging.', 1, 0, 1 UNION ALL
SELECT 16, N'The hardworking Mexican.', 1, 0, 1 UNION ALL
SELECT 17, N'An Oedipus complex.', 1, 0, 1 UNION ALL
SELECT 18, N'A tiny horse.', 1, 0, 1 UNION ALL
SELECT 19, N'Boogers.', 1, 0, 1 UNION ALL
SELECT 20, N'Penis envy.', 1, 0, 1 UNION ALL
SELECT 21, N'Barack Obama.', 1, 0, 1 UNION ALL
SELECT 22, N'My humps.', 1, 0, 1 UNION ALL
SELECT 23, N'The Tempurpedic® Swedish Sleep System™.', 1, 0, 1 UNION ALL
SELECT 24, N'Scientology.', 1, 0, 1 UNION ALL
SELECT 25, N'Dry heaving.', 1, 0, 1 UNION ALL
SELECT 26, N'Skeletor.', 1, 0, 1 UNION ALL
SELECT 27, N'Darth Vader.', 1, 0, 1 UNION ALL
SELECT 28, N'Figgy Pudding.', 1, 0, 1 UNION ALL
SELECT 29, N'Chutzpah.', 1, 0, 1 UNION ALL
SELECT 30, N'Five-Dollar Footlongs™.', 1, 0, 1 UNION ALL
SELECT 31, N'Elderly Japanese men.', 1, 0, 1 UNION ALL
SELECT 32, N'Free Samples.', 1, 0, 1 UNION ALL
SELECT 33, N'Estrogen.', 1, 0, 1 UNION ALL
SELECT 34, N'Sexual tension.', 1, 0, 1 UNION ALL
SELECT 35, N'Famine.', 1, 0, 1 UNION ALL
SELECT 36, N'A stray pube.', 1, 0, 1 UNION ALL
SELECT 37, N'Men.', 1, 0, 1 UNION ALL
SELECT 38, N'Heartwarming orphans.', 1, 0, 1 UNION ALL
SELECT 39, N'Genital piercings.', 1, 0, 1 UNION ALL
SELECT 40, N'A bag of magic beans.', 1, 0, 1 UNION ALL
SELECT 41, N'Repression.', 1, 0, 1 UNION ALL
SELECT 42, N'Prancing.', 1, 0, 1 UNION ALL
SELECT 43, N'My relationship status.', 1, 0, 1 UNION ALL
SELECT 44, N'Overcompensation.', 1, 0, 1 UNION ALL
SELECT 45, N'Peeing a little bit.', 1, 0, 1 UNION ALL
SELECT 46, N'Pooping back and forth. Forever', 1, 0, 1 UNION ALL
SELECT 47, N'Eating all of the cookies before the AIDS bake-sale.', 1, 0, 1 UNION ALL
SELECT 48, N'Testicular torsion.', 1, 0, 1 UNION ALL
SELECT 49, N'The Devil himself.', 1, 0, 1 UNION ALL
SELECT 50, N'The World of Warcraft.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 51, N'Dick Cheney.', 1, 0, 1 UNION ALL
SELECT 52, N'MechaHitler.', 1, 0, 1 UNION ALL
SELECT 53, N'Being fabulous.', 1, 0, 1 UNION ALL
SELECT 54, N'Pictures of boobs.', 1, 0, 1 UNION ALL
SELECT 55, N'A caress of the inner thigh.', 1, 0, 1 UNION ALL
SELECT 56, N'The Amish.', 1, 0, 1 UNION ALL
SELECT 57, N'Pabst Blue Ribbon.', 1, 0, 1 UNION ALL
SELECT 58, N'Lance Armstrong''s missing testicle.', 1, 0, 1 UNION ALL
SELECT 59, N'Pedophiles.', 1, 0, 1 UNION ALL
SELECT 60, N'The Pope.', 1, 0, 1 UNION ALL
SELECT 61, N'Flying sex snakes.', 1, 0, 1 UNION ALL
SELECT 62, N'Sarah Palin.', 1, 0, 1 UNION ALL
SELECT 63, N'Feeding Rosie O Donnell.', 1, 0, 1 UNION ALL
SELECT 64, N'Sexy pillow fights.', 1, 0, 1 UNION ALL
SELECT 65, N'Another goddamn vampire movie.', 1, 0, 1 UNION ALL
SELECT 66, N'Cybernetic enhancements.', 1, 0, 1 UNION ALL
SELECT 67, N'Civilian casualties.', 1, 0, 1 UNION ALL
SELECT 68, N'Scrubbing under the folds.', 1, 0, 1 UNION ALL
SELECT 69, N'The female orgasm.', 1, 0, 1 UNION ALL
SELECT 70, N'Bitches.', 1, 0, 1 UNION ALL
SELECT 71, N'The Boy Scouts of America.', 1, 0, 1 UNION ALL
SELECT 72, N'Auschwitz.', 1, 0, 1 UNION ALL
SELECT 73, N'Finger painting.', 1, 0, 1 UNION ALL
SELECT 74, N'The Care Bear Stare.', 1, 0, 1 UNION ALL
SELECT 75, N'The Jews.', 1, 0, 1 UNION ALL
SELECT 76, N'Being marginalized.', 1, 0, 1 UNION ALL
SELECT 77, N'The Blood of Christ.', 1, 0, 1 UNION ALL
SELECT 78, N'Dead parents.', 1, 0, 1 UNION ALL
SELECT 79, N'Seduction.', 1, 0, 1 UNION ALL
SELECT 80, N'Dying of dysentery.', 1, 0, 1 UNION ALL
SELECT 81, N'Mr. Clean, right behind you.', 1, 0, 1 UNION ALL
SELECT 82, N'The Virginia Tech Massacre.', 1, 0, 1 UNION ALL
SELECT 83, N'Jewish fraternities.', 1, 0, 1 UNION ALL
SELECT 84, N'Hot Pockets®.', 1, 0, 1 UNION ALL
SELECT 85, N'Natalie Portman.', 1, 0, 1 UNION ALL
SELECT 86, N'Agriculture.', 1, 0, 1 UNION ALL
SELECT 87, N'Judge Judy.', 1, 0, 1 UNION ALL
SELECT 88, N'Surprise Sex!', 1, 0, 1 UNION ALL
SELECT 89, N'The homosexual lifestyle.', 1, 0, 1 UNION ALL
SELECT 90, N'Robert Downey, Jr.', 1, 0, 1 UNION ALL
SELECT 91, N'The Trail of Tears.', 1, 0, 1 UNION ALL
SELECT 92, N'An M. Night Shyamalan plot twist.', 1, 0, 1 UNION ALL
SELECT 93, N'A big hoopla about nothing.', 1, 0, 1 UNION ALL
SELECT 94, N'Electricity.', 1, 0, 1 UNION ALL
SELECT 95, N'Amputees.', 1, 0, 1 UNION ALL
SELECT 96, N'Throwing a virgin into a volcano.', 1, 0, 1 UNION ALL
SELECT 97, N'Italians.', 1, 0, 1 UNION ALL
SELECT 98, N'Explosions.', 1, 0, 1 UNION ALL
SELECT 99, N'A good sniff.', 1, 0, 1 UNION ALL
SELECT 100, N'Destroying the evidence.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 2.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 101, N'Children on leashes.', 1, 0, 1 UNION ALL
SELECT 102, N'Catapults.', 1, 0, 1 UNION ALL
SELECT 103, N'One trillion dollars.', 1, 0, 1 UNION ALL
SELECT 104, N'Friends with benefits.', 1, 0, 1 UNION ALL
SELECT 105, N'Dying.', 1, 0, 1 UNION ALL
SELECT 106, N'Silence.', 1, 0, 1 UNION ALL
SELECT 107, N'An honest cop with nothing left to lose.', 1, 0, 1 UNION ALL
SELECT 108, N'YOU MUST CONSTRUCT ADDITIONAL PYLONS.', 1, 0, 1 UNION ALL
SELECT 109, N'Justin Bieber.', 1, 0, 1 UNION ALL
SELECT 110, N'The holy Bible.', 1, 0, 1 UNION ALL
SELECT 111, N'Balls.', 1, 0, 1 UNION ALL
SELECT 112, N'Praying the gay away.', 1, 0, 1 UNION ALL
SELECT 113, N'Teenage pregnancy.', 1, 0, 1 UNION ALL
SELECT 114, N'German dungeon porn.', 1, 0, 1 UNION ALL
SELECT 115, N'The invisible hand.', 1, 0, 1 UNION ALL
SELECT 116, N'My inner demons.', 1, 0, 1 UNION ALL
SELECT 117, N'Powerful thighs.', 1, 0, 1 UNION ALL
SELECT 118, N'Getting naked and watching Nickelodeon.', 1, 0, 1 UNION ALL
SELECT 119, N'Crippling debt.', 1, 0, 1 UNION ALL
SELECT 120, N'Kamikaze pilots.', 1, 0, 1 UNION ALL
SELECT 121, N'Teaching a robot to love.', 1, 0, 1 UNION ALL
SELECT 122, N'Police brutality.', 1, 0, 1 UNION ALL
SELECT 123, N'Horse meat.', 1, 0, 1 UNION ALL
SELECT 124, N'All-you-can-eat shrimp for $4.99.', 1, 0, 1 UNION ALL
SELECT 125, N'Heteronormativity.', 1, 0, 1 UNION ALL
SELECT 126, N'Michael Jackson.', 1, 0, 1 UNION ALL
SELECT 127, N'A really cool hat.', 1, 0, 1 UNION ALL
SELECT 128, N'Copping a feel.', 1, 0, 1 UNION ALL
SELECT 129, N'Crystal meth.', 1, 0, 1 UNION ALL
SELECT 130, N'Shapeshifters.', 1, 0, 1 UNION ALL
SELECT 131, N'Fingering.', 1, 0, 1 UNION ALL
SELECT 132, N'A disappointing birthday party.', 1, 0, 1 UNION ALL
SELECT 133, N'Dental dams.', 1, 0, 1 UNION ALL
SELECT 134, N'My soul.', 1, 0, 1 UNION ALL
SELECT 135, N'A sausage festival.', 1, 0, 1 UNION ALL
SELECT 136, N'The chronic.', 1, 0, 1 UNION ALL
SELECT 137, N'Eugenics.', 1, 0, 1 UNION ALL
SELECT 138, N'Synergistic management solutions.', 1, 0, 1 UNION ALL
SELECT 139, N'RoboCop.', 1, 0, 1 UNION ALL
SELECT 140, N'Serfdom.', 1, 0, 1 UNION ALL
SELECT 141, N'Stephen Hawking talking dirty.', 1, 0, 1 UNION ALL
SELECT 142, N'Tangled Slinkys.', 1, 0, 1 UNION ALL
SELECT 143, N'Fiery poops.', 1, 0, 1 UNION ALL
SELECT 144, N'Public ridicule.', 1, 0, 1 UNION ALL
SELECT 145, N'That thing that electrocutes your abs.', 1, 0, 1 UNION ALL
SELECT 146, N'Picking up girls at the abortion clinic.', 1, 0, 1 UNION ALL
SELECT 147, N'Object permanence.', 1, 0, 1 UNION ALL
SELECT 148, N'GoGurt®.', 1, 0, 1 UNION ALL
SELECT 149, N'Lockjaw.', 1, 0, 1 UNION ALL
SELECT 150, N'Attitude.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 3.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 151, N'Passable transvestites.', 1, 0, 1 UNION ALL
SELECT 152, N'Wet dreams.', 1, 0, 1 UNION ALL
SELECT 153, N'The Dance of the Sugar Plum Fairy.', 1, 0, 1 UNION ALL
SELECT 154, N'Firing a rifle into the air while balls deep in a squealing hog.', 1, 0, 1 UNION ALL
SELECT 155, N'Panda sex.', 1, 0, 1 UNION ALL
SELECT 156, N'Necrophilia.', 1, 0, 1 UNION ALL
SELECT 157, N'Grave robbing.', 1, 0, 1 UNION ALL
SELECT 158, N'A bleached asshole.', 1, 0, 1 UNION ALL
SELECT 159, N'Muhammad (Praise Be Unto Him).', 1, 0, 1 UNION ALL
SELECT 160, N'Multiple stab wounds.', 1, 0, 1 UNION ALL
SELECT 161, N'Stranger danger.', 1, 0, 1 UNION ALL
SELECT 162, N'A monkey smoking a cigar.', 1, 0, 1 UNION ALL
SELECT 163, N'Smegma.', 1, 0, 1 UNION ALL
SELECT 164, N'A live studio audience.', 1, 0, 1 UNION ALL
SELECT 165, N'Making a pouty face.', 1, 0, 1 UNION ALL
SELECT 166, N'The violation of our most basic human rights.', 1, 0, 1 UNION ALL
SELECT 167, N'Unfathomable stupidity.', 1, 0, 1 UNION ALL
SELECT 168, N'Sunshine and rainbows.', 1, 0, 1 UNION ALL
SELECT 169, N'Whipping it out.', 1, 0, 1 UNION ALL
SELECT 170, N'The token minority.', 1, 0, 1 UNION ALL
SELECT 171, N'The terrorists.', 1, 0, 1 UNION ALL
SELECT 172, N'The Three-Fifths compromise.', 1, 0, 1 UNION ALL
SELECT 173, N'A snapping turtle biting the tip of your penis.', 1, 0, 1 UNION ALL
SELECT 174, N'Vehicular manslaughter.', 1, 0, 1 UNION ALL
SELECT 175, N'Jibber-jabber.', 1, 0, 1 UNION ALL
SELECT 176, N'Emotions.', 1, 0, 1 UNION ALL
SELECT 177, N'Getting so angry that you pop a boner.', 1, 0, 1 UNION ALL
SELECT 178, N'Same-sex ice dancing.', 1, 0, 1 UNION ALL
SELECT 179, N'An M16 assault rifle.', 1, 0, 1 UNION ALL
SELECT 180, N'Man meat.', 1, 0, 1 UNION ALL
SELECT 181, N'Incest.', 1, 0, 1 UNION ALL
SELECT 182, N'A foul mouth.', 1, 0, 1 UNION ALL
SELECT 183, N'Flightless birds.', 1, 0, 1 UNION ALL
SELECT 184, N'Doing the right thing.', 1, 0, 1 UNION ALL
SELECT 185, N'When you fart and a little bit comes out.', 1, 0, 1 UNION ALL
SELECT 186, N'Frolicking.', 1, 0, 1 UNION ALL
SELECT 187, N'Being a dick to children.', 1, 0, 1 UNION ALL
SELECT 188, N'Poopy diapers.', 1, 0, 1 UNION ALL
SELECT 189, N'Filling Sean Hannity with helium and watching him float away.', 1, 0, 1 UNION ALL
SELECT 190, N'Raptor attacks.', 1, 0, 1 UNION ALL
SELECT 191, N'Swooping.', 1, 0, 1 UNION ALL
SELECT 192, N'Concealing a boner.', 1, 0, 1 UNION ALL
SELECT 193, N'Full frontal nudity.', 1, 0, 1 UNION ALL
SELECT 194, N'Vigorous jazz hands.', 1, 0, 1 UNION ALL
SELECT 195, N'Nipple blades.', 1, 0, 1 UNION ALL
SELECT 196, N'A bitch slap.', 1, 0, 1 UNION ALL
SELECT 197, N'Michelle Obama''s arms.', 1, 0, 1 UNION ALL
SELECT 198, N'Mouth Herpes.', 1, 0, 1 UNION ALL
SELECT 199, N'A robust mongoloid.', 1, 0, 1 UNION ALL
SELECT 200, N'Mutually-assured destruction.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 4.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 201, N'The Rapture.', 1, 0, 1 UNION ALL
SELECT 202, N'Road head.', 1, 0, 1 UNION ALL
SELECT 203, N'Stalin.', 1, 0, 1 UNION ALL
SELECT 204, N'Lactation.', 1, 0, 1 UNION ALL
SELECT 205, N'Hurricane Katrina.', 1, 0, 1 UNION ALL
SELECT 206, N'The true meaning of Christmas.', 1, 0, 1 UNION ALL
SELECT 207, N'Self-loathing.', 1, 0, 1 UNION ALL
SELECT 208, N'A brain tumor.', 1, 0, 1 UNION ALL
SELECT 209, N'Dead babies.', 1, 0, 1 UNION ALL
SELECT 210, N'New Age music.', 1, 0, 1 UNION ALL
SELECT 211, N'A thermonuclear detonation.', 1, 0, 1 UNION ALL
SELECT 212, N'Geese.', 1, 0, 1 UNION ALL
SELECT 213, N'Kanye West.', 1, 0, 1 UNION ALL
SELECT 214, N'God.', 1, 0, 1 UNION ALL
SELECT 215, N'A spastic nerd.', 1, 0, 1 UNION ALL
SELECT 216, N'Harry Potter erotica.', 1, 0, 1 UNION ALL
SELECT 217, N'Kids with ass cancer.', 1, 0, 1 UNION ALL
SELECT 218, N'Lumberjack fantasies.', 1, 0, 1 UNION ALL
SELECT 219, N'The American Dream.', 1, 0, 1 UNION ALL
SELECT 220, N'Sweet, sweet vengeance.', 1, 0, 1 UNION ALL
SELECT 221, N'Winking at old people.', 1, 0, 1 UNION ALL
SELECT 222, N'The taint; the grundle; the fleshy fun-bridge.', 1, 0, 1 UNION ALL
SELECT 223, N'Oompa-Loompas.', 1, 0, 1 UNION ALL
SELECT 224, N'Authentic Mexican cuisine.', 1, 0, 1 UNION ALL
SELECT 225, N'Preteens.', 1, 0, 1 UNION ALL
SELECT 226, N'The Little Engine That Could.', 1, 0, 1 UNION ALL
SELECT 227, N'Guys who don''t call.', 1, 0, 1 UNION ALL
SELECT 228, N'Erectile Dysfunction.', 1, 0, 1 UNION ALL
SELECT 229, N'Parting the Red Sea.', 1, 0, 1 UNION ALL
SELECT 230, N'Rush Limbaugh''s soft, shitty body.', 1, 0, 1 UNION ALL
SELECT 231, N'Saxophone solos.', 1, 0, 1 UNION ALL
SELECT 232, N'Land mines.', 1, 0, 1 UNION ALL
SELECT 233, N'Capturing Newt Gingrich and forcing him to dance in a monkey suit.', 1, 0, 1 UNION ALL
SELECT 234, N'Me time.', 1, 0, 1 UNION ALL
SELECT 235, N'Nickelback.', 1, 0, 1 UNION ALL
SELECT 236, N'Vigilante justice.', 1, 0, 1 UNION ALL
SELECT 237, N'The South.', 1, 0, 1 UNION ALL
SELECT 238, N'Opposable thumbs.', 1, 0, 1 UNION ALL
SELECT 239, N'Ghosts.', 1, 0, 1 UNION ALL
SELECT 240, N'Alcoholism.', 1, 0, 1 UNION ALL
SELECT 241, N'Poorly-time Holocaust jokes.', 1, 0, 1 UNION ALL
SELECT 242, N'Inappropriate yodeling.', 1, 0, 1 UNION ALL
SELECT 243, N'Battlefield amputations.', 1, 0, 1 UNION ALL
SELECT 244, N'Exactly what you''d expect.', 1, 0, 1 UNION ALL
SELECT 245, N'A time travel paradox.', 1, 0, 1 UNION ALL
SELECT 246, N'AXE Body Spray.', 1, 0, 1 UNION ALL
SELECT 247, N'Actually taking candy from a baby.', 1, 0, 1 UNION ALL
SELECT 248, N'Leaving an awkward voicemail.', 1, 0, 1 UNION ALL
SELECT 249, N'A sassy black woman.', 1, 0, 1 UNION ALL
SELECT 250, N'Being a motherfucking sorcerer.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 5.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 251, N'A mopey zoo lion.', 1, 0, 1 UNION ALL
SELECT 252, N'A murder most foul.', 1, 0, 1 UNION ALL
SELECT 253, N'A falcon with a cap on its head.', 1, 0, 1 UNION ALL
SELECT 254, N'Farting and walking away.', 1, 0, 1 UNION ALL
SELECT 255, N'A mating display.', 1, 0, 1 UNION ALL
SELECT 256, N'The Chinese gymnastics team.', 1, 0, 1 UNION ALL
SELECT 257, N'Friction.', 1, 0, 1 UNION ALL
SELECT 258, N'Asians who aren''t good at math.', 1, 0, 1 UNION ALL
SELECT 259, N'Fear itself.', 1, 0, 1 UNION ALL
SELECT 260, N'A can of whoop-ass.', 1, 0, 1 UNION ALL
SELECT 261, N'Yeast.', 1, 0, 1 UNION ALL
SELECT 262, N'Lunchables™.', 1, 0, 1 UNION ALL
SELECT 263, N'Licking things to claim them as your own.', 1, 0, 1 UNION ALL
SELECT 264, N'Vikings.', 1, 0, 1 UNION ALL
SELECT 265, N'The Kool-Aid Man.', 1, 0, 1 UNION ALL
SELECT 266, N'Hot cheese.', 1, 0, 1 UNION ALL
SELECT 267, N'Nicolas Cage.', 1, 0, 1 UNION ALL
SELECT 268, N'A defective condom.', 1, 0, 1 UNION ALL
SELECT 269, N'The inevitable heat death of the universe.', 1, 0, 1 UNION ALL
SELECT 270, N'Republicans.', 1, 0, 1 UNION ALL
SELECT 271, N'William Shatner.', 1, 0, 1 UNION ALL
SELECT 272, N'Tentacle porn.', 1, 0, 1 UNION ALL
SELECT 273, N'Sperm whales.', 1, 0, 1 UNION ALL
SELECT 274, N'Lady Gaga.', 1, 0, 1 UNION ALL
SELECT 275, N'Chunks of dead prostitute.', 1, 0, 1 UNION ALL
SELECT 276, N'Gloryholes.', 1, 0, 1 UNION ALL
SELECT 277, N'Daddy issues.', 1, 0, 1 UNION ALL
SELECT 278, N'A mime having a stroke.', 1, 0, 1 UNION ALL
SELECT 279, N'White people.', 1, 0, 1 UNION ALL
SELECT 280, N'A lifetime of sadness.', 1, 0, 1 UNION ALL
SELECT 281, N'Tasteful sideboob.', 1, 0, 1 UNION ALL
SELECT 282, N'A sea of troubles.', 1, 0, 1 UNION ALL
SELECT 283, N'Nazis.', 1, 0, 1 UNION ALL
SELECT 284, N'A cooler full of organs.', 1, 0, 1 UNION ALL
SELECT 285, N'Giving 110%.', 1, 0, 1 UNION ALL
SELECT 286, N'Doing'' it in the butt.', 1, 0, 1 UNION ALL
SELECT 287, N'John Wilkes Booth.', 1, 0, 1 UNION ALL
SELECT 288, N'Obesity.', 1, 0, 1 UNION ALL
SELECT 289, N'A homoerotic volleyball montage.', 1, 0, 1 UNION ALL
SELECT 290, N'Puppies!', 1, 0, 1 UNION ALL
SELECT 291, N'Natural male enhancement.', 1, 0, 1 UNION ALL
SELECT 292, N'Brown people.', 1, 0, 1 UNION ALL
SELECT 293, N'Dropping a chandelier on your enemies and riding the rope up.', 1, 0, 1 UNION ALL
SELECT 294, N'Soup that is too hot.', 1, 0, 1 UNION ALL
SELECT 295, N'Porn stars.', 1, 0, 1 UNION ALL
SELECT 296, N'Hormone injections.', 1, 0, 1 UNION ALL
SELECT 297, N'Pulling out.', 1, 0, 1 UNION ALL
SELECT 298, N'The Big Bang.', 1, 0, 1 UNION ALL
SELECT 299, N'Switching to Geico®.', 1, 0, 1 UNION ALL
SELECT 300, N'Wearing underwear inside-out to avoid doing laundry.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 6.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 301, N'Rehab.', 1, 0, 1 UNION ALL
SELECT 302, N'Christopher Walken.', 1, 0, 1 UNION ALL
SELECT 303, N'Count Chocula.', 1, 0, 1 UNION ALL
SELECT 304, N'The Hamburglar.', 1, 0, 1 UNION ALL
SELECT 305, N'Not reciprocating oral sex.', 1, 0, 1 UNION ALL
SELECT 306, N'Aaron Burr.', 1, 0, 1 UNION ALL
SELECT 307, N'Hot people.', 1, 0, 1 UNION ALL
SELECT 308, N'Foreskin.', 1, 0, 1 UNION ALL
SELECT 309, N'Assless Chaps.', 1, 0, 1 UNION ALL
SELECT 310, N'The miracle of childbirth.', 1, 0, 1 UNION ALL
SELECT 311, N'Waiting ''til marriage.', 1, 0, 1 UNION ALL
SELECT 312, N'Two midgets shitting into a bucket.', 1, 0, 1 UNION ALL
SELECT 313, N'Adderall™.', 1, 0, 1 UNION ALL
SELECT 314, N'A sad handjob.', 1, 0, 1 UNION ALL
SELECT 315, N'Cheating in the Special Olympics.', 1, 0, 1 UNION ALL
SELECT 316, N'The glass Ceiling.', 1, 0, 1 UNION ALL
SELECT 317, N'The Hustle.', 1, 0, 1 UNION ALL
SELECT 318, N'Getting drunk on mouthwash.', 1, 0, 1 UNION ALL
SELECT 319, N'Bling.', 1, 0, 1 UNION ALL
SELECT 320, N'Breaking out into song and dance.', 1, 0, 1 UNION ALL
SELECT 321, N'A Super Soaker™ full of cat pee.', 1, 0, 1 UNION ALL
SELECT 322, N'The Underground Railroad.', 1, 0, 1 UNION ALL
SELECT 323, N'Home video of Oprah sobbing into Lean Cuisine®.', 1, 0, 1 UNION ALL
SELECT 324, N'The Rev. Dr. Martin Luther King, Jr.', 1, 0, 1 UNION ALL
SELECT 325, N'Extremely tight pants.', 1, 0, 1 UNION ALL
SELECT 326, N'Third base.', 1, 0, 1 UNION ALL
SELECT 327, N'Waking up half-naked in a Denny''s parking lot.', 1, 0, 1 UNION ALL
SELECT 328, N'Golden Showers.', 1, 0, 1 UNION ALL
SELECT 329, N'White privilege.', 1, 0, 1 UNION ALL
SELECT 330, N'Hope.', 1, 0, 1 UNION ALL
SELECT 331, N'Taking off your shirt.', 1, 0, 1 UNION ALL
SELECT 332, N'Smallpox blankets.', 1, 0, 1 UNION ALL
SELECT 333, N'Ethnic cleansing.', 1, 0, 1 UNION ALL
SELECT 334, N'Queefing.', 1, 0, 1 UNION ALL
SELECT 335, N'Helplessly giggling at the mention of Hutus and Tutsis.', 1, 0, 1 UNION ALL
SELECT 336, N'Getting really high.', 1, 0, 1 UNION ALL
SELECT 337, N'Natural selection.', 1, 0, 1 UNION ALL
SELECT 338, N'A gassy antelope.', 1, 0, 1 UNION ALL
SELECT 339, N'My sex life.', 1, 0, 1 UNION ALL
SELECT 340, N'Arnold Schwarzenegger.', 1, 0, 1 UNION ALL
SELECT 341, N'Pretending to care.', 1, 0, 1 UNION ALL
SELECT 342, N'Ronald Reagan.', 1, 0, 1 UNION ALL
SELECT 343, N'Toni Morrison''s vagina.', 1, 0, 1 UNION ALL
SELECT 344, N'Pterodactyl eggs.', 1, 0, 1 UNION ALL
SELECT 345, N'A death ray.', 1, 0, 1 UNION ALL
SELECT 346, N'BATMAN!!!.', 1, 0, 1 UNION ALL
SELECT 347, N'Homeless people.', 1, 0, 1 UNION ALL
SELECT 348, N'Racially-biased SAT questions.', 1, 0, 1 UNION ALL
SELECT 349, N'Centaurs.', 1, 0, 1 UNION ALL
SELECT 350, N'A salty surprise.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 7.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 351, N'72 virgins.', 1, 0, 1 UNION ALL
SELECT 352, N'Embryonic stem cells.', 1, 0, 1 UNION ALL
SELECT 353, N'Pixelated bukkake.', 1, 0, 1 UNION ALL
SELECT 354, N'Seppuku.', 1, 0, 1 UNION ALL
SELECT 355, N'An icepick lobotomy.', 1, 0, 1 UNION ALL
SELECT 356, N'Stormtroopers.', 1, 0, 1 UNION ALL
SELECT 357, N'Menstrual rage.', 1, 0, 1 UNION ALL
SELECT 358, N'Passing a kidney stone.', 1, 0, 1 UNION ALL
SELECT 359, N'An uppercut.', 1, 0, 1 UNION ALL
SELECT 360, N'Shaquille O''Neal''s acting career.', 1, 0, 1 UNION ALL
SELECT 361, N'Horrifying laser hair removal accidents.', 1, 0, 1 UNION ALL
SELECT 362, N'Autocannibalism.', 1, 0, 1 UNION ALL
SELECT 363, N'A fetus.', 1, 0, 1 UNION ALL
SELECT 364, N'Riding off into the sunset.', 1, 0, 1 UNION ALL
SELECT 365, N'Goblins.', 1, 0, 1 UNION ALL
SELECT 366, N'Eating the last known bison.', 1, 0, 1 UNION ALL
SELECT 367, N'Shiny objects.', 1, 0, 1 UNION ALL
SELECT 368, N'Being rich.', 1, 0, 1 UNION ALL
SELECT 369, N'A Bop It™.', 1, 0, 1 UNION ALL
SELECT 370, N'Leprosy.', 1, 0, 1 UNION ALL
SELECT 371, N'World peace.', 1, 0, 1 UNION ALL
SELECT 372, N'Dick fingers.', 1, 0, 1 UNION ALL
SELECT 373, N'Chainsaws for hands.', 1, 0, 1 UNION ALL
SELECT 374, N'The Make-A-Wish Foundation®.', 1, 0, 1 UNION ALL
SELECT 375, N'Britney Spears at 55.', 1, 0, 1 UNION ALL
SELECT 376, N'Laying an egg.', 1, 0, 1 UNION ALL
SELECT 377, N'The folly of man.', 1, 0, 1 UNION ALL
SELECT 378, N'My genitals.', 1, 0, 1 UNION ALL
SELECT 379, N'Grandma.', 1, 0, 1 UNION ALL
SELECT 380, N'Flesh-eating bacteria.', 1, 0, 1 UNION ALL
SELECT 381, N'Poor people.', 1, 0, 1 UNION ALL
SELECT 382, N'50''000 volts straight to the nipples.', 1, 0, 1 UNION ALL
SELECT 383, N'Active listening.', 1, 0, 1 UNION ALL
SELECT 384, N'The Übermensch.', 1, 0, 1 UNION ALL
SELECT 385, N'Poor life choices.', 1, 0, 1 UNION ALL
SELECT 386, N'Altar boys.', 1, 0, 1 UNION ALL
SELECT 387, N'My vagina.', 1, 0, 1 UNION ALL
SELECT 388, N'Pac-Man uncontrollably guzzling cum.', 1, 0, 1 UNION ALL
SELECT 389, N'Sniffing glue.', 1, 0, 1 UNION ALL
SELECT 390, N'The placenta.', 1, 0, 1 UNION ALL
SELECT 391, N'The profoundly handicapped.', 1, 0, 1 UNION ALL
SELECT 392, N'Spontaneous human combustion.', 1, 0, 1 UNION ALL
SELECT 393, N'The KKK.', 1, 0, 1 UNION ALL
SELECT 394, N'The clitoris.', 1, 0, 1 UNION ALL
SELECT 395, N'Not wearing pants.', 1, 0, 1 UNION ALL
SELECT 396, N'Date rape.', 1, 0, 1 UNION ALL
SELECT 397, N'Black people.', 1, 0, 1 UNION ALL
SELECT 398, N'A bucket of fish heads.', 1, 0, 1 UNION ALL
SELECT 399, N'Hospice care.', 1, 0, 1 UNION ALL
SELECT 400, N'Passive-aggressive Post-it notes.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 8.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 401, N'Fancy Feast®.', 1, 0, 1 UNION ALL
SELECT 402, N'The heart of a child.', 1, 0, 1 UNION ALL
SELECT 403, N'Sharing needles.', 1, 0, 1 UNION ALL
SELECT 404, N'Scalping.', 1, 0, 1 UNION ALL
SELECT 405, N'A look-see.', 1, 0, 1 UNION ALL
SELECT 406, N'Getting married, having kids, buying some stuff, retiring to Florida, and dying.', 1, 0, 1 UNION ALL
SELECT 407, N'Sean Penn.', 1, 0, 1 UNION ALL
SELECT 408, N'Sean Connery.', 1, 0, 1 UNION ALL
SELECT 409, N'Expecting a burp and vomiting on the floor.', 1, 0, 1 UNION ALL
SELECT 410, N'Wifely duties.', 1, 0, 1 UNION ALL
SELECT 411, N'A pyramid of severed heads.', 1, 0, 1 UNION ALL
SELECT 412, N'Genghis Khan.', 1, 0, 1 UNION ALL
SELECT 413, N'Historically black colleges.', 1, 0, 1 UNION ALL
SELECT 414, N'Raping and pillaging.', 1, 0, 1 UNION ALL
SELECT 415, N'A subscription to Men''s Fitness.', 1, 0, 1 UNION ALL
SELECT 416, N'The milk man.', 1, 0, 1 UNION ALL
SELECT 417, N'Friendly fire.', 1, 0, 1 UNION ALL
SELECT 418, N'Women''s suffrage.', 1, 0, 1 UNION ALL
SELECT 419, N'AIDS.', 1, 0, 1 UNION ALL
SELECT 420, N'Former President George W. Bush.', 1, 0, 1 UNION ALL
SELECT 421, N'8 oz. of sweet Mexican black-tar heroin.', 1, 0, 1 UNION ALL
SELECT 422, N'Half-assed foreplay.', 1, 0, 1 UNION ALL
SELECT 423, N'Edible underpants.', 1, 0, 1 UNION ALL
SELECT 424, N'My collection of high-tech sex toys.', 1, 0, 1 UNION ALL
SELECT 425, N'The Force.', 1, 0, 1 UNION ALL
SELECT 426, N'Bees?', 1, 0, 1 UNION ALL
SELECT 427, N'Loose lips.', 1, 0, 1 UNION ALL
SELECT 428, N'Jerking off into a pool of children''s tears.', 1, 0, 1 UNION ALL
SELECT 429, N'A micropig wearing a tiny raincoat and booties.', 1, 0, 1 UNION ALL
SELECT 430, N'A hot mess.', 1, 0, 1 UNION ALL
SELECT 431, N'Masturbation.', 1, 0, 1 UNION ALL
SELECT 432, N'Tom Cruise.', 1, 0, 1 UNION ALL
SELECT 433, N'A balanced breakfast.', 1, 0, 1 UNION ALL
SELECT 434, N'Anal beads.', 1, 0, 1 UNION ALL
SELECT 435, N'Drinking alone.', 1, 0, 1 UNION ALL
SELECT 436, N'Cards Against Humanity.', 1, 0, 1 UNION ALL
SELECT 437, N'Coat hanger abortions.', 1, 0, 1 UNION ALL
SELECT 438, N'Used panties.', 1, 0, 1 UNION ALL
SELECT 439, N'Cuddling.', 1, 0, 1 UNION ALL
SELECT 440, N'Wiping her butt.', 1, 0, 1 UNION ALL
SELECT 441, N'Domino''s™ Oreo™ Dessert Pizza.', 1, 0, 1 UNION ALL
SELECT 442, N'A zesty breakfast burrito.', 1, 0, 1 UNION ALL
SELECT 443, N'Morgan Freeman''s voice.', 1, 0, 1 UNION ALL
SELECT 444, N'A middle-aged man on roller skates.', 1, 0, 1 UNION ALL
SELECT 445, N'Gandhi.', 1, 0, 1 UNION ALL
SELECT 446, N'The penny whistle solo ||My Heart Will Go On||.', 1, 0, 1 UNION ALL
SELECT 447, N'Spectacular abs.', 1, 0, 1 UNION ALL
SELECT 448, N'Keanu Reeves.', 1, 0, 1 UNION ALL
SELECT 449, N'Child beauty pageants.', 1, 0, 1 UNION ALL
SELECT 450, N'Child abuse.', 1, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 9.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 451, N'Bill Nye the Science Guy.', 1, 0, 1 UNION ALL
SELECT 452, N'Science.', 1, 0, 1 UNION ALL
SELECT 453, N'A tribe of warrior women.', 1, 0, 1 UNION ALL
SELECT 454, N'Viagra®.', 1, 0, 1 UNION ALL
SELECT 455, N'Her Majesty, Queen Elizabeth II.', 1, 0, 1 UNION ALL
SELECT 456, N'The entire Mormon Tabernacle Choir.', 1, 0, 1 UNION ALL
SELECT 457, N'Hulk Hogan.', 1, 0, 1 UNION ALL
SELECT 458, N'Take-backsies.', 1, 0, 1 UNION ALL
SELECT 459, N'An erection that lasts longer than four hours.', 1, 0, 1 UNION ALL
SELECT 460, N'How did I lose my virginity?', 0, 0, 1 UNION ALL
SELECT 461, N'Why can''t I sleep at night?', 0, 0, 1 UNION ALL
SELECT 462, N'What''s that smell?', 0, 0, 1 UNION ALL
SELECT 463, N'I got 99 problems but _____ ain''t.', 0, 0, 1 UNION ALL
SELECT 464, N'Maybe she''s born with it. Maybe it''s _____.', 0, 0, 1 UNION ALL
SELECT 465, N'What''s the next Happy Meal® toy?', 0, 0, 1 UNION ALL
SELECT 466, N'Here is the church Here is the steeple Open the doors And there is _____.', 0, 0, 1 UNION ALL
SELECT 467, N'It''s a pity that kids these days are all getting involved with _____.', 0, 0, 1 UNION ALL
SELECT 468, N'During his childhood, Salvador Dali produced hundreds of paintings of _____.', 0, 0, 1 UNION ALL
SELECT 469, N'Alternative medicine is now embracing the curative powers of _____.', 0, 0, 1 UNION ALL
SELECT 470, N'And the Academy Award for _____ goes to _____.', 0, 1, 1 UNION ALL
SELECT 471, N'What''s that sound?', 0, 0, 1 UNION ALL
SELECT 472, N'What ended my last relationship?', 0, 0, 1 UNION ALL
SELECT 473, N'MTV''s new reality show features eight wash-up celebrities living with _____.', 0, 0, 1 UNION ALL
SELECT 474, N'I drink to forget _____.', 0, 0, 1 UNION ALL
SELECT 475, N'I''m sorry, Professor, but I couldn''t complete my homework because of _____.', 0, 0, 1 UNION ALL
SELECT 476, N'What is Batman''s guilty pleasure?', 0, 0, 1 UNION ALL
SELECT 477, N'This is the way the world ends. This is the way the world ends. Not with a bang but with _____.', 0, 0, 1 UNION ALL
SELECT 478, N'What''s a girl''s best friend?', 0, 0, 1 UNION ALL
SELECT 479, N'TSA guidelines now prohibit _____ on airplanes.', 0, 0, 1 UNION ALL
SELECT 480, N'_____. That''s how I want to die.', 0, 0, 1 UNION ALL
SELECT 481, N'For my next trick, I will pull _____ out of _____.', 0, 1, 1 UNION ALL
SELECT 482, N'In the new Disney Channel Original Movie, Hannah Montana struggles with _____ for the first time.', 0, 0, 1 UNION ALL
SELECT 483, N'_____ is a slippery slope that leads to _____', 0, 1, 1 UNION ALL
SELECT 484, N'What does Dick Cheney prefer?', 0, 0, 1 UNION ALL
SELECT 485, N'Dear Abby, I''m having some trouble with _____ and would like your advice.', 0, 0, 1 UNION ALL
SELECT 486, N'Instead of coal, Santa now gives the bad children _____.', 0, 0, 1 UNION ALL
SELECT 487, N'What''s the most emo?', 0, 0, 1 UNION ALL
SELECT 488, N'In 1,000 years, when paper money is a distant memory, how will we pay for goods and services?', 0, 0, 1 UNION ALL
SELECT 489, N'What''s the next superhero/sidekick duo?', 0, 1, 1 UNION ALL
SELECT 490, N'In M. Night Shyamalan''s new movie, Bruce Willis discovers that _____ had really been _____ all along.', 0, 1, 1 UNION ALL
SELECT 491, N'A romantic, candlelit dinner would be incomplete without _____.', 0, 0, 1 UNION ALL
SELECT 492, N'_____. Betcha can''t have just one!', 0, 0, 1 UNION ALL
SELECT 493, N'White people like _____.', 0, 0, 1 UNION ALL
SELECT 494, N'_____. High five, bro.', 0, 0, 1 UNION ALL
SELECT 495, N'Next from J.K. Rowling: Harry Potter and the Chamber of _____.', 0, 0, 1 UNION ALL
SELECT 496, N'BILLY MAYS HERE FOR _____.', 0, 0, 1 UNION ALL
SELECT 497, N'In a world ravaged by _____, our only solace is _____.', 0, 1, 1 UNION ALL
SELECT 498, N'War! What is it good for?', 0, 0, 1 UNION ALL
SELECT 499, N'During sex, I like to think about _____.', 0, 0, 1 UNION ALL
SELECT 500, N'What are my parents hiding from me?', 0, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 10.....Done!', 10, 1) WITH NOWAIT;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Card]([CardID], [Content], [Type], [Instructions], [CreatedBy_UserId])
SELECT 501, N'What will always get you laid?', 0, 0, 1 UNION ALL
SELECT 502, N'In L.A. County Jail, word is you can trade 200 cigarettes for _____.', 0, 0, 1 UNION ALL
SELECT 503, N'What did I bring back from Mexico?', 0, 0, 1 UNION ALL
SELECT 504, N'What don''t you want to find in your Chinese food?', 0, 0, 1 UNION ALL
SELECT 505, N'What will I bring back in time to convince people that I am a powerful wizard?', 0, 0, 1 UNION ALL
SELECT 506, N'How am I maintaining my relationship status?', 0, 0, 1 UNION ALL
SELECT 507, N'_____. It''s a trap!', 0, 0, 1 UNION ALL
SELECT 508, N'Coming to Broadway this season, _____: The Musical.', 0, 0, 1 UNION ALL
SELECT 509, N'While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on _____.', 0, 0, 1 UNION ALL
SELECT 510, N'After the earthquake, Sean Penn brought _____ to the people of Haiti.', 0, 0, 1 UNION ALL
SELECT 511, N'Next on ESPN2, the World Series of _____.', 0, 0, 1 UNION ALL
SELECT 512, N'Step 1: _____. Step 2: _____. Step 3: Profit.', 0, 1, 1 UNION ALL
SELECT 513, N'Rumor has it that Vladimir Putin''s favorite delicacy is _____ stuffed with _____.', 0, 1, 1 UNION ALL
SELECT 514, N'But before I kill you, Mr. Bond, I must show you _____.', 0, 0, 1 UNION ALL
SELECT 515, N'What gives me uncontrollable gas?', 0, 0, 1 UNION ALL
SELECT 516, N'What do old people smell like?', 0, 0, 1 UNION ALL
SELECT 517, N'The class field trip was completely ruined by _____.', 0, 0, 1 UNION ALL
SELECT 518, N'When Pharaoh remained unmoved Moses called down a Plague of _____.', 0, 0, 1 UNION ALL
SELECT 519, N'What''s my secret power?', 0, 0, 1 UNION ALL
SELECT 520, N'What''s there a ton of in heaven?', 0, 0, 1 UNION ALL
SELECT 521, N'What would grandma find disturbing, yet oddly charming?', 0, 0, 1 UNION ALL
SELECT 522, N'I never truly understood _____ until I encountered _____.', 0, 1, 1 UNION ALL
SELECT 523, N'What did the U.S. airdrop to the children of Afghanistan?', 0, 0, 1 UNION ALL
SELECT 524, N'What help Obama unwind?', 0, 0, 1 UNION ALL
SELECT 525, N'What did Vin Diesel eat for dinner?', 0, 0, 1 UNION ALL
SELECT 526, N'_____: good to the last drop.', 0, 0, 1 UNION ALL
SELECT 527, N'Why am I sticky?', 0, 0, 1 UNION ALL
SELECT 528, N'What gets better with age?', 0, 0, 1 UNION ALL
SELECT 529, N'_____: kid-tested, mother-approved.', 0, 0, 1 UNION ALL
SELECT 530, N'Daddy, why is mommy crying?', 0, 0, 1 UNION ALL
SELECT 531, N'What''s Teach for America using to inspire inner city students to succeed?', 0, 0, 1 UNION ALL
SELECT 532, N'Studies show that lab rats navigate mazes 50% faster after being exposed to _____.', 0, 0, 1 UNION ALL
SELECT 533, N'Life for American Indians was forever changed when the White Man introduced them to _____.', 0, 0, 1 UNION ALL
SELECT 534, N'Make a haiku.', 0, 2, 1 UNION ALL
SELECT 535, N'I do not know with what weapons World War III will be fought, but World War IV will be fought with _____.', 0, 0, 1 UNION ALL
SELECT 536, N'Why do I hurt all over?', 0, 0, 1 UNION ALL
SELECT 537, N'What am I giving up for Lent?', 0, 0, 1 UNION ALL
SELECT 538, N'In Michael Jackson''s final moments, he thought about _____.', 0, 0, 1 UNION ALL
SELECT 539, N'The Smithsonian Museum of Natural History has just opened an interactive exhibit on _____.', 0, 0, 1 UNION ALL
SELECT 540, N'When I am President of the United States, I will create the Department of _____.', 0, 0, 1 UNION ALL
SELECT 541, N'Lifetime® presents _____, the story of _____.', 0, 1, 1 UNION ALL
SELECT 542, N'When I am a billionaire, I shall erect a 50-foot statue to commemorate _____.', 0, 0, 1 UNION ALL
SELECT 543, N'When I was tripping on acid, _____ turned into _____', 0, 1, 1 UNION ALL
SELECT 544, N'That''s right, I killed _____. How, you ask? _____.', 0, 1, 1 UNION ALL
SELECT 545, N'What''s my anti-drug?', 0, 0, 1 UNION ALL
SELECT 546, N'_____ + _____ = _____', 0, 2, 1 UNION ALL
SELECT 547, N'What never fails to liven up the party?', 0, 0, 1 UNION ALL
SELECT 548, N'What''s the new fad diet?', 0, 0, 1 UNION ALL
SELECT 549, N'Major League Baseball has banned _____ for giving players an unfair advantage.', 0, 0, 1
COMMIT;
RAISERROR (N'[dbo].[Card]: Insert Batch: 11.....Done!', 10, 1) WITH NOWAIT;

SET IDENTITY_INSERT [dbo].[Card] OFF;

END

GO

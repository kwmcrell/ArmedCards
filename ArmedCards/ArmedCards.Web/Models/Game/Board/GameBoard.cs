/*
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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.Web.Models.Game.Board
{
    /// <summary>
    /// Model used to render the game board
    /// </summary>
    public class GameBoard
    {
        public GameBoard()
        {
            Hand = new List<Entities.GamePlayerCard>();
            VoteToKickList = new List<VoteToKick>();
        }

        /// <summary>
        /// The current game
        /// </summary>
        public Entities.Game Game { get; set; }

        /// <summary>
        /// The current User Id
        /// </summary>
        public Int32 UserId { get; set; }

        /// <summary>
        /// The current user's hand
        /// </summary>
        public List<Entities.GamePlayerCard> Hand { get; set; }

        /// <summary>
        /// A list of votes to kick users
        /// </summary>
        public List<Models.Game.Board.VoteToKick> VoteToKickList { get; set; }

        /// <summary>
        /// Determine if current user has answered
        /// </summary>
        /// <returns>True if the user has answered and false otherwise</returns>
        public Boolean Answered()
        {
            if (Game.HasRounds())
            {
                return Game.CurrentRound().HasAnswer(UserId);
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Is current user a active player
        /// </summary>
        public Boolean ActivePlayer
        {
            get
            {
                return Hand.Count > 0;
            }
        }

        /// <summary>
        /// Determine if hand div should be shown
        /// </summary>
        /// <returns></returns>
        public Boolean ShowHand()
        {
            return ActivePlayer && !Answered() && !IsCommander() && PlayerType == Entities.Enums.GamePlayerType.Player;
        }

        /// <summary>
        /// Determine if the current user is the commander
        /// </summary>
        /// <returns></returns>
        public Boolean IsCommander()
        {
            return Game.IsCurrentCommander(UserId) && PlayerType == Entities.Enums.GamePlayerType.Player;
        }

        /// <summary>
        /// Show answers if all players have played
        /// </summary>
        /// <returns></returns>
        public Boolean ShowAnswers()
        {
            Entities.GameRound round = Game.CurrentRound();

            if (round == null)
            {
                return false;
            }

            return round.PlayedCount >= round.CurrentPlayerCount && round.Answers.Count > 0;
        }

        /// <summary>
        /// The current round has a winner
        /// </summary>
        /// <returns></returns>
        public Boolean RoundHasWinner()
        {
            Entities.GameRound round = Game.CurrentRound();

            if (round == null)
            {
                return false;
            }

            return round.Winner() != null;
        }

        /// <summary>
        /// Determine if waiting screen should be shown
        /// </summary>
        /// <returns></returns>
        public Boolean ShowWaiting()
        {
            return (!ShowAnswers() || Game.CurrentRound() == null || RoundHasWinner()) && Game.IsWaiting();
        }

        /// <summary>
        /// Get answers grouped by who played them
        /// </summary>
        /// <remarks>Only use when answers are being shown</remarks>
        /// <returns></returns>
        public List<IGrouping<Int32, Entities.GameRoundCard>> GroupedAnswers()
        {
            return Game.CurrentRound().GroupedAnswers();
        }

        /// <summary>
        /// The type of the current player
        /// </summary>
        public Entities.Enums.GamePlayerType PlayerType { get; set; }

        /// <summary>
        /// Waiting on all answers
        /// </summary>
        /// <returns></returns>
        public Boolean WaitingOnAllAnswersOrWinner()
        {
            return (!RoundHasWinner() && !ShowAnswers());
        }

        /// <summary>
        /// Show actual game board (Questions & Answers)
        /// </summary>
        /// <returns></returns>
        public Boolean ShowBoard()
        {
            return !ShowWaiting() && !Game.HasWinner();
        }

        /// <summary>
        /// Current Round question
        /// </summary>
        public ArmedCards.Entities.Card Question
        {
            get
            {
                if(ShowBoard())
                {
                    return Game.CurrentRound().Question;
                }

                return null;
            }
        }
    }
}

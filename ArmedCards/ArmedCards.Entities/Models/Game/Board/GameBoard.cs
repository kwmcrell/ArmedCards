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

namespace ArmedCards.Entities.Models.Game.Board
{
    /// <summary>
    /// Model used to render the game board
    /// </summary>
    public class GameBoard
    {
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="game"></param>
        /// <param name="userId"></param>
        /// <param name="hand"></param>
        /// <param name="playerType"></param>
        /// <param name="voteToKickList"></param>
        public GameBoard(Entities.Game game, Int32 userId, Entities.Enums.GamePlayerType playerType,
                         List<Models.Game.Board.VoteToKick> voteToKickList = null)
        {
            Game = game;
            UserId = userId;
            Hand = Game.Players.First(x => x.User.UserId == userId).Hand;
            ActivePlayer = Hand.Count > 0;
            PlayerType = playerType;

            Entities.GameRound round = Game.CurrentRound();

            if (Game.HasRounds() && round != null)
            {
                Answered = round.HasAnswer(UserId);
                ShowAnswers = round.PlayedCount >= round.CurrentPlayerCount && round.Answers.Count > 0;
                RoundHasWinner = round.Winner() != null;
                GroupedAnswers = round.GroupedAnswers();
                IsCommander = Game.IsCurrentCommander(UserId) && PlayerType == Entities.Enums.GamePlayerType.Player;
            }
            else
            {
                Answered = false;
                ShowAnswers = false;
                RoundHasWinner = false;
                IsCommander = false;
            }

            
            ShowHand = ActivePlayer && !Answered && !IsCommander && PlayerType == Entities.Enums.GamePlayerType.Player;

            ShowWaiting = (round == null || RoundHasWinner) && Game.IsWaiting();

            WaitingOnAllAnswersOrWinner = !RoundHasWinner && !ShowAnswers;

            ShowBoard = !ShowWaiting && !Game.HasWinner();

            if (ShowBoard && round != null)
            {
                Question = round.Question;
            }
            else
            {
                Question = null;
            }

            AnswersViewModel = new Answers(RoundHasWinner, IsCommander, WaitingOnAllAnswersOrWinner, ShowAnswers, ShowHand, ShowBoard, GroupedAnswers);
            GameOverViewModel = new GameOver(Game.HasWinner(), Game.GameID, Game.Players);
            HandViewModel = new Board.Hand(ShowHand, Hand, ShowBoard);
            LobbyViewModel = new Lobby(PlayerType, Game.Players, Game.MaxNumberOfSpectators > 0, Game.Spectators);
            RoundQuestionViewModel = new RoundQuestion(round, ShowBoard);
            WaitingViewModel = new Waiting(ShowWaiting);
            VotesToKickViewModel = new VotesToKick(voteToKickList ?? new List<Models.Game.Board.VoteToKick>());

            HeaderViewModel = new Shared.Header();
            
            if (Game.HasWinner())
            {
                HeaderViewModel.SubHeaderText = "Game Over, man!";
            }
            else if (ShowWaiting)
            {
                HeaderViewModel.SubHeaderText = ArmedCards.Entities.Models.Helpers.WaitingHeader.Build(Game, UserId, PlayerType);
            }
            else
            {
                HeaderViewModel.SubHeaderText = String.Format("{0} is the Card Commander", Game.DetermineCommander().DisplayName);
            }
        }

        /// <summary>
        /// The current game
        /// </summary>
        public Entities.Game Game { get; private set; }

        /// <summary>
        /// The current User Id
        /// </summary>
        public Int32 UserId { get; private set; }

        /// <summary>
        /// The current user's hand
        /// </summary>
        public List<Entities.GamePlayerCard> Hand { get; private set; }

        /// <summary>
        /// Determine if current user has answered
        /// </summary>
        /// <returns>True if the user has answered and false otherwise</returns>
        public Boolean Answered { get; private set; }

        /// <summary>
        /// Is current user a active player
        /// </summary>
        public Boolean ActivePlayer { get; private set; }

        /// <summary>
        /// The type of the current player
        /// </summary>
        public Entities.Enums.GamePlayerType PlayerType { get; private set; }

        /// <summary>
        /// Determine if hand div should be shown
        /// </summary>
        /// <returns></returns>
        public Boolean ShowHand { get; private set; }

        /// <summary>
        /// Determine if the current user is the commander
        /// </summary>
        /// <returns></returns>
        public Boolean IsCommander { get; private set; }

        /// <summary>
        /// Show answers if all players have played
        /// </summary>
        /// <returns></returns>
        public Boolean ShowAnswers { get; private set; }

        /// <summary>
        /// The current round has a winner
        /// </summary>
        /// <returns></returns>
        public Boolean RoundHasWinner { get; private set; }

        /// <summary>
        /// Determine if waiting screen should be shown
        /// </summary>
        /// <returns></returns>
        public Boolean ShowWaiting { get; private set; }

        /// <summary>
        /// Get answers grouped by who played them
        /// </summary>
        /// <remarks>Only use when answers are being shown</remarks>
        /// <returns></returns>
        public List<IGrouping<Int32, Entities.GameRoundCard>> GroupedAnswers { get; private set; }

        /// <summary>
        /// Waiting on all answers
        /// </summary>
        /// <returns></returns>
        public Boolean WaitingOnAllAnswersOrWinner { get; private set; }

        /// <summary>
        /// Show actual game board (Questions & Answers)
        /// </summary>
        /// <returns></returns>
        public Boolean ShowBoard { get; private set; }

        /// <summary>
        /// Current Round question
        /// </summary>
        public ArmedCards.Entities.Card Question { get; private set; }

        /// <summary>
        /// View model used for answers
        /// </summary>
        public Models.Game.Board.Answers AnswersViewModel { get; private set; }

        /// <summary>
        /// View model used for game over
        /// </summary>
        public Models.Game.Board.GameOver GameOverViewModel { get; private set; }

        /// <summary>
        /// View model for player's hand
        /// </summary>
        public Models.Game.Board.Hand HandViewModel { get; private set; }

        /// <summary>
        /// View model for the lobby
        /// </summary>
        public Models.Game.Board.Lobby LobbyViewModel { get; private set; }

        /// <summary>
        /// View model for the round question
        /// </summary>
        public Models.Game.Board.RoundQuestion RoundQuestionViewModel { get; private set; }

        /// <summary>
        /// View model for waiting screen
        /// </summary>
        public Models.Game.Board.Waiting WaitingViewModel { get; private set; }

        /// <summary>
        /// View model for votes to kick
        /// </summary>
        public Models.Game.Board.VotesToKick VotesToKickViewModel { get; private set; }

        /// <summary>
        /// View model for the game header
        /// </summary>
        public ArmedCards.Entities.Models.Shared.Header HeaderViewModel { get; private set; }
    }
}

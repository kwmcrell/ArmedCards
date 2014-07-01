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
using ArmedCards.Library.Extensions;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace ArmedCards.Entities
{
    /// <summary>
    /// Object that defines a Game
    /// </summary>
    public class Game
    {
        private const String RoundTimerCacheKey = "GameID_{0}_RoundTimer";

		/// <summary>
		/// Number of players required to play
		/// </summary>
		private const Int32 RequiredPlayerCount = 3;

        /// <summary>
        /// Default Constructor
        /// </summary>
        public Game()
        {
            MaxNumberOfPlayers = 3;
            PointToWin = 10;
            GameDeckIDs = new List<int>();
            Players = new List<GamePlayer>();
            Rounds = new List<GameRound>();
			QuestionShuffleCount = 1;
			AnswerShuffleCount = 1;
            Spectators = new List<GamePlayer>();
            SecondsToPlay = -1;
        }

        /// <summary>
        /// Constructor used by the data layer
        /// </summary>
        /// <param name="idr">The datareader used to build the game</param>
        public Game(IDataReader idr)
            :this()
        {
            GameID                  =   idr.GetValueByName<Int32>("GameID");
            Title                   =   idr.GetValueByName<String>("Title");
            IsPrivate               =   idr.GetValueByName<Boolean>("IsPrivate");
            Passphrase              =   idr.GetValueByName<String>("Passphrase");
			PointToWin              =   idr.GetValueByName<Int32>("PointsToWin");
            MaxNumberOfPlayers      =   idr.GetValueByName<Int32>("MaxNumberOfPlayers");
			GameCreator_UserId      =   idr.GetValueByName<Int32>("GameCreator_UserId");
            DateCreated             =   idr.GetValueByName<DateTime>("DateCreated");
            PlayedLast              =   idr.GetValueByName<DateTime?>("PlayedLast");
            GameOver                =   idr.GetValueByName<DateTime?>("GameOver");
            PlayerCount             =   idr.GetValueByName<Int32>("PlayerCount");
			RoundCount			    =	idr.GetValueByName<Int32>("RoundCount");
			QuestionShuffleCount    =   idr.GetValueByName<Int32>("QuestionShuffleCount");
			AnswerShuffleCount	    =   idr.GetValueByName<Int32>("AnswerShuffleCount");
            MaxNumberOfSpectators   =   idr.GetValueByName<Int32>("MaxNumberOfSpectators");
            SpectatorCount          =   idr.GetValueByName<Int32>("SpectatorCount");
            SecondsToPlay           =   idr.GetValueByName<Int32>("SecondsToPlay");
            IsPersistent 			= 	idr.GetValueByName<Boolean>("IsPersistent");
        }

        /// <summary>
        /// Game ID
        /// </summary>
        public Int32 GameID { get; set; }

        /// <summary>
        /// The Game Title
        /// </summary>
        private String _title { get; set; }
        
        [Required]
        [Display(Name = "Game Title")]
        public String Title
        {
            get
            {
                return _title;
            }
            set
            {
                _title = (value ?? "").HTMLDecodeAndRemove();
            }
        }

        /// <summary>
        /// Is game private.
        /// </summary>
        public Boolean IsPrivate { get; set; }

        /// <summary>
        /// Passphrase for the private game
        /// </summary>
        private String _passphrase { get; set; }
        public String Passphrase
        {
            get
            {
                return _passphrase;
            }
            set
            {
                _passphrase = (value ?? "").HTMLDecodeAndRemove();
            }
        }

		private Int32 _pointsToWin { get; set; }

        /// <summary>
        /// Points to win the game.
        /// </summary>
		public Int32 PointToWin 
		{
			get
			{
				return _pointsToWin;
			}
			set
			{
				if (value < 10)
				{
					_pointsToWin = 10;
				}
				else if(value > 95)
				{
					_pointsToWin = 95;
				}
				else
				{
					_pointsToWin = value;
				}
			}
		}

        /// <summary>
        /// Max number of players for game.
        /// </summary>
        public Int32 MaxNumberOfPlayers { get; set; }

        /// <summary>
        /// The User Id for the game creator.
        /// </summary>
        public Int32 GameCreator_UserId { get; set; }

        /// <summary>
        /// The User object for the game creator.
        /// </summary>
        public User GameCreator { get; set; }

        /// <summary>
        /// The date the game was created.
        /// </summary>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// The last time the game was played.
        /// </summary>
        public DateTime? PlayedLast { get; set; }

        /// <summary>
        /// The date the game ended.
        /// </summary>
        public DateTime? GameOver { get; set; }

        /// <summary>
        /// List of Deck IDs for the game
        /// </summary>
        public List<Int32> GameDeckIDs { get; set; }

		/// <summary>
		/// List of Decks for the game
		/// </summary>
		public List<Deck> GameDecks { get; set; }

        /// <summary>
        /// Number of players in the game
        /// </summary>
        public Int32 PlayerCount { get; set; }

        /// <summary>
        /// List of UserIds for players in the game
        /// </summary>
        public List<GamePlayer> Players { get; set; }

        /// <summary>
        /// Number of rounds in the game so far
        /// </summary>
        public Int32 RoundCount { get; set; }

        /// <summary>
        /// List of Rounds for the game
        /// </summary>
        public List<GameRound> Rounds { get; set; }

		/// <summary>
		/// Number of times questions have be shuffled
		/// </summary>
		public Int32 QuestionShuffleCount { get; set; }

		/// <summary>
		/// Number of times answers have be shuffled
		/// </summary>
		public Int32 AnswerShuffleCount { get; set; }

        /// <summary>
        /// Determine if user is already a player
        /// </summary>
        /// <param name="userID">The userID</param>
        /// <returns></returns>
        public Boolean IsCurrentPlayer(Int32 userID)
        {
            return Players.Find(x => x.User.UserId == userID) != null;
        }

        /// <summary>
        /// Determine if the game is full
        /// </summary>
        /// <returns></returns>
        public Boolean IsFull()
        {
            return PlayerCount == MaxNumberOfPlayers;
        }

        /// <summary>
        /// Determine if the game has rounds
        /// </summary>
        /// <returns></returns>
        public Boolean HasRounds()
        {
            return RoundCount > 0;
        }

        /// <summary>
        /// Determine if the game has required number of players
        /// </summary>
        /// <returns></returns>
        public Boolean HasRequiredNumberOfPlayers()
        {
            return PlayerCount >= RequiredPlayerCount;
        }

        /// <summary>
        /// Determine number of players still needed
        /// </summary>
        /// <returns></returns>
        public Int32 NumberOfPlayersNeededToStart()
        {
            Int32 needed = RequiredPlayerCount - PlayerCount;

            return needed > 0 ? needed : 0;
        }

        /// <summary>
        /// Get the current round
        /// </summary>
        /// <returns>The current round of the game</returns>
		public Entities.GameRound CurrentRound()
		{
			if (this.HasRounds())
			{
				return this.Rounds.LastOrDefault();
			}
			else
			{
				return null;
			}
		}

        /// <summary>
        /// Determine who the card commander is
        /// </summary>
        /// <returns>Current card commander</returns>
        public Entities.User DetermineCommander()
        {
            Entities.User commander;

            if (this.HasRounds())
            {
				commander = this.CurrentRound().CardCommander;
            }
            else
            {
                commander = this.Players.First().User;
            }

            return commander;
        }

        /// <summary>
        /// Determine if user is the card commander
        /// </summary>
        /// <param name="userID">The userID</param>
        /// <returns></returns>
        public Boolean IsCurrentCommander(Int32 userId)
        {
			if (HasRounds())
			{
				return CurrentRound().IsCommander(userId);
			}
			else
			{
				return Players.First().User.UserId == userId;
			}
        }

		/// <summary>
		/// Determine if the game is in waiting state
		/// </summary>
		/// <returns>If the game is still waiting</returns>
		public Boolean IsWaiting()
		{
			if (this.HasRounds())
			{
				if (this.HasRequiredNumberOfPlayers() || GameOver.HasValue)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			else
			{
				return true;
			}
		}

		/// <summary>
		/// Determine if the game has a winner
		/// </summary>
		/// <returns></returns>
		public Boolean HasWinner()
		{
			return Players.Any(x => x.Points >= PointToWin);
		}

		/// <summary>
		/// Get the next commander
		/// </summary>
		/// <param name="newCommander">The winner of the last round</param>
		/// <returns></returns>
		public Entities.User NextCommander(Entities.User newCommander)
		{
			if (newCommander == null)
			{
				Entities.GameRound current = CurrentRound();

				if (current != null)
				{
					newCommander = current.Winner();
				}
			}

			if(newCommander == null || (newCommander != null && Players.Any(x => x.User.UserId == newCommander.UserId) == false))
			{
				newCommander = Players.OrderByDescending(x => x.Points).First().User;
			}

			return newCommander;
		}

        /// <summary>
        /// The current number of spectators
        /// </summary>
        public Int32 SpectatorCount { get; set; }

        /// <summary>
        /// Max number of spectators allowed in a game
        /// </summary>
        public Int32 MaxNumberOfSpectators { get; set; }

        /// <summary>
        /// Determine if the max number of spectators has been reached
        /// </summary>
        /// <returns>If the max number of spectators has been reached</returns>
        public Boolean MaxSpectatorsReached()
        {
            return SpectatorCount >= MaxNumberOfSpectators;
        }

        /// <summary>
        /// List of spectators
        /// </summary>
        public List<GamePlayer> Spectators { get; set; }

        /// <summary>
        /// Determine if user is already a player
        /// </summary>
        /// <param name="userID">The userID</param>
        /// <returns></returns>
        public Boolean IsCurrentSpectator(Int32 userID)
        {
            return Spectators.Find(x => x.User.UserId == userID) != null;
        }

        /// <summary>
        /// The number of seconds a user has to play
        /// </summary>
        public Int32 SecondsToPlay { get; set; }

        /// <summary>
        /// Get the round timer key
        /// </summary>
        public String RoundTimerKey
        {
            get
            {
                return String.Format(RoundTimerCacheKey, GameID.ToString());
            }
        }
		
        /// <summary>
        /// Is the game persistent
        /// </summary>
        public Boolean IsPersistent { get; set; }
    }
}

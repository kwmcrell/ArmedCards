using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.Entities.Models.Game.Listing
{
    /// <summary>
    /// View model used to render the game in the listing screen
    /// </summary>
    public class Game
    {
        public Game() { }

        public Game(Entities.Game game, Int32 currentUserId = 0)
        {
            this.GameID = game.GameID;
            this.Title = game.Title;
            this.IsPrivate = game.IsPrivate;
            this.PointToWin = game.PointToWin;
            this.MaxNumberOfPlayers = game.MaxNumberOfPlayers;
            this.DateCreated = game.DateCreated;
            this.PlayedLast = game.PlayedLast;
            this.GameDecks = game.GameDecks;
            this.PlayerCount = game.PlayerCount;
            this.Players = game.Players;
            this.SpectatorCount = game.SpectatorCount;
            this.MaxNumberOfSpectators = game.MaxNumberOfSpectators;
            this.IsPersistent = game.IsPersistent;
            this.OfficialDeckCount = game.OfficialDeckCount;
            this.AllowSpectators = game.MaxNumberOfSpectators > 0;
            this.IsFull = game.IsFull();
            this.IsCurrentPlayer = game.IsCurrentPlayer(currentUserId);
            this.MaxSpectatorsReached = game.MaxSpectatorsReached();
            this.IsCurrentSpectator = game.IsCurrentSpectator(currentUserId);
        }

        /// <summary>
        /// Game ID
        /// </summary>
        public Int32 GameID { get; set; }

        /// <summary>
        /// The game title
        /// </summary>
        public String Title { get; set; }

        /// <summary>
        /// Is game private.
        /// </summary>
        public Boolean IsPrivate { get; set; }

        /// <summary>
        /// Points to win the game.
        /// </summary>
        public Int32 PointToWin { get; set; }

        /// <summary>
        /// Max number of players for game.
        /// </summary>
        public Int32 MaxNumberOfPlayers { get; set; }

        /// <summary>
        /// The date the game was created.
        /// </summary>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// The last time the game was played.
        /// </summary>
        public DateTime? PlayedLast { get; set; }

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
        /// Determine if the game is full
        /// </summary>
        public Boolean IsFull { get; set; }

        /// <summary>
        /// The current number of spectators
        /// </summary>
        public Int32 SpectatorCount { get; set; }

        /// <summary>
        /// Max number of spectators allowed in a game
        /// </summary>
        public Int32 MaxNumberOfSpectators { get; set; }

        /// <summary>
        /// Is the game persistent
        /// </summary>
        public Boolean IsPersistent { get; set; }

        /// <summary>
        /// The number of official decks
        /// </summary>
        public Int32 OfficialDeckCount { get; set; }

        /// <summary>
        /// Game allows spectators
        /// </summary>
        public Boolean AllowSpectators { get; set; }

        /// <summary>
        /// Is current player
        /// </summary>
        public Boolean IsCurrentPlayer { get; set; }

        /// <summary>
        /// Are spectators full
        /// </summary>
        public Boolean MaxSpectatorsReached { get; set; }

        /// <summary>
        /// Is a current spectator
        /// </summary>
        public Boolean IsCurrentSpectator { get; set; }
    }
}

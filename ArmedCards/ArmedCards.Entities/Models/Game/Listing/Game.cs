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
        /// <summary>
        /// The game to display
        /// </summary>
        public Entities.Game Value { get; set; }

        /// <summary>
        /// The max number of official decks
        /// </summary>
        public Int32 MaxOfficialDecks { get; set; }
    }
}

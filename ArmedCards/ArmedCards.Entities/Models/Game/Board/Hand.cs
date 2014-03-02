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
    /// View Model used to render the player's hand
    /// </summary>
    public class Hand
    {
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="show"></param>
        /// <param name="cards"></param>
        /// <param name="showBoard"></param>
        public Hand(Boolean show, List<Entities.GamePlayerCard> cards, Boolean showBoard)
        {
            this.Show = show;
            this.Cards = cards;
            this.ShowBoard = showBoard;
        }

        /// <summary>
        /// Show hand
        /// </summary>
        public Boolean Show { get; private set; }

        /// <summary>
        /// The player's cards
        /// </summary>
        public List<Entities.GamePlayerCard> Cards { get; private set; }

        /// <summary>
        /// Should the board be showing
        /// </summary>
        public Boolean ShowBoard { get; private set; }
    }
}

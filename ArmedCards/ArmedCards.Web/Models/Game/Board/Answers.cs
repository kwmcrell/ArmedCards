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
    /// View model used to render the answers section of the board
    /// </summary>
    public class Answers
    {
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="roundHasWinner"></param>
        /// <param name="isCommander"></param>
        /// <param name="waitingOnAllAnswers"></param>
        /// <param name="showAnswers"></param>
        /// <param name="handShowing"></param>
        /// <param name="showBoard"></param>
        /// <param name="groupedAnswers"></param>
        public Answers(Boolean roundHasWinner,
                        Boolean isCommander,
                        Boolean waitingOnAllAnswers,
                        Boolean showAnswers,
                        Boolean handShowing,
                        Boolean showBoard,
                        List<IGrouping<Int32, Entities.GameRoundCard>> groupedAnswers)
        {
            this.RoundHasWinner = roundHasWinner;
            this.IsCommander = isCommander;
            this.WaitingOnAllAnswers = waitingOnAllAnswers;
            this.ShowAnswers = showAnswers;
            this.HandShowing = handShowing;
            this.ShowBoard = showBoard;

            if(groupedAnswers != null)
            {
                this.GroupedAnswers = groupedAnswers.Select(x => new Entities.GroupedAnswers(x.Key, x.ToList()))
                                                .ToList();
            }
            else
            {
                this.GroupedAnswers = new List<Entities.GroupedAnswers>();
            }
        }

        /// <summary>
        /// Does the round have a winner
        /// </summary>
        public Boolean RoundHasWinner { get; private set; }

        /// <summary>
        /// Grouped answers by played by user id
        /// </summary>
        public List<Entities.GroupedAnswers> GroupedAnswers { get; private set; }

        /// <summary>
        /// Is the user the commander
        /// </summary>
        public Boolean IsCommander { get; private set; }

        /// <summary>
        /// Waiting on answers to be played
        /// </summary>
        public Boolean WaitingOnAllAnswers { get; private set; }

        /// <summary>
        /// All answers have been played
        /// </summary>
        public Boolean ShowAnswers { get; private set; }

        /// <summary>
        /// Is the player's hand being shown
        /// </summary>
        public Boolean HandShowing { get; private set; }

        /// <summary>
        /// Should the board be showing
        /// </summary>
        public Boolean ShowBoard { get; private set; }
    }
}

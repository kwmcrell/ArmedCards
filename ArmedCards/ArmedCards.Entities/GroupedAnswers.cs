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

namespace ArmedCards.Entities
{
    /// <summary>
    /// Representation of grouped answers
    /// </summary>
    public class GroupedAnswers
    {
        /// <summary>
        /// Constructors
        /// </summary>
        /// <param name="key"></param>
        /// <param name="answers"></param>
        public GroupedAnswers(Int32 key, List<Entities.GameRoundCard> answers)
        {
            this.Key = key;
            this.Answers = answers.OrderBy(x => x.PlayOrder).ToList();

            Entities.GameRoundCard firstCard = Answers.First();

            this.PlayedBy = firstCard.PlayedBy;
            this.Winner = firstCard.Winner;
            this.AnswerCount = Answers.Count;
            this.AutoPlayed = firstCard.AutoPlayed;
        }

        /// <summary>
        /// The key used to group answers
        /// </summary>
        public Int32 Key { get; private set; }

        /// <summary>
        /// These answers were played by this user
        /// </summary>
        public Entities.User PlayedBy { get; private set; }
        
        /// <summary>
        /// Winner of round
        /// </summary>
        public Boolean Winner { get; private set; }

        /// <summary>
        /// Sorted answers by played order
        /// </summary>
        public List<Entities.GameRoundCard> Answers { get; private set; }

        /// <summary>
        /// The answer count
        /// </summary>
        public Int32 AnswerCount { get; private set; }

        public Boolean AutoPlayed { get; private set; }
    }
}

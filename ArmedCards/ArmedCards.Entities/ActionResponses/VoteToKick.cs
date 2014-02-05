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

namespace ArmedCards.Entities.ActionResponses
{
	/// <summary>
	/// Defines a vote to kick response
	/// </summary>
	public class VoteToKick
	{
		public VoteToKick()
		{
			AlreadyVoted = new List<Int32>();
		}

		/// <summary>
		/// Vote to kick response code
		/// </summary>
		public Enums.VoteToKick ResponseCode { get; set; }

		/// <summary>
		/// Votes to Kick a user
		/// </summary>
		public Int32 VotesToKick { get; set; }

		/// <summary>
		/// Votes to keep a user
		/// </summary>
		public Int32 VotesToStay { get; set; }

		/// <summary>
		/// The game
		/// </summary>
		public Entities.Game Game { get; set; }

		/// <summary>
		/// Total number of votes casted
		/// </summary>
		public Int32 TotalVotes 
		{
			get
			{
				return VotesToKick + VotesToStay;
			}
		}

		/// <summary>
		/// User Ids for anyone who has already voted
		/// </summary>
		public List<Int32> AlreadyVoted { get; set; }

		/// <summary>
		/// The user to kick
		/// </summary>
		public Entities.User KickUser { get; set; }

        /// <summary>
        /// All users have voted
        /// </summary>
        public Boolean AllVotesCasted 
        { 
            get
            {
                return TotalVotes >= TotalPlayers;
            }
        }

        /// <summary>
        /// Number of players in the game
        /// </summary>
        public Int32 TotalPlayers { get; set; }
	}
}

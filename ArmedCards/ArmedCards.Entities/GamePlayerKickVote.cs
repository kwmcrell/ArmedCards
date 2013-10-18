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
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;

namespace ArmedCards.Entities
{
	/// <summary>
	/// Defines a game player's vote to kick
	/// </summary>
	public class GamePlayerKickVote
	{
		public GamePlayerKickVote(IDataReader idr)
			:this()
		{
			GameID = idr.GetValueByName<Int32>("GameID");
			KickUserId = idr.GetValueByName<Int32>("KickUserId");
			Vote = idr.GetValueByName<Boolean>("Vote");
			VotedUserId = idr.GetValueByName<Int32>("VotedUserId");
		}

		public GamePlayerKickVote()
		{
			
		}

		/// <summary>
		/// The id of the game the vote was casted for
		/// </summary>
		public Int32 GameID { get; set; }

		/// <summary>
		/// The id of the user voted to kick
		/// </summary>
		public Int32 KickUserId { get; set; }

		/// <summary>
		/// The id of the user voting
		/// </summary>
		public Int32 VotedUserId { get; set; }

		/// <summary>
		/// Voted to kick the user
		/// </summary>
		public Boolean Vote { get; set; }

		/// <summary>
		/// Action to call to check votes
		/// </summary>
		public Action<Int32, Int32, String> CheckVotes;

		/// <summary>
		/// Calls CheckVotes
		/// </summary>
		public void ExecuteCheckVotes(String siteHost)
		{
			if (CheckVotes != null)
			{
				CheckVotes(GameID, KickUserId, siteHost);
			}
		}
	}
}

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

using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using REPO = ArmedCards.BusinessLogic.Repositories.GamePlayerKickVote;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerKickVote
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IInsert"/>
	/// </summary>
	public class Insert : Base.IInsert
	{
		private REPO.Base.IInsert _insert;
		private AS.Game.Base.ISelect _selectGame;

		public Insert(REPO.Base.IInsert insert, AS.Game.Base.ISelect selectGame)
		{
			this._insert = insert;
			this._selectGame = selectGame;
		}

		/// <summary>
		/// Insert a vote to kick a user <paramref name="vote"/>
		/// </summary>
		/// <param name="vote">The user's vote to kick</param>
		/// <returns></returns>
		public Entities.ActionResponses.VoteToKick Execute(Entities.GamePlayerKickVote vote)
		{
			Entities.ActionResponses.VoteToKick response = new Entities.ActionResponses.VoteToKick();

			Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
			filter.DataToSelect = Entities.Enums.Game.Select.None;
			filter.GameID = vote.GameID;

			Entities.Game game = _selectGame.Execute(filter);

			if (game.IsCurrentPlayer(vote.VotedUserId))
			{
				response = _insert.Execute(vote);
				response.ResponseCode = Entities.ActionResponses.Enums.VoteToKick.VoteSuccessful;
				response.Game = game;

				if (vote.Vote)
				{
					response.VotesToKick++;
				}
				else
				{
					response.VotesToStay++;
				}

				return response;
			}
			else
			{
				response.ResponseCode = Entities.ActionResponses.Enums.VoteToKick.IneligiblePlayerToVote;
				return response;
			}
		}
	}
}

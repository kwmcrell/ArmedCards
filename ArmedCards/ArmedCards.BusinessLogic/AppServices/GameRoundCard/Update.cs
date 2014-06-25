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
using ArmedCards.Library.Extensions;
using DS = ArmedCards.BusinessLogic.DomainServices.GameRoundCard;

namespace ArmedCards.BusinessLogic.AppServices.GameRoundCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IUpdate"/>
	/// </summary>
	public class Update : Base.IUpdate
	{
		private DS.Base.IUpdate _updateGameRoundCard;

		public Update(DS.Base.IUpdate updateGameRoundCard)
		{
			this._updateGameRoundCard = updateGameRoundCard;
		}

		/// <summary>
		/// Update winning cards for the round
		/// </summary>
		/// <param name="filter"></param>
        /// <returns>If the winner was an auto played card</returns>
		public Boolean Execute(Entities.Filters.GameRoundCard.UpdateWinner filter)
		{
			return _updateGameRoundCard.Execute(filter);
		}
	}
}

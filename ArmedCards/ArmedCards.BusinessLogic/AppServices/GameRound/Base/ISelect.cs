﻿/*
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

namespace ArmedCards.BusinessLogic.AppServices.GameRound.Base
{
	/// <summary>
	/// Interface defining Select for GameRound
	/// </summary>
	public interface ISelect
	{
		/// <summary>
		/// Selects game rounds base on gameID
		/// </summary>
		/// <param name="gameID">Filter used to select game rounds</param>
		/// <returns>A list of game rounds that satisfy the supplied filter</returns>
		List<Entities.GameRound> Execute(Int32 gameID);

		/// <summary>
		/// Selects the current round for a game
		/// </summary>
		/// <param name="gameID">Filter used to select game rounds</param>
		/// <param name="selectCards">Select cards for the round</param>
		/// <returns>The current round</returns>
		Entities.GameRound Execute(Int32 gameID, Boolean selectCards);

        /// <summary>
        /// Selects game rounds base on supplied filter
        /// </summary>
        /// <param name="filter">Filter used to select game rounds</param>
        /// <returns>A list of game rounds that satisfy the supplied filter</returns>
        List<Entities.GameRound> Execute(Entities.Filters.GameRound.SelectCompleted filter);
	}
}

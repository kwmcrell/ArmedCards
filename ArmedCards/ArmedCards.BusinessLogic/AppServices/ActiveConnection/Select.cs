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
using DS = ArmedCards.BusinessLogic.DomainServices.ActiveConnection;

namespace ArmedCards.BusinessLogic.AppServices.ActiveConnection
{
    /// <summary>
    /// Implementation of ISelect
    /// </summary>
    public class Select : Base.ISelect
    {
        private DS.Base.ISelect _selectActiveConnection;

        public Select(DS.Base.ISelect selectActiveConnection)
        {
            this._selectActiveConnection = selectActiveConnection;
        }

        /// <summary>
        /// Return all active connections that match the filter
        /// </summary>
        /// <param name="filter">The filter used to select active connections</param>
        /// <returns>A list of active connections</returns>
        public List<Entities.ActiveConnection> Execute(Entities.Filters.ActiveConnection.SelectAll filter)
        {
            return _selectActiveConnection.Execute(filter);
        }

        /// <summary>
        /// Return active connection that match the filter
        /// </summary>
        /// <param name="filter">The filter used to select a active connection</param>
        /// <returns>A active connection</returns>
        public Entities.ActiveConnection Execute(Entities.Filters.ActiveConnection.Select filter)
        {
            return _selectActiveConnection.Execute(filter);
        }
    }
}

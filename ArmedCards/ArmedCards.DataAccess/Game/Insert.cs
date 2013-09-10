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

namespace ArmedCards.DataAccess.Game
{
    /// <summary>
    /// Implementation of IInsert
    /// </summary>
    public class Insert : Base.IInsert
    {
        private Database db;

        /// <summary>
        /// Dependency Injected Constructor
        /// </summary>
        /// <param name="db">Database</param>
        public Insert(Database db)
        {
            this.db = db;
        }

        /// <summary>
        /// Insert a new game into the game table
        /// </summary>
        /// <param name="user">The game to insert</param>
        public void Execute(Entities.Game game)
        {
            using (DbCommand cmd = db.GetStoredProcCommand("Game_Insert"))
            {
                db.AddInParameter(cmd, "@Title",                DbType.String,      game.Title.HTMLEncode());
                db.AddInParameter(cmd, "@IsPrivate",            DbType.Boolean,     game.IsPrivate);
                db.AddInParameter(cmd, "@Passphrase",             DbType.String,      game.Passphrase.HTMLEncode());
                db.AddInParameter(cmd, "@PointsToWin",          DbType.Int32,       game.PointToWin);
                db.AddInParameter(cmd, "@MaxNumberOfPlayers",   DbType.Int32,       game.MaxNumberOfPlayers);
                db.AddInParameter(cmd, "@GameCreator_UserId",   DbType.Int32,       game.GameCreator_UserId);
                db.AddInParameter(cmd, "@DateCreated",          DbType.DateTime,    DateTime.UtcNow);
                db.AddInParameter(cmd, "@PlayedLast",           DbType.DateTime,    game.PlayedLast);
                db.AddInParameter(cmd, "@GameOver",             DbType.DateTime,    game.GameOver);
                db.AddInParameter(cmd, "@GameDeckIDs",         DbType.Xml,         game.GameDeckIDs.ConvertCollectionToXML());
                
                db.AddOutParameter(cmd, "NewID",                DbType.Int32,       sizeof(Int32));

                db.ExecuteScalar(cmd);
                game.GameID = Int32.Parse(db.GetParameterValue(cmd, "NewID").ToString());
            }
        }
    }
}

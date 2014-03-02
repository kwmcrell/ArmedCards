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
using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ArmedCards.BusinessLogic
{
    /// <summary>
    /// Class responsible for handling Unity Type Registration
    /// </summary>
    public class UnityConfig
    {
        public static IUnityContainer Container { get; set; }

        public static void InitContainer()
        {
            Container = new UnityContainer();

            Container.RegisterInstance(DatabaseFactory.CreateDatabase("DefaultConnection"));

            #region "User"

            Container.RegisterType<BusinessLogic.AppServices.User.Base.IInsert,                 BusinessLogic.AppServices.User.Insert>();
            Container.RegisterType<BusinessLogic.DomainServices.User.Base.IInsert,              BusinessLogic.DomainServices.User.Insert>();
            Container.RegisterType<BusinessLogic.Repositories.User.Base.IInsert,                BusinessLogic.Repositories.User.Insert>();

            Container.RegisterType<DataAccess.User.Base.IInsert,                                DataAccess.User.Insert>();

			Container.RegisterType<BusinessLogic.AppServices.User.Base.ISelect,					BusinessLogic.AppServices.User.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.User.Base.ISelect,				BusinessLogic.DomainServices.User.Select>();
			Container.RegisterType<BusinessLogic.Repositories.User.Base.ISelect,				BusinessLogic.Repositories.User.Select>();

			Container.RegisterType<DataAccess.User.Base.ISelect,								DataAccess.User.Select>();

			Container.RegisterType<BusinessLogic.AppServices.User.Base.IUpdate,					BusinessLogic.AppServices.User.Update>();
			Container.RegisterType<BusinessLogic.DomainServices.User.Base.IUpdate,				BusinessLogic.DomainServices.User.Update>();
			Container.RegisterType<BusinessLogic.Repositories.User.Base.IUpdate,				BusinessLogic.Repositories.User.Update>();

			Container.RegisterType<DataAccess.User.Base.IUpdate,								DataAccess.User.Update>();

            #endregion "User"

            #region "Game"

            Container.RegisterType<BusinessLogic.AppServices.Game.Base.IInsert,                 BusinessLogic.AppServices.Game.Insert>();
            Container.RegisterType<BusinessLogic.DomainServices.Game.Base.IInsert,              BusinessLogic.DomainServices.Game.Insert>();
            Container.RegisterType<BusinessLogic.Repositories.Game.Base.IInsert,                BusinessLogic.Repositories.Game.Insert>();

            Container.RegisterType<DataAccess.Game.Base.IInsert,                                DataAccess.Game.Insert>();

            Container.RegisterType<BusinessLogic.AppServices.Game.Base.ISelect,                 BusinessLogic.AppServices.Game.Select>();
            Container.RegisterType<BusinessLogic.DomainServices.Game.Base.ISelect,              BusinessLogic.DomainServices.Game.Select>();
            Container.RegisterType<BusinessLogic.Repositories.Game.Base.ISelect,                BusinessLogic.Repositories.Game.Select>();

            Container.RegisterType<DataAccess.Game.Base.ISelect,                                DataAccess.Game.Select>();

            Container.RegisterType<BusinessLogic.AppServices.Game.Base.IValidatePassphrase,     BusinessLogic.AppServices.Game.ValidatePassphrase>();
            Container.RegisterType<BusinessLogic.DomainServices.Game.Base.IValidatePassphrase,  BusinessLogic.DomainServices.Game.ValidatePassphrase>();

            Container.RegisterType<BusinessLogic.AppServices.Game.Base.IJoin,                   BusinessLogic.AppServices.Game.Join>();
            Container.RegisterType<BusinessLogic.DomainServices.Game.Base.IJoin,                BusinessLogic.DomainServices.Game.Join>();
			Container.RegisterType<BusinessLogic.Repositories.Game.Base.IJoin,					BusinessLogic.Repositories.Game.Join>();

			Container.RegisterType<BusinessLogic.AppServices.Game.Base.ILeave,					BusinessLogic.AppServices.Game.Leave>();
			Container.RegisterType<BusinessLogic.DomainServices.Game.Base.ILeave,				BusinessLogic.DomainServices.Game.Leave>();
			Container.RegisterType<BusinessLogic.Repositories.Game.Base.ILeave,					BusinessLogic.Repositories.Game.Leave>();

			Container.RegisterType<BusinessLogic.AppServices.Game.Base.IStart,					BusinessLogic.AppServices.Game.Start>();

			Container.RegisterType<BusinessLogic.AppServices.Game.Base.IUpdate,					BusinessLogic.AppServices.Game.Update>();
			Container.RegisterType<BusinessLogic.DomainServices.Game.Base.IUpdate,				BusinessLogic.DomainServices.Game.Update>();
			Container.RegisterType<BusinessLogic.Repositories.Game.Base.IUpdate,				BusinessLogic.Repositories.Game.Update>();

			Container.RegisterType<DataAccess.Game.Base.IUpdate,								DataAccess.Game.Update>();

            #endregion "Game"

            #region "Active Connection"

            Container.RegisterType<BusinessLogic.AppServices.ActiveConnection.Base.IInsert,     BusinessLogic.AppServices.ActiveConnection.Insert>();
            Container.RegisterType<BusinessLogic.DomainServices.ActiveConnection.Base.IInsert,  BusinessLogic.DomainServices.ActiveConnection.Insert>();
            Container.RegisterType<BusinessLogic.Repositories.ActiveConnection.Base.IInsert,    BusinessLogic.Repositories.ActiveConnection.Insert>();

            Container.RegisterType<DataAccess.ActiveConnection.Base.IInsert,                    DataAccess.ActiveConnection.Insert>();

            Container.RegisterType<BusinessLogic.AppServices.ActiveConnection.Base.ISelect,     BusinessLogic.AppServices.ActiveConnection.Select>();
            Container.RegisterType<BusinessLogic.DomainServices.ActiveConnection.Base.ISelect,  BusinessLogic.DomainServices.ActiveConnection.Select>();
            Container.RegisterType<BusinessLogic.Repositories.ActiveConnection.Base.ISelect,    BusinessLogic.Repositories.ActiveConnection.Select>();

            Container.RegisterType<DataAccess.ActiveConnection.Base.ISelect,                    DataAccess.ActiveConnection.Select>();

            Container.RegisterType<BusinessLogic.AppServices.ActiveConnection.Base.IDelete,     BusinessLogic.AppServices.ActiveConnection.Delete>();
            Container.RegisterType<BusinessLogic.DomainServices.ActiveConnection.Base.IDelete,  BusinessLogic.DomainServices.ActiveConnection.Delete>();
            Container.RegisterType<BusinessLogic.Repositories.ActiveConnection.Base.IDelete,    BusinessLogic.Repositories.ActiveConnection.Delete>();

            Container.RegisterType<DataAccess.ActiveConnection.Base.IDelete,                    DataAccess.ActiveConnection.Delete>();

            #endregion "Active Connection"

            #region "Game Player"
            
			Container.RegisterType<BusinessLogic.Repositories.GamePlayer.Base.IInsert,          BusinessLogic.Repositories.GamePlayer.Insert>();

            Container.RegisterType<DataAccess.GamePlayer.Base.IInsert,                          DataAccess.GamePlayer.Insert>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayer.Base.ISelect,			BusinessLogic.AppServices.GamePlayer.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayer.Base.ISelect,		BusinessLogic.DomainServices.GamePlayer.Select>();
            Container.RegisterType<BusinessLogic.Repositories.GamePlayer.Base.ISelect,          BusinessLogic.Repositories.GamePlayer.Select>();

            Container.RegisterType<DataAccess.GamePlayer.Base.ISelect,                          DataAccess.GamePlayer.Select>();

			Container.RegisterType<BusinessLogic.Repositories.GamePlayer.Base.IDelete,			BusinessLogic.Repositories.GamePlayer.Delete>();

			Container.RegisterType<DataAccess.GamePlayer.Base.IDelete,							DataAccess.GamePlayer.Delete>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayer.Base.IUpdate,			BusinessLogic.AppServices.GamePlayer.Update>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayer.Base.IUpdate,		BusinessLogic.DomainServices.GamePlayer.Update>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayer.Base.IUpdate,			BusinessLogic.Repositories.GamePlayer.Update>();

			Container.RegisterType<DataAccess.GamePlayer.Base.IUpdate,							DataAccess.GamePlayer.Update>();

			#endregion "Game Player"

			#region "Deck"

			Container.RegisterType<BusinessLogic.AppServices.Deck.Base.ISelect,					BusinessLogic.AppServices.Deck.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.Deck.Base.ISelect,				BusinessLogic.DomainServices.Deck.Select>();
			Container.RegisterType<BusinessLogic.Repositories.Deck.Base.ISelect,				BusinessLogic.Repositories.Deck.Select>();

			Container.RegisterType<DataAccess.Deck.Base.ISelect,								DataAccess.Deck.Select>();

			#endregion "Deck"

			#region "Card"

			Container.RegisterType<BusinessLogic.AppServices.Card.Base.ISelect,					BusinessLogic.AppServices.Card.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.Card.Base.ISelect,				BusinessLogic.DomainServices.Card.Select>();
			Container.RegisterType<BusinessLogic.Repositories.Card.Base.ISelect,				BusinessLogic.Repositories.Card.Select>();

			Container.RegisterType<DataAccess.Card.Base.ISelect,								DataAccess.Card.Select>();

			Container.RegisterType<BusinessLogic.DomainServices.Card.Base.IExcludeByCount,		BusinessLogic.DomainServices.Card.ExcludeByCount>();

			Container.RegisterType<BusinessLogic.DomainServices.Card.Base.IExcludeCurrentHands, BusinessLogic.DomainServices.Card.ExcludeCurrentHands>();

			Container.RegisterType<BusinessLogic.DomainServices.Card.Base.IShuffle,				BusinessLogic.DomainServices.Card.Shuffle>();

			#endregion "Card"

            #region "Hubs"

            Container.RegisterType<BusinessLogic.AppServices.Hubs.Base.ISendMessage, BusinessLogic.AppServices.Hubs.SendMessage>();

            #endregion "Hubs"

            #region "Game Round"

            Container.RegisterType<BusinessLogic.AppServices.GameRound.Base.IInsert,			BusinessLogic.AppServices.GameRound.Insert>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRound.Base.IInsert,			BusinessLogic.DomainServices.GameRound.Insert>();
			Container.RegisterType<BusinessLogic.Repositories.GameRound.Base.IInsert,			BusinessLogic.Repositories.GameRound.Insert>();

			Container.RegisterType<DataAccess.GameRound.Base.IInsert,							DataAccess.GameRound.Insert>();

			Container.RegisterType<BusinessLogic.AppServices.GameRound.Base.IStart,				BusinessLogic.AppServices.GameRound.Start>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRound.Base.IStart,			BusinessLogic.DomainServices.GameRound.Start>();

			Container.RegisterType<BusinessLogic.AppServices.GameRound.Base.ISelect,			BusinessLogic.AppServices.GameRound.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRound.Base.ISelect,			BusinessLogic.DomainServices.GameRound.Select>();
			Container.RegisterType<BusinessLogic.Repositories.GameRound.Base.ISelect,			BusinessLogic.Repositories.GameRound.Select>();

			Container.RegisterType<DataAccess.GameRound.Base.ISelect,							DataAccess.GameRound.Select>();

			Container.RegisterType<BusinessLogic.AppServices.GameRound.Base.IComplete,			BusinessLogic.AppServices.GameRound.Complete>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRound.Base.IComplete,		BusinessLogic.DomainServices.GameRound.Complete>();

			Container.RegisterType<BusinessLogic.AppServices.GameRound.Base.IDelete,			BusinessLogic.AppServices.GameRound.Delete>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRound.Base.IDelete,			BusinessLogic.DomainServices.GameRound.Delete>();
			Container.RegisterType<BusinessLogic.Repositories.GameRound.Base.IDelete,			BusinessLogic.Repositories.GameRound.Delete>();

			Container.RegisterType<DataAccess.GameRound.Base.IDelete,							DataAccess.GameRound.Delete>();

			#endregion "Game Round"

			#region "Game Player Card"

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerCard.Base.IDeal,			BusinessLogic.AppServices.GamePlayerCard.Deal>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.IDeal,		BusinessLogic.DomainServices.GamePlayerCard.Deal>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerCard.Base.IPlay,			BusinessLogic.AppServices.GamePlayerCard.Play>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.IPlay,		BusinessLogic.DomainServices.GamePlayerCard.Play>();

			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.IInsert,	BusinessLogic.DomainServices.GamePlayerCard.Insert>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayerCard.Base.IInsert,		BusinessLogic.Repositories.GamePlayerCard.Insert>();

			Container.RegisterType<DataAccess.GamePlayerCard.Base.IInsert,						DataAccess.GamePlayerCard.Insert>();

			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.ICalculateDrawCount, 
									BusinessLogic.DomainServices.GamePlayerCard.CalculateDrawCount>();
			
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.ICreateHand, 
									BusinessLogic.DomainServices.GamePlayerCard.CreateHand>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerCard.Base.ISelect,		BusinessLogic.AppServices.GamePlayerCard.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.ISelect,	BusinessLogic.DomainServices.GamePlayerCard.Select>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayerCard.Base.ISelect,		BusinessLogic.Repositories.GamePlayerCard.Select>();

			Container.RegisterType<DataAccess.GamePlayerCard.Base.ISelect,						DataAccess.GamePlayerCard.Select>();

			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerCard.Base.IDelete,	BusinessLogic.DomainServices.GamePlayerCard.Delete>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayerCard.Base.IDelete,		BusinessLogic.Repositories.GamePlayerCard.Delete>();

			Container.RegisterType<DataAccess.GamePlayerCard.Base.IDelete,						DataAccess.GamePlayerCard.Delete>();

			#endregion "Game Player Card"

			#region "Game Player Kick Vote"

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerKickVote.Base.IInsert, BusinessLogic.AppServices.GamePlayerKickVote.Insert>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerKickVote.Base.IInsert, BusinessLogic.DomainServices.GamePlayerKickVote.Insert>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayerKickVote.Base.IInsert, BusinessLogic.Repositories.GamePlayerKickVote.Insert>();

			Container.RegisterType<DataAccess.GamePlayerKickVote.Base.IInsert, DataAccess.GamePlayerKickVote.Insert>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerKickVote.Base.ICheckVotes, BusinessLogic.AppServices.GamePlayerKickVote.CheckVotes>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerKickVote.Base.ICheckVotes, BusinessLogic.DomainServices.GamePlayerKickVote.CheckVotes>();

			Container.RegisterType<BusinessLogic.AppServices.GamePlayerKickVote.Base.ISelect, BusinessLogic.AppServices.GamePlayerKickVote.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.GamePlayerKickVote.Base.ISelect, BusinessLogic.DomainServices.GamePlayerKickVote.Select>();
			Container.RegisterType<BusinessLogic.Repositories.GamePlayerKickVote.Base.ISelect, BusinessLogic.Repositories.GamePlayerKickVote.Select>();

			Container.RegisterType<DataAccess.GamePlayerKickVote.Base.ISelect, DataAccess.GamePlayerKickVote.Select>();

			#endregion "Game Player Kick Vote"

			#region "Game Round Card"

			Container.RegisterType<BusinessLogic.AppServices.GameRoundCard.Base.IInsert,		BusinessLogic.AppServices.GameRoundCard.Insert>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRoundCard.Base.IInsert,		BusinessLogic.DomainServices.GameRoundCard.Insert>();
			Container.RegisterType<BusinessLogic.Repositories.GameRoundCard.Base.IInsert,		BusinessLogic.Repositories.GameRoundCard.Insert>();

			Container.RegisterType<DataAccess.GameRoundCard.Base.IInsert,						DataAccess.GameRoundCard.Insert>();

			Container.RegisterType<BusinessLogic.AppServices.GameRoundCard.Base.ISelect,		BusinessLogic.AppServices.GameRoundCard.Select>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRoundCard.Base.ISelect,		BusinessLogic.DomainServices.GameRoundCard.Select>();
			Container.RegisterType<BusinessLogic.Repositories.GameRoundCard.Base.ISelect,		BusinessLogic.Repositories.GameRoundCard.Select>();

			Container.RegisterType<DataAccess.GameRoundCard.Base.ISelect,						DataAccess.GameRoundCard.Select>();

			Container.RegisterType<BusinessLogic.AppServices.GameRoundCard.Base.IUpdate,		BusinessLogic.AppServices.GameRoundCard.Update>();
			Container.RegisterType<BusinessLogic.DomainServices.GameRoundCard.Base.IUpdate,		BusinessLogic.DomainServices.GameRoundCard.Update>();
			Container.RegisterType<BusinessLogic.Repositories.GameRoundCard.Base.IUpdate,		BusinessLogic.Repositories.GameRoundCard.Update>();

			Container.RegisterType<DataAccess.GameRoundCard.Base.IUpdate,						DataAccess.GameRoundCard.Update>();

			#endregion "Game Round Card"

            #region "Leaderboard"

            Container.RegisterType<BusinessLogic.AppServices.Leaderboard.Base.ISelect,      BusinessLogic.AppServices.Leaderboard.Select>();
            Container.RegisterType<BusinessLogic.DomainServices.Leaderboard.Base.ISelect,   BusinessLogic.DomainServices.Leaderboard.Select>();
            Container.RegisterType<BusinessLogic.Repositories.Leaderboard.Base.ISelect,     BusinessLogic.Repositories.Leaderboard.Select>();

            Container.RegisterType<DataAccess.Leaderboard.Base.ISelect,                     DataAccess.Leaderboard.Select>();

            #endregion "Leaderboard"
        }
    }
}
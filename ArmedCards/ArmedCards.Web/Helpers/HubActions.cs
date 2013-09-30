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

using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ArmedCards.Web.Helpers
{
	/// <summary>
	/// Fake Controller used to render partial views in Hub Actions Class
	/// </summary>
	public class FakeController : Controller
	{ }

	/// <summary>
	/// Class that defines Actions to send to the SendMessage App Service
	/// </summary>
	public static class HubActions
	{
		/// <summary>
		/// Sends an update for the waiting screen
		/// </summary>
		/// <param name="connection">Connection to send to</param>
		/// <param name="game">The current game</param>
		public static void SendWaitingMessage(Entities.ActiveConnection connection, Entities.Game game)
		{
			IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

			var lobbyView = new
			{
				LobbyView = GetRazorViewAsString("~/Views/Game/Board/Sidebar/_Players.cshtml", game.Players)
			};

			hub.Clients.Client(connection.ActiveConnectionID)
					   .UpdateWaiting(Helpers.WaitingHeader.Build(game, connection.User_UserId), lobbyView);
		}

		/// <summary>
		/// Sends an update for the game has been stated
		/// </summary>
		/// <param name="connection">Connection to send to</param>
		/// <param name="game">The current game</param>
		/// <param name="cards">The cards in the hand of the user the connection belongs to</param>
		public static void SendGameStartedMessage(Entities.ActiveConnection connection, Entities.Game game,
												  List<Entities.GamePlayerCard> cards)
		{
			IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

			Models.Game.Board.GameBoard model = new Models.Game.Board.GameBoard();
			model.Game = game;
			model.UserId = connection.User_UserId;
			model.Hand = cards;

			string partialView = GetRazorViewAsString("~/Views/Game/Board/Partials/_Game.cshtml", model);

			hub.Clients.Client(connection.ActiveConnectionID)
					   .UpdateGame(partialView);
		}

		/// <summary>
		/// Sends an update for a card played in the round
		/// </summary>
		/// <param name="connection">Connection to send to</param>
		/// <param name="game">The current game</param>
		public static void CardPlayed(Entities.ActiveConnection connection, Entities.Game game)
		{
			IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

			Models.Game.Board.GameBoard model = new Models.Game.Board.GameBoard
			{
				Game = game,
				Hand = game.Players.Find(x => x.User.UserId == connection.User_UserId).Hand,
				UserId = connection.User_UserId
			};

			string partialView = GetRazorViewAsString("~/Views/Game/Board/Answers/_Answers.cshtml", model);

			hub.Clients.Client(connection.ActiveConnectionID)
							   .UpdateAnswers(partialView, !model.ShowHand());
		}

		/// <summary>
		/// Sends an update that a winnder has been selected
		/// </summary>
		/// <param name="connection">Connection to send to</param>
		/// <param name="game">The current game</param>
		/// <param name="answers">The grouped answers</param>
		public static void WinnerSelected(Entities.ActiveConnection connection, Entities.Game game,
										  List<IGrouping<Int32, Entities.GameRoundCard>> answers)
		{
			IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

			String winnerSelectedPartial = GetRazorViewAsString("~/Views/Game/Board/Answers/_WinnerSelected.cshtml", answers);

			String playerList = GetRazorViewAsString("~/Views/Game/Board/Sidebar/_Players.cshtml", game.Players);

			Models.Game.Board.GameBoard model = new Models.Game.Board.GameBoard();
			model.Game = game;
			model.UserId = connection.User_UserId;
			model.Hand = model.Game.Players.First(x => x.User.UserId == connection.User_UserId).Hand;

			String gameView = GetRazorViewAsString("~/Views/Game/Board/Partials/_GameContainer.cshtml", model);

			hub.Clients.Client(connection.ActiveConnectionID)
							   .WinnerSelected(winnerSelectedPartial, playerList, gameView, game.IsWaiting(), game.HasWinner());
		}

		/// <summary>
		/// Renders a razor view as a string
		/// </summary>
		/// <param name="viewPath">The view path</param>
		/// <param name="model">The model to use for rendering</param>
		/// <returns>A partial view in a string</returns>
		private static string GetRazorViewAsString(string viewPath, object model)
		{
			using (var sw = new StringWriter())
			{
				var context = new HttpContextWrapper(HttpContext.Current);
				var routeData = new RouteData();
				routeData.Values.Add("controller", "Fake");
				var controllerContext = new ControllerContext(new RequestContext(context, routeData), new FakeController());
				var razor = new RazorView(controllerContext, viewPath, null, false, null);
				razor.Render(new ViewContext(controllerContext, razor, new ViewDataDictionary(model), new TempDataDictionary(), sw), sw);
				return sw.ToString();
			}
		}
	}
}

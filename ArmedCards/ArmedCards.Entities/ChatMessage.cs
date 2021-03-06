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

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;
using System.Data;

namespace ArmedCards.Entities
{
    /// <summary>
    /// Model that describes a global chat message
    /// </summary>
    public class ChatMessage
    {
        /// <summary>
        /// Default constructor
        /// </summary>
        public ChatMessage() { }

        public ChatMessage(IDataReader idr, Int32 offsetHours)
        {
            SentBy = idr.GetValueByName<String>("SentByUserName").HTMLDecode();
            Message = idr.GetValueByName<String>("Message").HTMLDecode();
            SentDate = idr.GetValueByName<DateTime>("DateSent").AddHours(offsetHours);
            DateSent = SentDate.ToShortDateString() + " " + SentDate.ToLongTimeString();
        }

        /// <summary>
        /// The name of the user that sent the message
        /// </summary>
        [JsonProperty("SentBy")]
        public String SentBy { get; set; }

        /// <summary>
        /// The user id of the user that sent the message
        /// </summary>
        public Int32 SentByUserId { get; set; }

        /// <summary>
        /// The message that was sent
        /// </summary>
        [JsonProperty("Message")]
        public String Message { get; set; }

        /// <summary>
        /// Date the was sent
        /// </summary>
        [JsonProperty("DateSent")]
        public String DateSent { get; set; }

        /// <summary>
        /// Date the message was sent
        /// </summary>
        public DateTime SentDate { get; set; }

		/// <summary>
		/// The game ID for the game specific message
		/// </summary>
		[JsonProperty("GameID")]
		public Int32? GameID { get; set; }

		/// <summary>
		/// Is message meant for global
		/// </summary>
		[JsonProperty("Global")]
		public Boolean Global { get; set; }

        /// <summary>
        /// The type of connection
        /// </summary>
        [JsonProperty("ConnectionType")]
        public Entities.Enums.ConnectionType ConnectionType { get; set; }
    }
}

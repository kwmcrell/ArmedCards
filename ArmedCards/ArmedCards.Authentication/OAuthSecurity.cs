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

using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.Authentication
{
    /// <summary>
    /// Wrapper class for OAuthWebSecurity
    /// </summary>
    public static class OAuthSecurity
    {
        //
        // Summary:
        //     Gets a collection of registered client data.
        //
        // Returns:
        //     A collection of registered client data.
        public static ICollection<AuthenticationClientData> RegisteredClientData 
        { 
            get
            {
                return OAuthWebSecurity.RegisteredClientData;
            }
        }

        //
        // Summary:
        //     Registers a Twitter client using the specified consumer key.
        //
        // Parameters:
        //   consumerKey:
        //     The consumer key.
        //
        //   consumerSecret:
        //     The consumer secret.
        public static void RegisterTwitterClient(string consumerKey, string consumerSecret)
        {
            OAuthWebSecurity.RegisterTwitterClient(consumerKey, consumerSecret);
        }

        //
        // Summary:
        //     Registers a Facebook client with a specified identifier.
        //
        // Parameters:
        //   appId:
        //     The application ID.
        //
        //   appSecret:
        //     The application secret.
        public static void RegisterFacebookClient(string appId, string appSecret)
        {
            OAuthWebSecurity.RegisterFacebookClient(appId, appSecret);
        }

        //
        // Summary:
        //     Registers a Google client.
        public static void RegisterGoogleClient()
        {
            OAuthWebSecurity.RegisterGoogleClient();
        }

        //
        // Summary:
        //     Returns a value that indicates whether the user account has been confirmed
        //     by the provider.
        //
        // Parameters:
        //   returnUrl:
        //     Return Url.
        //
        // Returns:
        //     An DotNetOpenAuth.AspNet.AuthenticationResult instance that you can query
        //     to determine whether verification was successful.
        public static Results.AuthResult VerifyAuthentication(string returnUrl)
        {
            AuthenticationResult result = OAuthWebSecurity.VerifyAuthentication(returnUrl);

            return new Results.AuthResult(result.Error, result.ExtraData, result.IsSuccessful, result.Provider, result.ProviderUserId, result.UserName);
        }

        //
        // Summary:
        //     Logs the user in.
        //
        // Parameters:
        //   providerName:
        //     The provider name.
        //
        //   providerUserId:
        //     The user ID for the specified provider.
        //
        //   createPersistentCookie:
        //     true to create a persistent cookie so that the login information is saved
        //     across browser sessions; otherwise, false.
        //
        // Returns:
        //     true if login was successful; otherwise, false.
        public static bool Login(string providerName, string providerUserId, bool createPersistentCookie)
        {
            return OAuthWebSecurity.Login(providerName, providerUserId, createPersistentCookie);
        }

        //
        // Summary:
        //     Serializes a user ID of the provider.
        //
        // Parameters:
        //   providerName:
        //     The name of the provider.
        //
        //   providerUserId:
        //     The user ID of the provider.
        //
        // Returns:
        //     The serialized user ID of the provider.
        public static string SerializeProviderUserId(string providerName, string providerUserId)
        {
            return OAuthWebSecurity.SerializeProviderUserId(providerName, providerUserId);
        }

        //
        // Summary:
        //     Indicates whether the provider gets an OAuth client data.
        //
        // Parameters:
        //   providerName:
        //     The provider name.
        //
        //   clientData:
        //     The client data.
        //
        // Returns:
        //     true if the provider gets an OAuth client data; otherwise, false.
        public static bool TryGetOAuthClientData(string providerName, out AuthenticationClientData clientData)
        {
            return OAuthWebSecurity.TryGetOAuthClientData(providerName, out clientData);
        }

        //
        // Summary:
        //     Returns an OAuth authentication client data with the specified provider.
        //
        // Parameters:
        //   providerName:
        //     The provider name.
        //
        // Returns:
        //     An OAuth authentication client data.
        public static AuthenticationClientData GetOAuthClientData(string providerName)
        {
            return OAuthWebSecurity.GetOAuthClientData(providerName);
        }

        //
        // Summary:
        //     Indicates whether the user ID of the provider deserialized.
        //
        // Parameters:
        //   data:
        //     The data.
        //
        //   providerName:
        //     The provider name.
        //
        //   providerUserId:
        //     The provider user ID.
        //
        // Returns:
        //     true if the user ID of the provider deserialized; otherwise, false.
        public static bool TryDeserializeProviderUserId(string data, out string providerName, out string providerUserId)
        {
            return OAuthWebSecurity.TryDeserializeProviderUserId(data, out providerName, out providerUserId);
        }

        // Summary:
        //     Creates or updates the account using the specified provider and user ID for
        //     the provider ID and associate the new account with the specified user name.
        //
        // Parameters:
        //   providerName:
        //     The provider name.
        //
        //   providerUserId:
        //     The user ID for the specified provider.
        //
        //   userName:
        //     The name of the user.
        public static void CreateOrUpdateAccount(string providerName, string providerUserId, string userName)
        {
            OAuthWebSecurity.CreateOrUpdateAccount(providerName, providerUserId, userName);
        }

        /// <summary>
        /// Get the OAuthClientData Display name
        /// </summary>
        /// <param name="providerName">The provider name</param>
        /// <returns></returns>
        public static string GetOAuthClientDataDisplayName(string providerName)
        {
            return Authentication.OAuthSecurity.GetOAuthClientData(providerName).DisplayName;
        }

        /// <summary>
        /// Get the list of available logins
        /// </summary>
        /// <returns>List of available logins</returns>
        public static ICollection<String> GetLogins()
        {
            return Authentication.OAuthSecurity.RegisteredClientData.Select(x => x.DisplayName).ToList();
        }
    }
}

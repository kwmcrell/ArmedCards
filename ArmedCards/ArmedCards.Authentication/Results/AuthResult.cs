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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.Authentication.Results
{
    /// <summary>
    /// Wrapper class around the AuthenticationResult
    /// </summary>
    public class AuthResult
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="error"></param>
        /// <param name="extraData"></param>
        /// <param name="isSuccessful"></param>
        /// <param name="provider"></param>
        /// <param name="providerUserId"></param>
        /// <param name="userName"></param>
        public AuthResult(Exception error,
                            IDictionary<String, String> extraData,
                            Boolean isSuccessful,
                            String provider,
                            String providerUserId,
                            String userName
                          )
        {
            this.Error = error;
            this.ExtraData = extraData;
            this.IsSuccessful = isSuccessful;
            this.Provider = provider;
            this.ProviderUserId = providerUserId;
            this.UserName = userName;
        }

        // Summary:
        //     Gets the error that may have occured during the authentication process
        public Exception Error { get; private set; }
        //
        // Summary:
        //     Gets the optional extra data that may be returned from the provider
        public IDictionary<String, String> ExtraData { get; private set; }
        //
        // Summary:
        //     Gets a value indicating whether the authentication step is successful.
        public Boolean IsSuccessful { get; private set; }
        //
        // Summary:
        //     Gets the provider's name.
        public String Provider { get; private set; }
        //
        // Summary:
        //     Gets the user id that is returned from the provider. It is unique only within
        //     the Provider's namespace.
        public String ProviderUserId { get; private set; }
        //
        // Summary:
        //     Gets an (insecure, non-unique) alias for the user that the user should recognize
        //     as himself/herself.
        //
        // Remarks:
        //     This alias may come from the Provider or may be derived by the relying party
        //     if the Provider does not supply one.  It is not guaranteed to be unique and
        //     certainly does not merit any trust in any suggested authenticity.
        public String UserName { get; private set; }
    }
}

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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebMatrix.WebData;

namespace ArmedCards.Authentication
{
    public static class Security
    {
        // Summary:
        //     Gets the ID for the current user.
        //
        // Returns:
        //     The ID for the current user.
        public static int CurrentUserId 
        { 
            get
            {
                return WebSecurity.CurrentUserId;
            }
        }

        //
        // Summary:
        //     Gets the user name for the current user.
        //
        // Returns:
        //     The name of the current user.
        public static string CurrentUserName 
        {
            get
            {
                return WebSecurity.CurrentUserName;
            }
        }

        //
        // Summary:
        //     Logs the user out.
        //
        // Exceptions:
        //   System.InvalidOperationException:
        //     The WebMatrix.WebData.SimpleMembershipProvider.Initialize(System.String,System.Collections.Specialized.NameValueCollection)
        //     method was not called.-or-The Overload:WebMatrix.WebData.WebSecurity.InitializeDatabaseConnection
        //     method was not called.-or-The WebMatrix.WebData.SimpleMembershipProvider
        //     membership provider is not registered in the configuration of your site.
        //     For more information, contact your site's system administrator.
        public static void Logout()
        {
            WebSecurity.Logout();
        }

        //
        // Summary:
        //     Returns a value that indicates whether the specified user exists in the membership
        //     database.
        //
        // Parameters:
        //   userName:
        //     The user name.
        //
        // Returns:
        //     true if the username exists in the user profile table; otherwise, false.
        //
        // Exceptions:
        //   System.InvalidOperationException:
        //     The WebMatrix.WebData.SimpleMembershipProvider.Initialize(System.String,System.Collections.Specialized.NameValueCollection)
        //     method was not called.-or-The Overload:WebMatrix.WebData.WebSecurity.InitializeDatabaseConnection
        //     method was not called.-or-The WebMatrix.WebData.SimpleMembershipProvider
        //     membership provider is not registered in the configuration of your site.
        //     For more information, contact your site's system administrator.
        public static bool UserExists(string userName)
        {
            return WebSecurity.UserExists(userName);
        }
    }
}

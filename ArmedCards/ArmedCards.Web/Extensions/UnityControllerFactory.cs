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

using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ArmedCards.Web
{
    /// <summary>
    /// Class factory class for unity dependency injection
    /// </summary>
    public class UnityControllerFactory : DefaultControllerFactory
    {
        //
        // Summary:
        //     Retrieves the controller instance for the specified request context and controller
        //     type.
        //
        // Parameters:
        //   requestContext:
        //     The context of the HTTP request, which includes the HTTP context and route
        //     data.
        //
        //   controllerType:
        //     The type of the controller.
        //
        // Returns:
        //     The controller instance.
        //
        // Exceptions:
        //   System.Web.HttpException:
        //     controllerType is null.
        //
        //   System.ArgumentException:
        //     controllerType cannot be assigned.
        //
        //   System.InvalidOperationException:
        //     An instance of controllerType cannot be created.
        protected override IController GetControllerInstance(RequestContext reqContext, Type controllerType)
        {
            IController controller;
            if (controllerType == null)
                throw new HttpException(
                        404, String.Format(
                            "The controller for path '{0}' could not be found" +
            "or it does not implement IController.",
                        reqContext.HttpContext.Request.Path));

            if (!typeof(IController).IsAssignableFrom(controllerType))
                throw new ArgumentException(
                        string.Format(
                            "Type requested is not a controller: {0}",
                            controllerType.Name),
                            "controllerType");
            try
            {
                controller = BusinessLogic.UnityConfig.Container.Resolve(controllerType)
                                as IController;
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException(String.Format(
                                        "Error resolving controller {0}",
                                        controllerType.Name), ex);
            }
            return controller;
        }
    }
}
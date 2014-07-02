using Hangfire;
using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ArmedCards.Web.Extensions
{
    public class UnityJobActivator : JobActivator
    {
        private readonly IUnityContainer _unityContainer;

        public UnityJobActivator(IUnityContainer unityContainer)
        {
            if (unityContainer == null) throw new ArgumentNullException("unityContainer");

            _unityContainer = unityContainer;
        }

        /// <inheritdoc />
        public override object ActivateJob(Type jobType)
        {
            return _unityContainer.Resolve(jobType);
        }
    }
}
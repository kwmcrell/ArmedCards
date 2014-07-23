/// <reference path="angular.js" />

angular.module('SignalR', [])
.constant('$', $)
.factory('Hub', ['$', '$rootScope', function ($, $rootScope) {
    return function (hubName, listeners, methods, reconnecting, reconnected, disconnected) {
		var Hub = this;
		Hub.connection = $.hubConnection();
		Hub.proxy = Hub.connection.createHubProxy(hubName);
		Hub.connection.start().done(function()
		{
		    $rootScope.$broadcast('hubStartComplete');
		});
		Hub.on = function (event, fn) {
			Hub.proxy.on(event, fn);
		};
		Hub.invoke = function (method, args) {
			Hub.proxy.invoke.apply(Hub.proxy, arguments)
		};

		Hub.addNewListeners = function (newListeners) {
		    angular.forEach(newListeners, function (fn, event) {
		        Hub.on(event, fn);
		    });
		};

		Hub.addNewMethods = function (newMethods) {
		    angular.forEach(newMethods, function (method) {
		        Hub[method] = function () {
		            var args = $.makeArray(arguments);
		            args.unshift(method);
		            Hub.invoke.apply(Hub, args);
		        };
		    });
		};

		if (listeners) {
		    Hub.addNewListeners(listeners);
		}

		if (methods) {
		    Hub.addNewMethods(methods);
		}

		if (reconnecting)
		{
		    Hub.connection.reconnecting(reconnecting);
		}

		if (reconnected)
		{
		    Hub.connection.reconnected(reconnected);
		}

		if (disconnected)
		{
		    Hub.connection.disconnected(disconnected);
		}

		return Hub;
	};
}]);
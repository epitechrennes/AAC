
var angularservice = angular.module('AACServices', ['ngResource']);

angularservice.factory('User', function($resource){
  return $resource('https://server.auandgo.com\\:1340/members/:userId/', {userId:'@idmembers'}, {
    get: {method:'GET', isArray:true},
    add: {method:'POST'},
    save: {method:'PUT'},
    delete: {method:'DELETE'}
  });
});

angularservice.factory('LogUser', function($resource){
  return $resource('https://server.auandgo.com\\:1340/:logCmd/', {}, {
    login: {method:'POST', params:{logCmd: 'login'}},
    logout: {method:'GET', params:{logCmd: 'logout'}}
  });
});

angularservice.factory('socket', function ($rootScope) {
  var socket = io.connect('https://server.auandgo.com:1340/');
  return {
    on: function (eventName, callback) {
      socket.on(eventName, function () {  
        var args = arguments;
        $rootScope.$apply(function () {
          callback.apply(socket, args);
        });
      });
    },
    emit: function (eventName, data, callback) {
      socket.emit(eventName, data, function () {
        var args = arguments;
        $rootScope.$apply(function () {
          if (callback) {
            callback.apply(socket, args);
          }
        });
      })
    }
  };
});
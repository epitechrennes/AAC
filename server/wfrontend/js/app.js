var app = angular.module("myApp", ['ui.utils', 'ui.bootstrap', 'ngGrid', 'AACServices']);

app.config(function($routeProvider) {
 
  $routeProvider.
    when('/', {templateUrl: 'main_unlog.html', header: 'header.html' }).
    when('/foo', {templateUrl: 'main.html', header: 'header.html', controller: 'UserCtrl' })
     .otherwise({templateUrl: 'main_unlog.html', header: 'header.html' });
}).run(function($rootScope, $route) {
      //Se lance a chaque touche 
  $rootScope.layoutPartial = function(partialName) { if($route.current) {return $route.current[partialName]} else {return null;} };
});

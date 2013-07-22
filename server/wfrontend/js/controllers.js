'use strict';

/* Controllers */
function CollapseDemoCtrl($scope) {
    $scope.isCollapsed = false;
}

// LOGIN CONTROL
function LoginCtrl($scope, $http, User, LogUser, $location, socket) { 
    $http.defaults.useXDomain = true;    
    $http.defaults.withCredentials = true;     
    
    User.get(null, function(result) {
        $scope.loginaff = true; 
    }, function(error) {
        $scope.loginaff = false;
    });
    
  /*  socket.on('news', function (message) {
  // console.log(message);
     $scope.yourtest = message;
  });*/
    
    $scope.loginAfunc = function () {
      console.log("LOGIN");
      LogUser.login({username: $scope.loginA, password: $scope.passA}, function(result) {
        $scope.persons = "";
        $scope.loginA = "";
        $scope.passA = ""; 
        $scope.loginaff = true; 
        $location.path('/foo');
      });
    }
    
    $scope.logoutAfunc = function () {
      console.log("LGOUT");
      LogUser.logout(function(result) {
        $scope.persons = "";
        $scope.loginA = "";
        $scope.passA = "";
        $scope.loginaff = false;    
        $location.path('/');
      });
    }
}

// UserList
function UserCtrl($scope, $http, User, LogUser, $location) {
    $http.defaults.useXDomain = true;
    $http.defaults.withCredentials = true;
    
    var result = User.get(null, function(result) {   
        $scope.persons = result;   
        $scope.user = {};    
      }, function(error) {
        $location.path('/');;
    });

    var removeTemplate = '<input type="button" class="btn btn-danger" value="remove" ng-click="removeRow(row)" style="width:130px;height:28px"/>';
    var cellEditableTemplate = "<input style=\"width: 90%\" ng-model=\"COL_FIELD\" step=\"any\" type=\"text\" ng-class=\"'colt' + col.index\" ng-input=\"COL_FIELD\" ng-blur=\"updateEntity(col, row, COL_FIELD)\"/>";

    // Configure ng-grid
    $scope.gridOptions = {
        data: 'persons',
        enableCellSelection: true,
        enableRowSelection: false,
        enableCellEdit: true,
        columnDefs: [{
            field: 'firstname',
            displayName: 'firstname',
            enableCellEdit: true,
            editableCellTemplate: cellEditableTemplate
        }, {
            field: 'familyname',
            displayName: 'familyname',
            enableCellEdit: true,
            editableCellTemplate: cellEditableTemplate
        }, {
            field: 'remove',
            displayName: '',
            enableCellEdit: false,
            cellTemplate: removeTemplate
        }]
    };

    $scope.removeRow = function (row) {
        $scope.delete(row.entity);
        console.log(row.entity);
    };


    $scope.updateEntity = function (column, row, value) {
        row.entity[column.field] = value;
        // code for saving data to the server...
        // row.entity.$update() ... <- the simple case
        $scope.update(row.entity);
    }



    $scope.delete = function (user) {
        console.log("DELETE");
        //METHOD 1
        var params = {userId:user.idmembers};
        User.delete(params, function(result) {
            User.get(function(result) {  $scope.persons = result;});
    });
    }

    $scope.update = function (user) {
        console.log("UPDATE");
        //METHOD 2
        User.save({},user, function(result) {
           User.get(function(result) {  $scope.persons = result;});
    });
    }
    
     $scope.createUser = function () {
        console.log("CREATE USER");
    /*    $http.post('https://server.auandgo.com:1340/members/', $scope.user).success(function (data) {
            $http.get('https://server.auandgo.com:1340/members/').success(function (data) {
                $scope.persons = data;
            });
        });*/
           User.add($scope.user, function(result) {
             User.get(function(result) {  $scope.persons = result;});
         });
     }
}
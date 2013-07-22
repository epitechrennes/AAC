app.directive('ngBlur', function () {
    return function (scope, elem, attrs) {
        elem.bind('blur', function () {
            scope.$apply(attrs.ngBlur);
        });
    };
});

app.directive("clickToEdit", function () {
    var editorTemplate = '<div class="click-to-edit" style="display: inline">' +
        '<div  class="div1" ng-hide="view.editorEnabled"  ng-dblclick="enableEditor()"  >' +
        '{{value}} ' +
        '<a ng-click="enableEditor()">Edit</a>' +
        '</div>' +
        '<div ng-show="view.editorEnabled"  style="display: inline" >' +
        '<input ng-model="view.editableValue" ng-dblclick="save()"   ui-keydown="{27:\'disableEditor()\'}"  ui-keypress="{13:\'save(person)\'}"  >' +
        '<a href="#" ng-click="save(person)">Save</a>' +
        ' or ' +
        '<a ng-click="disableEditor()">cancel</a>.' +
        '</div>' +
        '</div>';

    return {
        restrict: "A",
        replace: true,
        template: editorTemplate,
        scope: {
            value: "=clickToEdit",
            index2: "=index2",
            index3: "=index3"
        },
        controller: function ($scope) {
            $scope.view = {
                editableValue: $scope.value,
                editorEnabled: false
            };

            $scope.enableEditor = function () {
                $scope.view.editorEnabled = true;
                $scope.view.editableValue = $scope.value;
            };

            $scope.disableEditor = function () {
                $scope.view.editorEnabled = false;
            };

            $scope.save = function (person) {
                $scope.value = $scope.view.editableValue;
                $scope.disableEditor();

                $scope.$watch($scope.index2, function () {
                    console.log($scope.index2);
                    $scope.index3($scope.index2);
                });


            };
        }
    };
});

app.directive("clickToLogin", function () {
    var editorTemplate = '<div class="click-to-edit" style="display: inline">' +
        '<div  class="div1" ng-hide="view.editorEnabled"  ng-dblclick="enableEditor()"  >' +
        '{{value}} ' +
        '<a ng-click="enableEditor()">Edit</a>' +
        '</div>' +
        '<div ng-show="view.editorEnabled"  style="display: inline" >' +
        '<input ng-model="view.editableValue" ng-dblclick="save()"   ui-keydown="{27:\'disableEditor()\'}"  ui-keypress="{13:\'save(person)\'}"  >' +
        '<a href="#" ng-click="save(person)">Save</a>' +
        ' or ' +
        '<a ng-click="disableEditor()">cancel</a>.' +
        '</div>' +
        '</div>';

    return {
        restrict: "A",
        replace: true,
        template: editorTemplate,
        scope: {
            value: "=clickToEdit",
            index2: "=index2",
            index3: "=index3"
        },
        controller: function ($scope) {
            $scope.view = {
                editableValue: $scope.value,
                editorEnabled: false
            };

            $scope.enableEditor = function () {
                $scope.view.editorEnabled = true;
                $scope.view.editableValue = $scope.value;
            };

            $scope.disableEditor = function () {
                $scope.view.editorEnabled = false;
            };

            $scope.save = function (person) {
                $scope.value = $scope.view.editableValue;
                $scope.disableEditor();

                $scope.$watch($scope.index2, function () {
                    console.log($scope.index2);
                    $scope.index3($scope.index2);
                });


            };
        }
    };
});
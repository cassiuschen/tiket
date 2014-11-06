window.App.controller 'CollectionsController', [
	'$scope',
	'$rootScope',
	'$http',
	'$cookies',
	($scope, $rootScope, $http, $cookies) ->
		$scope.getCollectionInfo = (EventName, CollectionId) ->
      $http
          method: 'GET'
          params:
            event_short_name: EventName
            collection_id: CollectionId
          isArray: false
        .success (data) ->
          $scope.CollectionData = data

    $scope.show_modal = () ->
      $("#event_editor").modal("show")
]

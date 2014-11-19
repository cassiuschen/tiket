window.angular_app.controller 'PartyController', [
  '$scope',
  '$http',
  ($scope, $http) ->
    $scope.get_list = () ->
      $http
          method: "GET"
          url: "/api/v1/party/list.json"
          isArray: true
        .success (data) ->
          $scope.list = data

    $scope.get_list()

    $scope.get_data = () ->
      $http
          method: 'GET'
          url: '/api/v1/party/data.json'
          isArray: false
        .success (data) ->
          $scope.data = data

    $scope.get_data()

    $scope.render_chart = (data) ->

      coffee:
      ctx = $("#test2").get(0).getContext("2d")
      dataoo = [
        {
          value: 33,
          color: "#F7464A"
        },
        {
          value: 150,
          color: "#E2EAE9"
        }
      ]
      new Chart(ctx).Doughnut(dataoo)
]

window.angular_app.controller 'PartyController', [
  '$scope',
  '$http',
  ($scope, $http) ->
    $http
        method: "GET"
        url: "/api/v1/party/status.json"
        isArray: false
      .success (data) ->
        $scope.status = data

    $scope.get_list = () ->
      $http
          method: "GET"
          url: "/api/v1/party/list.json"
          isArray: true
        .success (data) ->
          $scope.list = data

    $scope.get_list()

    $scope.data = {}

    $scope.change_status = () ->
      $http
          method: "GET"
          url: '/api/v1/party/change_status.json'
          isArray: false
        .success () ->
          if $scope.status == true
            $("a#status").html "现在开始"
          if $scope.status == false
            $("a#status").html "现在结束"
          $scope.status = !($scope.status)

    $scope.get_data = () ->
      $http
          method: 'GET'
          url: '/api/v1/party/data.json'
          isArray: false
        .success (data) ->
          $scope.data = data
          # 渲染图表回调在这里
          window.party_suc = data.success
          window.party_fai = data.fail

    $scope.get_data()

    $scope.change_rate = () ->
      $http
          method: "POST"
          url: '/api/v1/party/change_rate.json'
          data:
            newRate: $("input#change_rate").val()
        .success () ->
          window.party_time()

    $scope.render_chart = (success, fail) ->
      ctx = $("#s_a_f").get(0).getContext("2d")
      dataoo = [
        {
          value: success,
          color: "#F7464A"
        },
        {
          value: fail,
          color: "#E2EAE9"
        }
      ]
      new Chart(ctx).Doughnut(dataoo)
    window.party_time = () ->
      $scope.get_list()
      $scope.get_data()
    window.render_chart = () ->
      $scope.render_chart(window.party_suc, window.party_fai)
    setInterval("window.render_chart()", 10000)
    setInterval("window.party_time()", 2000)


]

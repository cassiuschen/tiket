window.angular_app.controller 'CommentsController', [
  '$scope',
  '$http',
  ($scope, $http) ->
    $scope.CurrentUser = $('#user.angular_data').data('id')
    $scope.EventId = $('#event.angular_data').data('id')

    $http
        method: 'GET'
        url: '/api/v1/comments.json'
        params:
          event: $scope.EventId
        isArray: true
      .success (data) ->
        $scope.comments = data
        window.base.TimeAgo()

    $scope.test = "Success"

    $scope.getComment = (id) ->
      $http
          method: 'GET'
          url: '/api/v1/comments.json'
          params:
            event: id
          isArray: true
        .success (data) ->
          $scope.comments = data
          window.base.TimeAgo()

    $scope.createComment = () ->
      $http
          method: 'POST'
          url: '/api/v1/comment.json'
          data:
            comment:
              user_id: $scope.CurrentUser
              event_id: $('input#eventId').val()
              content: $('input#content').val()
          isArray: false
        .success (data) ->
          if data.status == "200"
            $scope.getComment($('input#eventId').val())
            $('input#content').val("")
          #else
            #$rootScope.flash 'error', '你还没有登陆'
    window.base.TimeAgo()
]

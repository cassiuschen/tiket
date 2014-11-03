window.service = angular.module 'TiketServices', []
window.service.factory 'UserService', [
    '$http',
    '$session',
    '$scope',
    ($http, $session, $scope) ->
      @check_if_exist = (email) ->
        $http
            method: 'GET'
            url: '/api/v1/users/check.json'
            params:
              content:
                email: email
              secret: window.generate_token(new Date())
            isArray: false
          .success (data) ->
            data

      @sign_in = (params) ->
        $http
            method: 'POST'
            url: '/users/sign_in.json'
            data:
              email: params.email
              password: params.password
            isArray: false
          .success () ->
            true

      @sign_up = (params) ->
        $http
            method: 'POST'
            url: '/users.json'
            data:
              email: params.email
              password: params.password
              password_confirmation: params.password
            isArray: false
          .success (data) ->
            data

      return {
        login : (params) ->
          if @check_if_exist(params.email)
            @sign_in(params)
          else
            @sign_up(params)
      }
  ]

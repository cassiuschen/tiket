(function(){window.client=new Faye.Client("http://localhost:8080/faye>"),window.client.subscribe("/messages/new",function(data){return eval(data)})}).call(this);
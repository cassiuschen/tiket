APP_ROOT = "/var/www/Tiket"
num_worker = 4

workers 4
threads 4,16

bind "unix://#{APP_ROOT}/tmp/sockets/puma.sock"
stdout_redirect "#{APP_ROOT}/log/puma.log"
pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/puma.state"

daemonize true
activate_control_app
preload_app!


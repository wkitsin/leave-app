#!/usr/bin/env puma

pidfile 'tmp/puma.pid'
state_path 'tmp/puma.state'
stdout_redirect 'log/puma.log', 'log/puma_error.log', true
threads 4, 4
bind 'unix://tmp/puma.sock'
workers 1
prune_bundler
environment ENV['RACK_ENV'] || 'production'

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
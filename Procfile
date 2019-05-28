mailcatcher: mailcatcher -f
redis: redis-server
web: bundle exec puma -C config/puma.rb -t 2 -w 1 -p 3000
webpack: bin/webpack-dev-server
worker: bundle exec sidekiq

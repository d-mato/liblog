server '153.122.58.221', roles: %w(app db web)

set :rbenv_ruby, '2.5.0'
set :puma_threads, [0, 1]

after 'deploy:publishing', 'ridgepole:apply'

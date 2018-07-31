server 'ec2', roles: %w(app db web)

set :rbenv_ruby, '2.5.0'
set :puma_threads, [0, 1]

task :prepare_bundle_config do
  on roles(:app) do
    execute :bundle, :config, 'build.pg', '--with-pg-config=/usr/pgsql-10/bin/pg_config'
  end
end
before 'bundler:install', 'prepare_bundle_config'

after 'deploy:publishing', 'ridgepole:apply'

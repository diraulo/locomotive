# config valid only for current version of Capistrano
lock '3.7.2'

set :rbenv_type, :user
set :rbenv_ruby, '2.3.3'

set :application, 'locomotivecms'
set :repo_url, 'git@github.com:diraulo/locomotive.git'

set :deploy_to, ENV['APP_PATH']

set :linked_files, ['config/mongoid.yml', 'config/secrets.yml', '.env']

set :linked_dirs, [
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle',
  'public/system', 'public/uploads', 'public/.well-known', 'public/storage',
  'public/sites', 'public/uploaded_assets'
]

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

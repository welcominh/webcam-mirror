# config valid only for current version of Capistrano
lock '3.8.2'

set :application, 'webcam-mirror'
set :repo_url, 'git@github.com:welcominh/webcam-mirror.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/www/webcam-mirror'
set :deploy_to_root, "#{deploy_to}"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('app/config/parameters.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :cache do
	# DONT DELETE, important because clearing cache generates file with root right !
	after :clear, 'permissions:setup'
end

namespace :deploy do
	# structure:setup has to be executed after stage folder is created AND before the shared subfolder is created
	# deploy:check:directories is the best stage here to do it
	after 'deploy:check:directories', 'structure:setup'
	
	# updated, donc pas exécuté lors d'un rollback
	after :updated, 'permissions:setup'
	after :updated, 'bootstrap:bootstrap'
	after :updated, 'permissions:setup'
end
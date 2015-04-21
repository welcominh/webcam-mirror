namespace :composer do
	desc 'composer install'
	task :install do
		on roles(:all) do
			within release_path do
				execute :composer, 'install', '--no-dev'
			end
		end
	end
end
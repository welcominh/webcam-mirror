namespace :cache do
	desc 'clear cache'
	task :clear do
		on roles(:all) do
			within release_path do
				execute :php, 'app/console', 'cache:clear', '--env=prod'
				execute :php, 'app/console', 'cache:clear', '--env=dev'
				Rake::Task['cache:clear'].reenable
			end
		end
	end
end
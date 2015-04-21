namespace :permissions do
	desc "Change ownership to www-data"
	task :setup do
		on roles(:all) do
			info "Change ownership to www-data"
			within release_path do
				execute :chown, "-R www-data:www-data *"
				execute :chmod, "755  bin/bootstrap"
				Rake::Task['permissions:setup'].reenable
			end
		end
	end
end
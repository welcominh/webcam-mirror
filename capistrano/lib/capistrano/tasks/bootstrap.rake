namespace :bootstrap do
	desc "Bootstrap de la release"
	task :bootstrap do
		on roles(:all) do
			info "Bootstrap de la release"
			within release_path do
				execute "bin/bootstrap"
			end
		end
	end
end
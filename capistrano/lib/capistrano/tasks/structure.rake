namespace :structure do
	desc 'Check structure and create folders if necessary'
	task :setup do
		on roles(:all) do
			# Create parameters.yml from existing source, or else error
			if test("[ ! -f #{fetch(:deploy_to_root)}/shared/app/config/parameters.yml ]")
				ask(:parameters_yml_path, '')
				# No parameters.yml given => error
				if test("[ '#{fetch(:parameters_yml_path)}' == '' ]")
					error "Please create the file #{fetch(:deploy_to_root)}/shared/app/config/parameters.yml"
					execute "rm -rf #{fetch(:deploy_to_root)}"
					exit;
				# parameters.yml file not found at given path => error
				elsif test("[ ! -f #{fetch(:parameters_yml_path)} ]")
					error "The file parameters.yml has not been found !"
					execute "rm -rf #{fetch(:deploy_to_root)}"
					exit;
				end
				
				# OK ! create shared folder and copy parameters.yml into it from existing source
				execute "mkdir -p #{fetch(:deploy_to_root)}/shared/app/config && cp #{fetch(:parameters_yml_path)} #{fetch(:deploy_to_root)}/shared/app/config/"
			end
			# if no symlink to shared folder, create it
			if test("[ ! -L #{deploy_to}/shared ] || [ ! -d #{deploy_to}/shared ]")
				execute "rm -rf #{deploy_to}/shared && ln -s ../shared #{deploy_to}/shared"
			end
			if test("[ ! -d #{deploy_to}/logs ]")
				execute "mkdir #{deploy_to}/logs"
			end
		end
	end
end
namespace :doctrine do
	namespace :schema do
		desc 'Update database schema'
		task :update do
			on roles(:all) do
				within release_path do
					execute :php, 'app/console', 'doctrine:schema:update'
					warn "It is hardly recommander to run --dump-sql option first !!!"
					ask(:dump_sql, 'y')
					
					if test("[ '#{fetch(:dump_sql)}' != 'n' ]")
						execute :php, 'app/console', 'doctrine:schema:update', '--dump-sql'
						error "Doctrine schema update aborted !"
					else
						warn "WARNING : --force option will REALLY update database schema !!!"
						ask(:update_force, 'n')
						
						if test("[ '#{fetch(:update_force)}' == 'y' ]")
							execute :php, 'app/console', 'doctrine:schema:update', '--force'
						else
							error "Doctrine schema update aborted !"
						end
					end
				end
			end
		end
		
		desc 'Add fulltext index'
		task :addFulltextIndex do
			on roles(:all) do
				within release_path do
					info 'Adding fulltext on table mega...'
					execute :php, 'app/console', 'indexFullTextMega'
				end
			end
		end
	end
end
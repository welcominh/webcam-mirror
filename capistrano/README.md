direct-download-deployer
========================
Prerequisites
------------------------
### Generate SSH keys
Make sure you remote server can be accessed with your client via SSH keys. For more details, see [Github Generating SSH keys documentation](https://help.github.com/articles/generating-ssh-keys/)

### Install capistrano
#### Install RubyGems
``` sh
sudo apt-get install rubygems
```
#### Install Bundler
``` sh
gem install bundler
```
#### Install capistrano via gems in Gemfile
``` sh
bundle install
```

Tasks
-----------------------
Tasks are listed in the file `config/deploy.rb`

- ``permissions:setup``
    - Changes ownership of all files to www-data
    - Gives executables rights to boostrap file `bin/bootstrap` which executes :
        - composer install --dev
        - recreate database if `--recreate_bdd` enabled **(WARNING : drop and recreate, add fulltext index)**
        - install assets (with symlink option) and exports them (assetic:dump)
        - clear cache in both environments dev & prod
- `cache:clear`
    - After clearing cache (clears dev **AND** prod), calls `permissions:setup`, or else cache will not be writable
- `structure:setup`
    - input `parameters.yml` file that will be shared in every stage, and every release. This will give the following structure :

```
project_folder
│	│
│	├── development
│	│   ├── current -> releases/release_number
│	│   ├── releases
│	│   │   ├── release_number
│	│   │   └── release_number
│	│   ├── repo
│	│   ├── revisions.log
│	│   └── shared -> ../shared
│	│
│	├── production
│	│   ├── current -> releases/release_number
│	│   ├── releases
│	│   │   ├── release_number
│	│   │   └── release_number
│	│   ├── repo
│	│   ├── revisions.log
│	│   └── shared -> ../shared
│	│
│	│── shared
│	│   └── app
│	│      └── config
│	│         └── parameters.yml
```
- `deploy:bootstrap` : executes `bin/boostrap`

Deploy
-----------------------
When deploying, the following tasks are executed :
- `structure:setup`
- `permissions:setup`
- `deploy:bootstrap`
- `permissions:setup` again, cause clearing cache generates files with root rights !

### Deploy commands
`cap stage_name namespace:taskname`, for ex :
- `cap production deploy`, executes whole deploy process
- `cap production deploy:rollback`
- `cap production permissions:setup`
- `cap production cache:clear`
- etc...
	

set :application, "MediaCube Projektplattform"
set :repository,  "ssh://fhs31453@repos.mediacube.at/opt/git/projektplattform.git/"

set :deploy_to, "/var/www/virthosts/projekte.mediacube.at/"
set :user, "fhs31453"
set :use_sudo, false

set :scm, :git
set :branch, "v2"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :servername, "mediacube.at"
role :web, servername                          # Your HTTP server, Apache/etc
role :app, servername                          # This may be the same as your `Web` server
role :db,  servername, :primary => true 	   # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :copy_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

require "bundler/capistrano"
set :bundle_flags,       "--quiet"

after "deploy:update_code", "deploy:copy_config"

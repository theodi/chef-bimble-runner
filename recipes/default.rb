include_recipe "git"
include_recipe "envbuilder"
include_recipe "rvm::system"

user node['bimble-runner']['user'] do
  supports :manage_home => true
  home "/home/#{node['bimble-runner']['user']}"
end

git "/home/bimble/bimble-runner" do
  repository node['bimble-runner']['repo']
  user node['bimble-runner']['user']
  action :sync
end

link "/home/bimble/bimble-runner/.env" do
  action :create
  to "#{node['envbuilder']['base_dir']}/#{node['envbuilder']['filename']}"
end

cron "bimble" do
  action :create
  minute "0"
  hour node['bimble-runner']['schedule']['hour']
  weekday node['bimble-runner']['schedule']['day']
  user node['bimble-runner']['user']
  command "cd /home/bimble/bimble-runner; bundle exec rake bimble"
end
include_recipe "git"

user node['bimble-runner']['user'] do
  system true
end

git "/opt/bimble-runner" do
  repository node['bimble-runner']['repo']
  action :sync
end

cron "bimble" do
  action :create
  minute "0"
  hour node['bimble-runner']['schedule']['hour']
  weekday node['bimble-runner']['schedule']['day']
  user node['bimble-runner']['user']
  command "cd ~/bimble-runner; ~/.rbenv/shims/bundle exec rake bimble"
end

include_recipe 'odi-ruby'

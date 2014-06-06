include_recipe "build-essential"
include_recipe "git"
include_recipe "envbuilder"

node.set['user'] = node['bimble-runner']['user']
include_recipe 'odi-users'

include_recipe "rvm::user"

git "/home/bimble/bimble-runner" do
  repository node['bimble-runner']['repo']
  user node['bimble-runner']['user']
  action :sync
end

link "/home/bimble/bimble-runner/.env" do
  action :create
  to "#{node['envbuilder']['base_dir']}/#{node['envbuilder']['filename']}"
end

bash 'bundle the fucking thing' do
  user 'bimble'
  cwd '/home/bimble/bimble-runner'
  path [ '/home/bimble/.rvm/bin' ]
  code <<-EOF
#  cd /home/bimble/bimble-runner
  bundle
  ruby -v > /tmp/wtf
  EOF
end

cron "bimble" do
  action :create
  minute "0"
  hour node['bimble-runner']['schedule']['hour']
  weekday node['bimble-runner']['schedule']['day']
  user node['bimble-runner']['user']
  command "cd /home/bimble/bimble-runner; bundle exec rake bimble"
end

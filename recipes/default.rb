include_recipe "envbuilder"

u = node['bimble-runner']['user']

group u do
  action :create
end

user u do
  gid u
  shell "/bin/bash"
  home "/home/#{u}"
  supports :manage_home => true
  action :create
end

include_recipe "git"

git "/home/#{u}/bimble-runner" do
  repository node['bimble-runner']['repo']
  action :sync
  notifies :run, "bash[bundle]"
end

link "/home/#{u}/bimble-runner/.env" do
  owner u
  group u
  to "/home/env/env"
  action :create
end

bash "bundle" do
  user u
  group u
  cwd "/home/#{u}/bimble-runner"
  code <<-EOF
    /home/#{u}/.rbenv/shims/bundle install
  EOF
  action :nothing
end

cron "bimble" do
  action :create
  minute "0"
  hour node['bimble-runner']['schedule']['hour']
  weekday node['bimble-runner']['schedule']['day']
  user u
  command "cd ~/bimble-runner; ~/.rbenv/shims/bundle exec rake bimble"
end

include_recipe 'odi-ruby'

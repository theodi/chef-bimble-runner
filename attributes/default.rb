default['bimble-runner']['user'] = 'bimble'
default['bimble-runner']['repo'] = 'https://github.com/theodi/bimble-runner.git'
default['bimble-runner']['schedule']['hour']= "2"
default['bimble-runner']['schedule']['day']= "3"

default["envbuilder"]["base_dir"] = "/home/bimble/"
default["envbuilder"]["filename"] = "env"
default["envbuilder"]["owner"] = "bimble"
default["envbuilder"]["group"] = "bimble"

default["rvm"]["user_installs"] = [
  {
    "user" => 'bimble',
    "default_ruby" => '2.1.0',
    "rubies" => [ '2.1.0' ]
  }
]

default['rvm']['default_ruby'] = "2.1.0"

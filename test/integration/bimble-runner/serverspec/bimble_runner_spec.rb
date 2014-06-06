require 'spec_helper'

describe file('/home/bimble/bimble-runner/Rakefile') do
  it { should be_file }
  it { should be_owned_by 'bimble'}
end

describe file('/home/bimble/bimble-runner/.env') do
  it { should be_file }
  its(:content) { should match /GITHUB_OAUTH_TOKEN: ''/}
end

describe cron do
  it { should have_entry('0 2 * * 3 cd /home/bimble/bimble-runner; bundle exec rake bimble').with_user('bimble') }
end

describe command("su - bimble -c 'ruby -v'") do
  its(:stdout) { should match /2.1.0/ }
end

describe command("su - bimble -c 'cd bimble-runner && bundle show'") do
  its(:stdout) { should match /\* bimble \(/ }
end

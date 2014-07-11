require 'spec_helper'

describe file('/home/bimble/bimble-runner/Rakefile') do
  it { should be_file }
end

describe file('/home/bimble/bimble-runner/.env') do
  it { should be_file }
  its(:content) { should match /GITHUB_OAUTH_TOKEN: ''/}
end

describe cron do
  it { should have_entry('0 2 * * 3 cd ~/bimble-runner; ~/.rbenv/shims/bundle exec rake bimble').with_user('bimble') }
end

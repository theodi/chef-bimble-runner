require 'spec_helper'

describe file('/opt/bimble-runner/Rakefile') do
  it { should be_file }
end

describe file('/opt/bimble-runner/.env') do
  its(:content) { should match /GITHUB_OAUTH_TOKEN: ''/}
end

describe cron do
  it { should have_entry('0 2 * * 3 cd /opt/bimble-runner; bundle exec rake bimble').with_user('bimble') }
end

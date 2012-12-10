require 'spec_helper.rb'

describe 'User' do
  it "should exists" do
    user = User.new
    user.should be_an_instance_of(User)
  end
end
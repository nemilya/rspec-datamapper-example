require 'spec_helper.rb'

describe 'User' do
  it "should exists" do
    user = User.new
    user.should be_an_instance_of(User)
  end

  it "should add record" do
    user = User.new
    user.name = 'User Name'
    ret = user.save

    ret.should be_true
    User.count.should equal 1
  end

  it "should proper store attributes" do
    # create
    user = User.new
    user.name = 'User Name'
    user.save

    # get
    user_test = User.get(user.id)
    user_test.name.should == 'User Name'
  end

end
require 'rails_helper'

RSpec.describe User, :type => :model do
	it "creates a user" do
  	#user = build(:user)
  	user = User.create(name: "bob");
  	expect(user).to be_instance_of User
  end

  it "user has a name" do
  	#user = build(:user)
  	user = User.create(name: "bob");
  	expect(user.name).to eq("bob")
  end
end

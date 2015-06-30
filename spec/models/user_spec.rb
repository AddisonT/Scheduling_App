require 'rails_helper'

RSpec.describe User, :type => :model do
	it "creates a user" do
  	user = build(:user)
  	expect(user).to be_instance_of User
  end

  it "user has a name and off day" do
  	user = User.create(name: "bob", off_day: "2015-6-1");
  	expect(user.name).to eq("bob")
    expect(user.off_day).to eq("2015-6-1")
  end
end

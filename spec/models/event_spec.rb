require 'rails_helper'

RSpec.describe Event, :type => :model do
	it "creates an event" do
		event = Event.create(date: "2015-6-8", start_date: "2015-6-1")
		expect(event).to be_instance_of Event
	end

	it "user has a name and off day" do
		event = Event.create(date: "2015-6-8", start_date: "2015-6-1")
		expect(event.date).to eq("2015-6-8")
		expect(event.start_date).to eq("2015-6-1")
	end
end

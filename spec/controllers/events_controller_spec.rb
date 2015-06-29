require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
	it "should return true if day is a holiday or weekend" do
		date = Date.new(2015,12,4)
		date2 = Date.new(2015,1,1)
		date3 = Date.new(2015,1,3)
		expect(controller.day_is_holiday_or_weekend?(date)).to be false
		expect(controller.day_is_holiday_or_weekend?(date2)).to be true
		expect(controller.day_is_holiday_or_weekend?(date3)).to be true
	end
end

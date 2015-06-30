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

	describe "GET #index" do
		it "responds successfully with HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders users/index.html.erb" do
			get :index
			expect(response).to render_template("index")
		end

		it "gets all users" do
			events = Event.create!
			get :index
			expect(assigns(:events)).to match_array(events)
		end
	end
end

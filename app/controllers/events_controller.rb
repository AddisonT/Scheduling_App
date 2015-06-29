class EventsController < ApplicationController
	def index
		@events = Event.all
		@events = @events.sort_by(&:id)
		render :index
	end

	def create
		date = get_start_date["start_date"].split("-")
		first_day = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
		user_queue = get_schedule_list
		current_day = first_day

		while !user_queue.empty? do 
			index = 0
			user = User.find_by(name: user_queue[index])

			if !day_is_holiday_or_weekend?(current_day) && user.off_day != current_day.to_s
				user.events.create(date: current_day)
				user_queue.shift
			end

			if !day_is_holiday_or_weekend?(current_day) && user.off_day == current_day.to_s
				while user.off_day == current_day do
					index +=1
					user = User.find_by(name: user_queue[index])
				end
				user.events.create(date: current_day)
				user_queue.delete_at(index)
			end
			current_day = current_day.next
		end
		redirect "/events"
	end

	def get_schedule_list
		list = ["Sherry", "Boris", "Vicente", "Matte", "Jack", "Sherry",
			"Matte", "Kevin", "Kevin", "Vicente", "Zoe", "Kevin",
			"Matte", "Zoe", "Jay", "Boris", "Eadon", "Sherry",
			"Franky", "Sherry", "Matte", "Franky", "Franky", "Kevin",
			"Boris", "Franky", "Vicente", "Luis", "Eadon", "Boris",
			"Kevin", "Matte", "Jay", "James", "Kevin", "Sherry",
			"Sherry", "Jack", "Sherry", "Jack"]
	end

	#Holidays.on() returns an array of holidays on the given date and country
	#if there are no holidays it returns an empty array so if the array returned is
	#not empty, return true
	def day_is_holiday_or_weekend?(date)

		if !Holidays.on(date, :us_ca).empty? || date.saturday? || date.sunday?
			true
		else
			false
		end
	end

	private

	def get_start_date
		params.require(:date).permit(:start_date)
	end
end

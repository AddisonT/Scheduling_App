class EventsController < ApplicationController
	before_filter :set_beginning_of_week

	def index
		@events = Event.all
		render :index
	end

	def create
		Event.delete_all
		date = get_start_date["start_date"].split("-")
		first_day = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
		user_queue = get_schedule_list
		current_day = first_day

		while !user_queue.empty? do 
			index = 0
			user = User.find_by(name: user_queue[index])

			if !day_is_holiday_or_weekend?(current_day) && user.off_day != current_day.to_s
				user.events.create(date: current_day, start_date: get_start_date["start_date"])
				user_queue.shift
			end

			if !day_is_holiday_or_weekend?(current_day) && user.off_day == current_day.to_s
				puts "Sherry should run this statement #{user.off_day} and #{current_day.to_s}"
				while user.off_day == current_day.to_s do
					index +=1
					user = User.find_by(name: user_queue[index])
				end
				user.events.create(date: current_day, start_date: get_start_date["start_date"])
				user_queue.delete_at(index)
			end
			current_day = current_day.next
		end
		redirect_to "/events"
	end

	def swap_date
		old_date = Date.strptime(get_changed_dates["old_date"], "%Y-%m-%d")
		new_date = Date.strptime(get_changed_dates["new_date"], "%Y-%m-%d")
		old_event = Event.find_by(date: old_date)
		new_event = Event.find_by(date: new_date)

		puts "old event id is #{old_event.user_id}"
		puts "new event id is #{new_event.user_id}"

		temp_user_id = old_event.user_id

		old_event.update(user_id: new_event.user_id)
		new_event.update(user_id: temp_user_id)

		puts "old event id is #{old_event.user_id}"
		puts "new event id is #{new_event.user_id}"

		redirect_to "/events"
	end

	#Holidays.on() returns an array of holidays on the given date and country
	#if there are no holidays it returns an empty array so if the array returned is
	#not empty, return true

	private

	def get_changed_dates
		params.require(:dates).permit(:old_date, :new_date)
	end

	def set_beginning_of_week
		Date.beginning_of_week = :sunday
	end

	def get_start_date
		params.require(:date).permit(:start_date)
	end

end

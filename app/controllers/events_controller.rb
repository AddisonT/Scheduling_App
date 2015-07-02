class EventsController < ApplicationController

	def index
		@events = Event.all
		render :index
	end

	def create
		check_date = get_start_date["start_date"].split("-")

		if Date.valid_date?(check_date[0].to_i,check_date[1].to_i,check_date[2].to_i)
			Event.delete_all
			first_day = Date.new(check_date[0].to_i, check_date[1].to_i, check_date[2].to_i)
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
					while user.off_day == current_day.to_s || index >= 40 do
						index +=1
						user = User.find_by(name: user_queue[index])
					end
					user.events.create(date: current_day, start_date: get_start_date["start_date"])
					user_queue.delete_at(index)
				end
				current_day = current_day.next
			end
		end
		redirect_to "/"
	end

	def swap_date
		if !Event.all.empty?
			old_date = Date.strptime(get_changed_dates["old_date"], "%Y-%m-%d")
			new_date = Date.strptime(get_changed_dates["new_date"], "%Y-%m-%d")
			old_event = Event.find_by(date: old_date)
			new_event = Event.find_by(date: new_date)

			if old_event && new_event
				temp_user_id = old_event.user_id

				old_event.update(user_id: new_event.user_id)
				new_event.update(user_id: temp_user_id)
			end
		end
		redirect_to "/"
	end

	private

	def get_changed_dates
		params.require(:dates).permit(:old_date, :new_date)
	end

	def get_start_date
		params.require(:date).permit(:start_date)
	end

end

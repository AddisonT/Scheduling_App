class UsersController < ApplicationController
	def index
		@users = User.all.sort_by{|user| user.name}
		render :index
	end

	def create
		@user = User.create(get_name)
		render :index
	end

	def show
		@user = User.find(params[:id])
		if @user.off_day
			@user_date = Date.strptime(@user.off_day, "%Y-%m-%d").strftime('%a %d %b %Y')
		end
		@user_events = @user.events
		render :show
	end

	def update
		@user = User.find(params[:id])
		date = Date.strptime(get_date["off_day"], "%Y-%m-%d")
		@user.update(off_day: date)
		@user_date = Date.strptime(@user.off_day, "%Y-%m-%d").strftime('%a %d %b %Y')

		update_schedule

		redirect_to "/users/#{params[:id]}"
	end

	def update_schedule
		user = User.find(params[:id])
		start = user.events[0].start_date
		day_values = start.split("-")
		
		first_day = Date.new(day_values[0].to_i, day_values[1].to_i, day_values[2].to_i)
		user_queue = get_schedule_list
		current_day = first_day

		Event.delete_all
		while !user_queue.empty? do 
			index = 0
			user = User.find_by(name: user_queue[index])

			if !day_is_holiday_or_weekend?(current_day) && user.off_day != current_day.to_s
				user.events.create(date: current_day, start_date: start)
				user_queue.shift
			end

			if !day_is_holiday_or_weekend?(current_day) && user.off_day == current_day.to_s
				while user.off_day == current_day.to_s do
					index +=1
					user = User.find_by(name: user_queue[index])
				end
				user.events.create(date: current_day, start_date: start)
				user_queue.delete_at(index)
			end
			current_day = current_day.next
		end
	end

	private
		def get_name
			params.require(:form).permit(:name)
		end

		def get_date
			params.require(:user).permit(:off_day)
		end
end

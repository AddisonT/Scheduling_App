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
		@user_events = @user.events
		render :show
	end

	def update
		@user = User.find(params[:id])
		 #sherry.events.destroy(Event.find_by(date: "Sun 11 Jan 2015"))
		@user.update(get_date)
		@user_date = Date.strptime(@user.off_day, "%Y-%m-%d").strftime('%a %d %b %Y')
		render :show
	end

	private
		# def get_name
		# 	params.require(:form).permit(:name)
		# end

		def get_date
			params.require(:user).permit(:off_day)
		end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


	def get_schedule_list
		list = ["Sherry", "Boris", "Vicente", "Matte", "Jack", "Sherry",
			"Matte", "Kevin", "Kevin", "Vicente", "Zoe", "Kevin",
			"Matte", "Zoe", "Jay", "Boris", "Eadon", "Sherry",
			"Franky", "Sherry", "Matte", "Franky", "Franky", "Kevin",
			"Boris", "Franky", "Vicente", "Luis", "Eadon", "Boris",
			"Kevin", "Matte", "Jay", "James", "Kevin", "Sherry",
			"Sherry", "Jack", "Sherry", "Jack"]
	end

	def day_is_holiday_or_weekend?(date)

		if !Holidays.on(date, :us_ca).empty? || date.saturday? || date.sunday?
			true
		else
			false
		end
	end
end

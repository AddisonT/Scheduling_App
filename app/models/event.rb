class Event < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar :attribute => :date
	belongs_to :user
end

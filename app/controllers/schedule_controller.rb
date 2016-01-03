class ScheduleController < ApplicationController
  def index
  	response = HTTParty.get('https://horaro.org/agdq/2016.json')
	json = JSON.parse(response.body)
	@schedule = []


	json["schedule"]["items"].each do |n|
	  time = Time.parse(n["scheduled"]).strftime('%c')
	  @schedule.push("#{time} #{n["data"][0]} #{n["data"][3]} Duration: #{n["data"][2]}")
	end

  end
end

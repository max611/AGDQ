class ScheduleController < ApplicationController
	Game = Struct.new(:time, :game, :category, :duration)

  def index
  	response = HTTParty.get('https://horaro.org/agdq/2016.json')
	json = JSON.parse(response.body)
	@schedule = []
	


	json["schedule"]["items"].each do |n|
	  time = Time.parse(n["scheduled"]).strftime('%c')
	  g = Game.new(time,n["data"][0],n["data"][3],n["data"][2])
	  @schedule.push(g)
	end

  end


  def search

  	response = HTTParty.get('https://horaro.org/agdq/2016.json')
	json = JSON.parse(response.body)
	@schedule = []
	search = params[:search]
	search = '' if search.nil?


	json["schedule"]["items"].each do |n|
	  time = Time.parse(n["scheduled"]).strftime('%c')
	  if n["data"][0].downcase.include? search.downcase
	  	g = Game.new(time[0...-4],n["data"][0],n["data"][3],n["data"][2])
	    @schedule.push(g)
  	  end
	  
	end

  end

end

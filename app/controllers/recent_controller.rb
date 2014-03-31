class RecentController < ApplicationController
	def index
		@title = "Recent User Agent Strings"
		render :layout => 'default'
	end
end

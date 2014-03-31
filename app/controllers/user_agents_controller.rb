class UserAgentsController < ApplicationController

    def index
      @ua ||= request.headers['User-Agent']
      
      _check @ua

      # record it and get the hit count
      @db  = UserAgent.find :first, :conditions => {:user_agent => @ua} 
      if @db
        @db.increment! :hits 
      else 
        UserAgent.new( :user_agent => @ua ).save
        @db = UserAgent.find :first, :conditions => {:user_agent => @ua} 
           end
      @hits = @db.hits;

      render :layout => 'default', :template =>'user_agents/index'

    end

    def ua
      @ua = params[:ua_string]
      _check @ua

      if @ua != request.headers['User-Agent']
        @notmine = true
      end
      index

    end
  
    def _check ua
      if(ua.include? "<") # || ua.include? "<script"  || ua.index(/on.*=/)
        render :nothing, :status => 403    # forbidden
      end
    end
    

end

class UserAgent < ActiveRecord::Base

	def self.recent
		find(	:all, 
				:conditions => "user_agent IS NOT NULL",  
				:order => 'updated_at DESC', 
				:limit => 10
		)
	end

end

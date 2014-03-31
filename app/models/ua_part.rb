class UaPart < ActiveRecord::Base
	has_many :part_overrides

	def self.breakdown(ua)
		@parts = []
		ua.split(/[;\(\)]/).each do |i| 
			self.get_info(i)
		end
		self.handle_overrides
		@parts
	end

	def self.get_info(part)

		# ignore empty spaces...
		if(part.strip == "")
			return
		end

		# look it up in the database
		key = get_key(part)
		res  = find :first, :conditions => {:key => key} 
		if !(res)
			new( :key => key ).save
			res  = find :first, :conditions => {:key => key} 
      		end
		# turn it into a hashmap so I can work with it
		row = Hash.new()
		row[:part_type] = res.part_type
		row[:description] = res.description
		row[:id] = res.id

		# First, handle cases where the part should actually be two parts.
		# Nulls don't get treated as a string anymore when they hit the hash,
		# so I'm grabing the original here

		if res.split_on
			part_parts = part.split( res.split_on , 2 )
			part = part_parts[0]
			if part_parts[1]
				second_part = part_parts[1]
			end
		end
		if res.split_before
			part_parts = part.split( res.split_before, 2 )
			part = part_parts[0]
			if part_parts[1]
				second_part = res.split_before + part_parts[1]
			else 
				second_part = res.split_before
			end
		end

		# lookup the overrides. there's probably a more magical way to do this...
		row[:overrides] = PartOverrides.find :all, :conditions => {:part_id => res.id}
		
		#add in our extra data
		row[:part] = part

		# grab the part version
		if part != self.get_key(part, true)
			if res.version_after
				row[:version] = part.sub(res.version_after,'').split('/')[0]
			else
				row[:version] = part.sub(
					self.get_key(part, true), 
				'').gsub('_','.')
			end
		end
	
		# demistify windows versions
		if(res.named_version)
			row[:description] = self.get_version(key, row[:version], part)
		end
		
		# mark urls if it's an unrecognized part
		if part.downcase.include?('http://') && !row[:part_type] 
			row[:part_type] = 'URL'
		end;
		if part.downcase.include?('http://') && !row[:description] 
			part = part.strip
			url = (part[0,1] == "+") ? part[1..-1] : part
			row[:description] = '<a rel="nofollow" href="' + url + '">' + url  + '</a>';
		end;	
		
		# save things to the parts array 
		# (doing it here to preserve the order in the case of splits)
		@parts << row
		if(second_part)
			self.get_info(second_part)
		end

		row		
	end

	def self.debug(str)
		@debug ||= ""
		if str
			@debug += "\n " + str
		end
	end

	def self.print_debug
		@debug
	end		


	def self.handle_overrides 
		# loop through once making a list of items to kill
		overridden = [];
		@parts.each do |part|
			if part[:overrides]
				part[:overrides].each do |row|
					overridden << row.override_part_id
				end
			end
		end
		# loop through a second time killing the listed items
		@parts.each do |part|
			if overridden.include? part[:id]
				part[:part_type] = "Misinformation."
				part[:description] = ""
				part[:version] = ""
			end
		end
	end

	def self.get_key(part, no_mod=false)
		if /([^0-9]+)/.match(part)
			p = $1
		else 
			p = part
		end
		if !(no_mod)
			p = p + ";" if (p == part)
			p.strip!
		end
		p
	end

	def self.get_version(key, version, part)
		case key
		when  "Windows NT"
			case version
			when "6.0"
				return "Windows Vista"
			when "5.2"
				return "Windows Server 2003; Windows XP x64 Edition"
			when "5.1"
				return "Windows XP"
			when "5.01"
				return "Windows 2000, Service Pack 1 (SP1)"
			when "5.0"
				return "Windows 2000"
			when "4.0"
				return "Windows NT 4.0"
			else
				return part
			end
		else
			return part
		end
	end

end

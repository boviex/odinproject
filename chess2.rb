# encoding: utf-8

class SaveControl
	def save_prompt
		puts %Q{
	---------------
Slot 1: save_name
Date: save_date(dd/mm/yy, hh:mm)
	---------------
Slot 2: Adam vs Betty
Date: 30/08/14, 20:38
	---------------
Slot 3: name
Date: N/A
	---------------
Which slot do you want to save? (or enter "back")
				}
		input = gets.chomp.downcase
		if input.match(/back/)
			#go back
			puts "going back"
		elsif input.match(/[1-3]/)
			#save_game(input)
			puts "loading slot #{input}"
		else
			puts "Please enter the slot number, or enter 'back'"
			retry
		end
	end

	def save_game(input)
		puts "Sorry, this feature isn't available yet."
	end
end

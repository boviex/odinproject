def caesar_cipher
	puts "Please enter text to encode:"
	plaintext = gets.chomp.to_s				#get input, string it
	ciphertext = ""
	puts "Please enter amount to shift:"
	shift = gets.chomp.to_i					#get input, integer it
	
	plaintext.each_char do |character| 		#iterates through each character
		if character =~ /[a-zA-Z]/			#if the character is a letter,
			(shift%26).times do				#no point doing it more than 26 times
					if character == "z"		#loop around for z
						character="a"
				elsif character == "Z"
						character="A"
				else
					character.next!			#next character
				end
			end
		end
		ciphertext << character				#add to string
	end
	puts "Your result: '#{ciphertext}'"
	plaintext = nil							#wipes plaintext just in case
end

caesar_cipher

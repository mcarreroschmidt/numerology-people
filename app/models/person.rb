class Person < ActiveRecord::Base

	def self.get_birth_path_number(this_birthday_input)
		birthday_input = only_digits(this_birthday_input)
		birthday_array = birthday_input.split(//).map(&:to_i)
		birth_path_number = birthday_array.inject(:+).to_i
	
		while birth_path_number > 9 do
			birthday_array = birth_path_number.to_s.split(//).map(&:to_i)
			birth_path_number = birthday_array.inject(:+)
		end
		return self.birth_path_number_results(birth_path_number)
	end

	def self.birth_path_number_results(birth_path_number)
		output = "<h3><p>Your numerology number is #{birth_path_number}.</p></h3>"
		case(birth_path_number)
		when 1		
			output += "One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
		when 2		
			output += "This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
		when 3		
			output += "Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
		when 4		
			output += "This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
		when 5		
			output += "This is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
		when 6		
			output += "This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
		when 7		
			output += "This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
		when 8		
			output += "This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
		when 9		
			output += "This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
		else
			output += "Never mind. You're dead."
		end
		return output
	end

end
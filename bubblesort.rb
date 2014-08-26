def bubble_sort(array_input)
	sorted_array = array_input
	stop = false
	until stop #keep going until the whole thing is sorted
		changecounter = 0
		array_input.each_with_index do |value, index|
			if index + 1 != array_input.length
				next_value = array_input[index+1]
				if value > next_value
					sorted_array[index], sorted_array[index+1] = next_value, value #swap the values, then add one to counter
					changecounter += 1
				end
			end
		end
		stop = true if changecounter == 0 #this means the list is in order
	end
	p sorted_array
end

def bubble_sort_by(array_input)
	sorted_array = array_input
	stop = false
	until stop
		changecounter = 0
		array_input.each_with_index do |value, index|
			if index + 1 != array_input.length
			next_value = array_input[index+1]
			sorter = yield value, next_value
				if sorter <=0
					sorted_array[index], sorted_array[index+1] = next_value, value #swap the values, then add one to counter
					changecounter += 1
				end
			end
		end
		stop=true if changecounter == 0
	end
	p sorted_array
end

bubble_sort([5,1,4,2,8])

bubble_sort_by(["hi","hello","hey"]) do |left, right|
	right.length - left.length
	end
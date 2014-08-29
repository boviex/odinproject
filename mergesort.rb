#Merge Sort!

#Split an array into half
#	split the half into half
#		...
#			eventually, you get 2 or less elements in each array
#
#if 1 element return the array
#if 2 elements, compare them and put the smaller one in a new array then the larger one.


#OPERATIONS:
#split arrays
#base case: array contains only one element, return that
#elsif the returned elements are not arrays, compare them and return an array
#if the returned elements are arrays, compare the first of each and put the lower one to an array

def merge_sort(array)
	if array.length > 1
		left_array = []
			(array.length/2).times { left_array << array.shift }
		right_array = array
		left_sorted = merge_sort(left_array)
		right_sorted = merge_sort(right_array)
		result = []
		while left_sorted.length>0 && right_sorted.length>0
			if left_sorted[0] <= right_sorted[0]
				result << left_sorted.shift
			else
				result << right_sorted.shift
			end
		end
		if left_sorted.length>0
			left_sorted.each { |e| result << e }
		elsif right_sorted.length>0
			right_sorted.each { |e| result << e }
		end
		return result
	else
		return array
	end
end
p merge_sort([4,7,2,10,8,3,4,9,1,6])
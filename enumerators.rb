module Enumerable
	def my_each
		self.length.times do |counter|
		yield self[counter]
		end
	end
	
	def my_each_with_index
		self.length.times do |counter|
		yield self[counter], counter
		end
	end
	
	def my_select
		selected = []
		self.length.times do |counter|
		if yield self[counter]
			selected << self[counter]
		end
		end
		selected
	end
	
	def my_all?
		matches = 0
		self.length.times do |counter|
		if yield self[counter]
			matches += 1
		end
		end
		matches == self.length ? true : false
	end
	
	def my_any?
		self.length.times do |counter|
		if yield self[counter]
			return true
		end
		end
		false
	end
	
	def my_none?
		self.length.times do |counter|
		if yield self[counter]
			return false
		end
		end
		true
	end
	
	def my_count(obj=nil)
		counter = 0
		if obj
			self.my_each do |i|
				if i == obj
				counter += 1
				end
			end
			return counter
		else
			return self.length unless block_given?
			self.my_each do |i|
				if yield i
					counter+=1
				end
			end
			return counter
		end
	end
	
	def my_map
		new_array = []
		return self.to_enum unless block_given?
		self.my_each do |i|
				new_array.push yield i
		end
		new_array
	end
	
	def my_inject(arg=nil, sym=nil)
		accum = arg ? accum = arg : accum = 0
		if block_given?
			self.my_each do |i|
				accum = yield accum, i
				end
			return accum
		else
			sym, arg = arg, nil unless sym
			self.my_each do |i|
				unless arg
					arg = i
					accum = arg
				end
			end
		return accum
		end
	end
	
end
	def my_mult(array)
		array.my_inject(1) {|product, v| product * v }
	end

ary = [1,2,3,4,5]

ary.my_each { |v| print v }

ary.my_each_with_index { |v,i| print i }

p ary.my_all? { |v| v < 6 }

p ary.my_count

p my_mult([2,4,5])
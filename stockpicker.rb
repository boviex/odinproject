def stockpicker(stocks_array)
	answer = []
	profit = false
	stocks_array.each_with_index do |buy_price, buy_day|
			stocks_array[buy_day+1..-1].each_with_index do |sell_price, sell_day|
				difference = sell_price - buy_price
				profit ||= difference
				if difference > profit
					profit = difference
					answer[0] = buy_day
					answer[1] = sell_day + buy_day + 1
				end
			end
	end
	puts profit
	p answer
end

stockpicker([17,9,6,5,2,1,1,1,0])
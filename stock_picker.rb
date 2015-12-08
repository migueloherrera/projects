def stock_picker(prices)
	max_profit = 0
	pair_of_days = []
	
	for i in 0...prices.length
		buy = prices[i]
		
		for j in i...prices.length
			sell = prices[j]
			
			if (sell - buy) > max_profit
				max_profit = sell - buy
				pair_of_days = [i,j]
			end
			
		end
	end
	
	"Best days to buy and sell #{pair_of_days}"
end

puts stock_picker([17,3,6,9,15,8,6,1,10])

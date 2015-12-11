def bubble_sort(nums = [])

  while true
    flag = false
  
    for i in 1...nums.length

      if nums[i] < nums[i-1]
        nums[i], nums[i-1] = nums[i-1], nums[i]
        flag = true 
      end
    end
  
    break if flag == false
  end
  "#{nums}"
end

puts bubble_sort([4,3,78,2,0,2])
#=> [0,2,2,3,4,78]

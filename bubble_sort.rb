def bubble_sort(nums = [])

  while true
    unsorted = false
  
    for i in 1...nums.length

      if nums[i] < nums[i-1]
        nums[i], nums[i-1] = nums[i-1], nums[i]
        unsorted = true 
      end
    end
  
    break if unsorted == false
  end
  "#{nums}"
end

puts bubble_sort([4,3,78,2,0,2])
#=> [0,2,2,3,4,78]

def bubble_sort_by(nums = [])

  while true
    unsorted = false
      
    for i in 1...nums.length

      if (yield nums[i], nums[i-1]) == -1
        nums[i], nums[i-1] = nums[i-1], nums[i]
        unsorted = true
      end

    end
      
    break if unsorted == false
  end
  "#{nums}"
end

puts bubble_sort_by(["hi","hello","hey"]) { |left,right| left.length <=> right.length }
# => ["hi", "hey", "hello"]

def merge_sort(arr)
  return arr if arr.size == 1
  half = arr.size/2
  left = merge_sort(arr[0...half])
  right = merge_sort(arr[half..-1])

  merge(left, right)
end

def merge(left, right)
  return left if right.empty?
  return right if left.empty?

  x = left[0] <= right[0] ? left.shift : right.shift
  return [x] + merge(left, right)
end

puts "#{merge_sort([8, 15, -5, 9, 23, 45, 10, 16, 40, 3])}"

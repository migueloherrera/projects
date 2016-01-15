def fib(n)
  fib = 1
  fib_prev = 0
  i = 1
  while i < n
    fib_next = fib + fib_prev
    fib_prev = fib
    fib = fib_next
    i += 1
  end
  fib
end
          
def fibs_rec(n)
  (n == 1 || n == 2)? 1 : (fibs_rec(n-1)+fibs_rec(n-2))
end

puts "With iteration... #{fib(6)}" #=> 8
puts "With recursion... #{fibs_rec(6)}" #=> 8


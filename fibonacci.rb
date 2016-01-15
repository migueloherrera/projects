def fib(n)
  fib = 1
  fib_prev = 0
  return fib_prev if n == 0
  (n-1).times do
    fib_next = fib + fib_prev
    fib_prev = fib
    fib = fib_next
  end
  fib
end
          
def fibs_rec(n)
  (n < 2)? n : (fibs_rec(n-1)+fibs_rec(n-2))
end

puts "With iteration... #{fib(6)}"        #=> 8
puts "With recursion... #{fibs_rec(6)}"   #=> 8


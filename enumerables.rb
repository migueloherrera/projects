module Enumerable
  
  def my_each
    for i in 0...self.length
      yield(self[i]) if block_given?
    end
    self
  end
  
  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i) if block_given?
    end
    self
  end
  
  def my_select
    return self unless block_given?
    chosen = []
		self.my_each {|x| chosen << x if yield(x) }
		chosen
  end
  
  def my_all?
    if block_given?
      self.my_select {|x| yield x} == self ? true:false
    else
      self.my_select {|x| x != nil && x != false} == self ? true:false      
    end
  end
  
  def my_any?
    if block_given?
      self.my_select {|x| yield x}.size > 0 ? true:false
    else
      self.my_select {|x| x != nil && x != false}.size > 0 ? true:false
    end
  end
  
  def my_none?
    if block_given?
      !my_any? { |x| yield(x) }
    else
      !my_any? { |x| x != nil && x != false}
    end
  end
  
  def my_count(argument = nil)
    if argument
			self.my_select { |x| x == argument }.size
    elsif block_given?
      self.my_select { |x| yield(x) }.size
    else
      self.size
    end
  end
  
  def my_map(&my_proc)
    if block_given?
      result = []
      self.my_each { |x| result << my_proc.call(x) }
      result
    else
      self
    end
  end
  
  def my_inject(accum = 0)
    self.my_each { |x| accum = yield(accum, x) }
    accum
	end
end

def multiply_els(nums) 
  nums.my_inject(1) { |result, x| result * x}
end

multiply_els([2,4,5]) #=> 40

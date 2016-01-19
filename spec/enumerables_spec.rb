require_relative '../enumerables'

describe "Enumerable Module" do
  before :each do 
    @arr = [1, 2, 3, 4, 5, 6]
  end
  
  context "my_each method" do
    it "belongs to the Enumerable class" do
      expect(@arr.my_each.is_a? Enumerable).to be true
    end
    it "returns itself if no block is given" do
      expect(@arr.my_each).to eql([1,2,3,4,5,6])
    end
    it "is not modifying the original array if a block is given" do
      expect(@arr.my_each { |x| x*x}).to eql(@arr)
    end
    it "executes the block for each element" do
      a = []
      @arr.my_each {|x| a << x*x}
      expect(a).to eq([1,4,9,16,25,36])
    end
  end
  
  context "my_count method" do
    it "returns the number of elements if no block is given" do
      expect(@arr.my_count).to eq(6)
    end
    it "returns 3 for even numbers on [1, 2, 3, 4, 5, 6]" do
      expect(@arr.my_count {|n| n % 2 == 0}).to eq(3)
    end
  end

  context "my_all? method" do
    it "returns true if the block never returns false or nil" do
      expect(@arr.my_all? { |x| x > 0 }).to be true
    end
    it "returns true if no block is given and none of the collection members are false or nil" do
      expect(@arr.my_all?).to be true
    end
    it "returns false if there is at least one element that is nil or false" do
      expect([true, nil, true, 5, 7].my_all?).to be false
    end
    it "returns true for an empty array" do
      expect([].my_all?).to be true
    end
  end

  context "my_any? method" do
    it "returns true if the block returns at least one value other than false or nil" do
      expect(@arr.my_any? { |x| x == 1 }).to be true
    end
    it "returns true if no block is given and at least one element is not false or nil" do
      expect(@arr.my_any?).to be true
    end
    it "returns false if all the elements are nil or false" do
      expect([false, nil].my_any?).to be false
    end
    it "returns false for an empty array" do
      expect([].my_any?).to be false
    end
  end
  
  context "my_select method" do
    it "returns the same array if no block is given" do
      expect(@arr.my_select).to eq(@arr)
    end
    it "returns an array of elements for which the given block returns a true value" do
      expect(@arr.my_select { |n| n > 3 }).to eq([4, 5, 6])
    end
    it "returns [] for []" do
      expect([].my_select).to eql([])
    end
  end

  context "my_map method" do
    it "returns itself if no block is given" do
      expect(@arr.my_map).to eq(@arr)
    end
    it "returns a new array with the results of running block once for every element" do
      expect(@arr.my_map { |n| n >= 3 }).to eq([false, false, true, true, true, true])
    end
    it "returns [1,4,9,16,25,36] for the block condition n*n" do
      expect(@arr.my_map { |n| n*n }).to eql([1, 4, 9, 16, 25, 36])
    end
  end
end

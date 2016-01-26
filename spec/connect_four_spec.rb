require_relative "../connect_four.rb"

describe ConnectFour do
  before :each do
    @c = ConnectFour.new
  end

  describe "#column_row" do
    it "returns the current row in the column" do
      4.times {|n| @c.grid[5-n][1] = n.even? ? "A": "B"} # fills the column 1 with As and Bs
      expect(@c.column_row(1)).to eq(2)      
    end
    it "returns -1 when the column is full" do
      6.times {|n| @c.grid[5-n][1] = n.even? ? "A": "B"} 
      expect(@c.column_row(1)).to eq(-1)      
    end
  end

  describe "#add_to_column" do
    it "adds a letter to a column" do
      @c.grid[5][3] = 'B'
      expect(@c.add_to_column(3,'A')).to eq(true)
      expect(@c.grid[4][3]).to eq("A")
    end
  end
  
  describe "#won?" do
    it "returns true for B in ABBBBAB in the fourth row" do
      @c.grid[5] = ["A","B","B","A","B","A","B"]
      @c.grid[4] = ["A","B","B","B","B","A","B"]
      expect(@c.won?(4, 1, 'B')).to eq(true)
    end
    it "returns true for A in BAAAABA in column 4" do
      s = "BAAAAB"
      6.times {|n| @c.grid[n][4] = s[n]}
      expect(@c.won?(0, 4, 'A')).to eq(true)
    end
    it "returns true for B in BBBB starting in row 2 column 0" do
      4.times {|n| @c.grid[2+n][n] = 'B'}
      expect(@c.won?(2, 0, 'B')).to eq(true)
    end
    it "returns true for A in AAAA starting in row 2 column 6" do
      4.times {|n| @c.grid[2+n][6-n] = 'A'}
      expect(@c.won?(2, 6, 'A')).to eq(true)
    end
    it "returns false for A in AAA starting in row 3 column 6" do
      3.times {|n| @c.grid[3+n][6-n] = 'A'}
      expect(@c.won?(3, 6, 'A')).to eq(false)
    end
    describe "#check_rows" do
      context "finds 4 consecutive letters in a row" do
        it "AAAABBB returns true for player A" do
          @c.grid[5] = ["A","A","A","A","B","B","B"]
          expect(@c.check_rows(5, 'A')).to eq(true)
        end
        it "AABBBBA returns true for player B" do
          @c.grid[5] = ["A","A","B","B","B","B","A"]
          expect(@c.check_rows(5, 'B')).to eq(true)
        end
      end
    end
    
    describe "#check_columns" do
      context "finds 4 consecutive letters in a column" do
        it "returns true for player A" do
          4.times {|n| @c.grid[n][1] = "A"}
          expect(@c.check_columns(1, 'A')).to eq(true)
        end
      end
      context "does not find 4 consecutive letters" do
        it "returns false for player B" do
          6.times {|n| @c.grid[n][0] = n.even? ? "A": "B"}
          expect(@c.check_columns(0, 'B')).to eq(false)
        end
      end
    end
    
    describe "#check_down_right" do
      before :each do
        6.times {|n| @c.grid[n][0] = n.even? ? "A": "B"}
        6.times {|n| @c.grid[n][1] = n.even? ? "B": "A"}
        6.times {|n| @c.grid[n][3] = n.even? ? "B": "A"}
        @c.grid[5][2] = "A"
      end
      context "finds 4 consecutive letters" do
        it "returns true for row 0, column 0, player A" do
          @c.grid[2][2] = "A"
          expect(@c.check_down_right(0, 0, 'A')).to eq(true)
        end
        it "returns true for row 4, column 2, player A" do
          @c.grid[4][2] = "A"
          expect(@c.check_down_right(4, 2, 'A')).to eq(true)
        end
      end
      context "does not find 4 consecutive letters" do
        it "returns false for row 0, column 0, player B" do
          @c.grid[0][0] = "B"
          expect(@c.check_down_right(0, 0, 'B')).to eq(false)
        end
        it "returns false for row 5, column 6, player A" do
          @c.grid[5][6] = "A"
          expect(@c.check_down_right(5, 6, 'A')).to eq(false)
        end
      end
    end
    
    describe "#check_down_left" do
      before :each do
        4.times {|n| @c.grid[n][6-n] = "A"}
        @c.grid[4][2] = "B"
        @c.grid[5][1] = "B"
        @c.grid[5][0] = "A"
      end
      context "finds 4 consecutive letters" do
        it "returns true for row 0, column 6, player A" do
          expect(@c.check_down_left(0, 6, 'A')).to eq(true)
        end
      end
      context "does not find 4 consecutive letters" do
        it "returns false for row 0, column 6, player B" do
          expect(@c.check_down_left(0, 6, 'B')).to eq(false)
        end
        it "returns false for row 5, column 0, player A" do
          expect(@c.check_down_left(5, 0, 'A')).to eq(false)
        end
      end
    end
  end
  
  describe "#tie" do
    it "returns false if there's at least one space in the grid" do
      @c.grid[1][1] = " "
      expect(@c.tie).to eq(false)
    end
    it "returns true when grid is full" do
      6.times {|n| @c.grid[n] = ["A","B","A","B","A","B"]}
      expect(@c.tie).to eq(true)
    end
  end
  
  describe "#player_move" do
    it "returns false when the value entered is invalid" do
      allow(@c).to receive(:gets).and_return('9\n','15\n')
      expect(@c.player_move('A')).to eq(-1)
      expect(@c.player_move('B')).to eq(-1)
    end
    it "returns true when the user's input is between 0 and 6" do
      allow(@c).to receive(:gets).and_return('4\n')
      expect(@c.player_move('A')).to eq(4)
    end
    it "returns true when the grid has been updated successfully" do
      allow(@c).to receive(:gets).and_return('4\n')
      expect(@c.player_move('A')).to eq(4)
    end
  end
  
  describe "#play" do
    it "returns Player A won! when there are 4 consecutive As in the grid" do
      @c.grid[5] = ["B", "A", "A", "A", "A", "B", "B"]
      expect(@c.play).to eq("Player A won!")
    end
    it "returns Player B won! when there are 4 consecutive Bs in the grid" do
      @c.grid[5] = ["A", "A", "B", "B", "B", "B", "A"]
      expect(@c.play).to eq("Player B won!")
    end
    it "returns It's a tie! when nobody won" do
      allow(@c).to receive(:tie).and_return(true)         
      expect(@c.play).to eq("It's a tie!")
    end
  end
end

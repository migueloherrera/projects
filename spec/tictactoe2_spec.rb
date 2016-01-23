require_relative '../tictactoe2.rb'

describe TicTacToe do
  before :each do
    @game = TicTacToe.new
  end
  
  context "draw board" do
    
    it "returns a numbered board" do
      expect(@game.draw_board).to eq("_1_|_2_|_3_\n_4_|_5_|_6_\n 7 | 8 | 9 ")
    end
  end
  context "play" do
    it "returns 'Player 1 won!' if player 1 won" do
      allow(@game).to receive(:gets).and_return('1\n', '4\n', '2\n', '5\n', '3\n')
      expect(@game.play).to eq("Player 1 won!")
    end
    it "returns 'It\'s a tie!' if nobody won" do
      allow(@game).to receive(:gets).and_return('1\n', '4\n', '2\n', '5\n', '6\n', '3\n', '7\n', '8\n', '9\n')
      expect(@game.play).to eq("It's a tie!")
    end
  end
  context "read turn" do
    it "returns 4 and 3 from the user's input" do
      allow(@game).to receive(:gets).and_return('4\n', '3\n')
      r = @game.read_turn(1) # 1 is the parameter and it represents the turn
      expect(r).to be_an_instance_of Fixnum
      expect(r).to eq(4)
      r = @game.read_turn(2)
      expect(r).to eq(3)
    end
  end
  context "won?" do
    it "returns false when there is no winner yet" do
      expect(@game.won?).to eq(false)
    end
    it "returns true when the top row is 'X' 'X' 'X'" do
      @game.cells = {1=>"X", 2=>"X", 3=>"X", 4=>"O", 5=>"O", 6=>" ", 7=>" ", 8=>" ", 9=>" "}
      expect(@game.won?).to eq(true)
    end
  end
end

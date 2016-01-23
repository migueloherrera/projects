class TicTacToe
  attr_accessor :cells
  def initialize
    @cells = Hash.new
    9.times { |n| @cells[n+1]="#{n+1}"}
    @winning_numbers = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  end

  def start
    draw_board
    puts play
  end
  
  def draw_board
    puts "...::: TIC TAC TOE :::..."
    s = "_#{@cells[1]}_|_#{@cells[2]}_|_#{@cells[3]}_\n_#{@cells[4]}_|_#{@cells[5]}_|_#{@cells[6]}_\n #{@cells[7]} | #{@cells[8]} | #{@cells[9]} "
    puts s
    s
  end
  
  def play
    9.times { |n| @cells[n+1]=" "}
    draw_board
    9.times do |n|
      letter = n.even? ? 'X' : 'O'
      @cells[read_turn(n)] = letter
      draw_board
      return "Player #{n.even? ? '1' : '2'} won!" if won?
    end
    "It's a tie!"
  end
  
  def read_turn(n)
    loop do
      puts "Player #{n.even? ? '1' : '2'} => Choose a position to place the #{n.even? ? 'X' : 'O'}"
      move = gets.chomp.to_i
      if (1..9).include? move
        if "XO".include? @cells[move]
          puts "Cell already taken, please try again..."
        else
          return move
        end
      else
        puts "Invalid input, please enter a number 0 through 9"
      end
    end
  end
  
  def won?
    xs = @cells.select { |k,v| v == "X"}.keys
    os = @cells.select { |k,v| v == "O"}.keys
    @winning_numbers.each do |nums|
      return true if (nums - xs).empty?
      return true if (nums - os).empty?
    end
    false  
  end
end

#t = TicTacToe.new
#t.start

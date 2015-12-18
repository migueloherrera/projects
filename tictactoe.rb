class TicTacToe
  def initialize
    @cells = Hash.new
    9.times { |n| @cells[n+1]="#{n+1}"}
    draw_board
    play
  end


  private
  
  def draw_board
    puts "...::: TIC TAC TOE :::..."
    puts "_#{@cells[1]}_|_#{@cells[2]}_|_#{@cells[3]}_"
    puts "_#{@cells[4]}_|_#{@cells[5]}_|_#{@cells[6]}_"
    puts " #{@cells[7]} | #{@cells[8]} | #{@cells[9]} "
  end
  
  def play
    9.times { |n| @cells[n+1]=" "}
    draw_board
    9.times do |n|
      loop do
        letter = n.even? ? 'X' : 'O'
        puts "#{n.even? ? 'Player 1' : 'Player 2'} => Choose a position to place the #{letter}"
        move = gets.chomp.to_i
        if (1..9).include? move
          if "XO".include? @cells[move]
            puts "Cell already taken, please try again..."
          else
            @cells[move] = letter 
            draw_board
            puts "Player #{letter == 'X'? '1' : '2' } won!" if won? == "win"
            break
          end
        else
          puts "Invalid input, please enter a number 0 through 9"
        end
      end
      break if won? == "win"
    end
    puts "It's a tie!" if won? == "no winner yet"
  end
  
  def won?
    winning_numbers = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    xs = @cells.select { |k,v| v == "X"}.keys
    os = @cells.select { |k,v| v == "O"}.keys
    winning_numbers.each do |nums|
      return "win" if (nums - xs).empty?
      return "win" if (nums - os).empty?
    end
    "no winner yet"  
  end
end

t = TicTacToe.new

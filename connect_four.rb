class ConnectFour
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(6) { [" "]*7}
  end
  
  def print_grid
    puts "Connect Four"
    puts " 0 1 2 3 4 5 6"
    @grid.each {|row| puts "|#{row.join('|')}|"}
  end
  
  def play
    42.times do |t|
      print_grid
      player = t.even? ? 'A' : 'B'
      col = -2
      while col < 0
        puts "Please enter a valid number (0-6)" if col != -2
        col = player_move(player)
      end
      row = column_row(col)
      return "Player #{player} won!" if won?(row, col, player)
      return "It's a tie!" if tie
    end
  end
  
  def column_row(column)
    5.downto(0) do |row|
      if @grid[row][column] == " "
        return (row + 1)
      end
    end
    -1
  end
  
  def add_to_column(column, player)
    5.downto(0) do |row|
      unless @grid[row][column] != " "
        @grid[row][column] = player
        return true
      end
    end
    false
  end
  
  def won?(row, column, player)
    return true if check_rows(row, player)
    return true if check_columns(column, player)
    return true if check_down_right(row, column, player)
    return true if check_down_left(row, column, player)
    false
  end
  
  def tie
    space = ""
    @grid.each {|row| space += row.join}
    space.scan(/\s/).size > 0 ? false : true
  end
  
  def player_move(player)
    puts "Please enter the column where you want to place the #{player}"
    move = gets.chomp.to_i
    return -1 if !"0123456".include? move.to_s
    add_to_column(move.to_i, player) ? move.to_i : -1
  end
  
  def check_rows(row, player)
    @grid[row].join.scan(/#{player}{4}/).size == 1 ? true : false
  end
  
  def check_columns(column, player)
    str = ""
    5.downto(0) { |row| str += @grid[row][column] }
    str.scan(/#{player}{4}/).size == 1 ? true : false
  end
  def check_down_right(row, column, player)
    str = ""  
    new_row = (row - column) < 0 ? 0 : row-column
    new_column = (column - row) < 0 ? 0 : column-row
    6.times { |r| str += @grid[r+new_row][r+new_column] if (r+new_column) <= 6 && (r+new_row) <= 5}
    str.scan(/#{player}{4}/).size == 1 ? true : false
  end
  def check_down_left(row, column, player)
    str = ""
    new_column = (column + row) > 6 ? 6 : column+row
    new_row = (row + column) - new_column
    6.times { |r| str += @grid[new_row+r][new_column-r] if (new_column-r) >= 0 && (new_row+r) <= 5}
    str.scan(/#{player}{4}/).size == 1 ? true : false
  end
end

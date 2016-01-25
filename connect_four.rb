class ConnectFour
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(6) { [" "]*7}
    #[[" ", " ", " ", " ", " ", " ", " "],[" ", " ", " ", " ", " ", " ", " "],[" ", " ", " ", " ", " ", " ", " "],[" ", " ", " ", " ", " ", " ", " "],[" ", " ", " ", " ", " ", " ", " "],[" ", " ", " ", " ", " ", " ", " "]]
  end
  
  def print_grid
    puts "Connect Four"
    @grid.each {|row| puts "|#{row.join('|')}|"}
  end
  
  def column_full?(column)
    @grid[0][column] == " " ? false : true
  end
  
  def add_to_column(column, symbol)
    return false if column_full?(column)
    5.downto(0) do |row|
      unless @grid[row][column] != " "
        @grid[row][column] = symbol
        return true
      end
    end
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
    (6-row).times { |r| str += @grid[row+r][column+r] if (column+r) <= 6}
    str.scan(/#{player}{4}/).size == 1 ? true : false
  end
  def check_down_left(row, column, player)
    str = ""
    (6-row).times { |r| str += @grid[row+r][column-r] if (column-r) >= 0}
    str.scan(/#{player}{4}/).size == 1 ? true : false
  end
end

#c = ConnectFour.new
#c.print_grid
#c.add_to_column(3, 'A')
#c.add_to_column(3, 'A')
#c.add_to_column(3, 'A')
#c.add_to_column(3, 'A')
#c.print_grid





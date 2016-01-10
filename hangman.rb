class Hangman

  def initialize
    @words = []
    @used_words = []
    words = File.readlines("5desk.txt")
    words.each { |w| @words << w.strip if w.strip.length > 4 && w.strip.length < 13 }
    start
  end

  def play
    @hidden_word = @words.sample.upcase.split('')
    @used_words = []
    puts "#{@hidden_word}"
    @show_word =  ("_" * @hidden_word.length).split('')
    puts "#{@show_word}"
    8.times do |n| #check the number of chances for different size words
      t = read_turn
      save_game if t == "#"
      if @hidden_word.include? t
        @hidden_word.each_with_index { |x, i| @show_word[i] = x if @hidden_word[i] == t}
        if won?
          puts "* * * * * *  You Won!  * * * * * *"
          puts "The secret word was: #{@show_word.join}"
          break
        end  
      end
      puts "#{@show_word.join(" ")}     Turns left: #{7 - n}     Words used: #{@used_words.join(" ")}"
    end
 
    puts "You lost!  The secret word was: #{@show_word.join}" if !won? 
    play_again? ? start : exit
  end
  
  def play_again?
    print "Do you want to play again (y/n)?: "
    gets.chomp.upcase == "Y"? true : false
  end
  
  def won?
    @hidden_word == @show_word
  end
  
  def read_turn
    # reads a letter and if it is the # character, saves the game
    # also check if letter is already written
    # keep track of letters already used
    while true
      print "Guess a letter: "
      @guess = gets.chomp.upcase
      if "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".include? @guess
        if @show_word.include? @guess
          puts "Word already used, please try another one."
        else
          break
        end
      else
        puts "Invalid entry, please try again...!"
      end
    end  
    @used_words << @guess if @guess != "#"
    puts @guess
    @guess
  end

  def start
    puts "... Play Hangman ..."
    puts "  1. New Game"
    puts "  2. Load Game"
    puts "  3. Exit"
    print "Choose an option from 1 to 3: "
    option = gets.chomp.to_i
    case option
    when 1
      play
    when 2
      load_game
    when 3
      exit
    end
  end
  def save_game
    # saves current game
  end
  def load_game
    # reads all the games from a directory
    # and allows the user to load a game
  end
end

Hangman.new

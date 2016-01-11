require 'yaml'

class Hangman
  
  def initialize(words)
    @words = words
    start
  end

  private
  def play
    @hidden_word = @words.sample.upcase.split('')
    @used_words = []

    @show_word =  ("_" * @hidden_word.length).split('')
    puts "#{@show_word.join(' ')}"
    @turn = 8
    while @turn > 0  
      t = read_turn
      save_game if t == "#"

      if @hidden_word.include? t
        @hidden_word.each_with_index { |x, i| @show_word[i] = x if @hidden_word[i] == t}
        if won?
          puts "---> #{@show_word.join} <---"
          puts "\n* * * * * *  You Won!  * * * * * *"
          break
        end  
      else
        @turn -= 1
      end
      puts "#{@show_word.join(" ")}     Turns left: #{@turn}     Words used: #{@used_words.join(" ")}"
    end
 
    puts "\nYou lost!  The secret word was: #{@hidden_word.join}\n" if !won? 
    play_again? ? start : exit
  end
  
  def play_again?
    print "\nDo you want to play again (y/n)?: "
    gets.chomp.upcase == "Y"? true : false
  end
  
  def won?
    @hidden_word == @show_word
  end
  
  def read_turn
    while true
      print "\n(To save the game enter '#' )    Guess a letter: "
      @guess = gets.chomp.upcase
      if @guess.length != 1
        puts "\nType only one character and press enter..."
      elsif "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".include? @guess 
        if @show_word.include? @guess
          puts "\nWord already used, please try another one."
        else
          break
        end
      else
        puts "\nInvalid entry, please try again...!"
      end
    end  
    @used_words << @guess if @guess != "#"
    puts @guess
    @guess
  end

  def start
    puts "\n... Play Hangman ..."
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
    y = YAML::dump [@hidden_word, @used_words, @show_word, @turn]
    fn = "saved/save-#{rand(10000)}.yaml"
    File.open(fn, "w") do |f|
      f.puts y
    end
    puts "\nSaving the file with the name #{fn}....\n\n"
    start
  end
  
  def load_game
    files = Dir.entries('saved')
    if files.size == 2
      puts "\nThere are no saved games.\n"
      start
    else
      files.each do |s|
        puts "-> #{s}" if s[0..3] == "save"
      end
      print "Write the name of the file to be loaded: "
      @save_fname = "saved/#{gets.chomp}"
      begin
        content = File.read(@save_fname)
        y = YAML::load(content)
        File.delete(@save_fname)
        @hidden_word, @used_words, @show_word, @turn = y
        @turn += 1
        puts "#{@show_word.join(" ")}     Words used: #{@used_words.join(" ")}"
      rescue
        return
      end
    end
  end
end
words = []
all_words = File.readlines("5desk.txt")
all_words.each { |w| words << w.strip if w.strip.length > 4 && w.strip.length < 13 }
    
Hangman.new(words)

class MasterMind
  def initialize
    @code = []
    @continue = true
    @guess = ""
  end

  def play
    instructions
    while @continue
      createCode
      won = false
      12.times do |t|
        puts "Write your guess number #{t+1}:"
        readGuess
        r = checkGuess
        if r == "RRRR"
          puts "###################"
          puts "#    You win!!!   #"
          puts "###################"          
          won = true
          break
        else
          puts "Your guess: #{@guess}     Feedback: #{r}"
        end
      end
      puts "######  You lose... :( ######" if !won
      @continue = false if !play_again?
    end
  end
  
  private
  def instructions
    puts "...................................................."
    puts ". MasterMind!                                      ."
    puts ". Guess the secret code in 12 opportunities        ."
    puts ". Write a 4-letter combination using A to F        ."
    puts ". A few examples: ADBB, ABCD, AACF, DECF ...       ."
    puts "................... F e e d b a c k ................"
    puts ". W means the correct letter in the wrong place    ."
    puts ". R means the correct letter in the correct place  ."
    puts "...................................................."
    puts ".                     Let's play!                  ."
    puts "...................................................."
  end
  
  def createCode
    4.times { |p| @code[p] = (rand(6) + 65).chr }
  end
  
  def play_again?
    puts "Play again? (Y/N)"
    answer = gets.chomp.upcase
    return true if answer == 'Y' 
  end
  
  def readGuess
    while true
      @guess = gets.chomp.upcase
      check =  @guess.split("").reject { |c| "ABCDEF".include? c}
      if check.any? || @guess.length != 4
        puts "Invalid letters -> #{check.join} <-" if check.length > 0
        puts "Invalid entry. Write 4 letters from A to F only."
      else
        break
      end
    end
  end
  
  def checkGuess
    result = []
    @guess.split('').each_with_index do |c, i|
      if @code.include? c
        if @code[i] == c
          result << "R"
        else
          result << "W"
        end
      end
    end
    result.join.to_s
  end

end

game = MasterMind.new
game.play

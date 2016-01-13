require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end
  
  def tweet(message)
    @client.update(message) if message.length <= 140
  end
  
  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    screen_names = followers_list
    if screen_names.include? target
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "You can only send Direct Messages to people who follow you"
    end
  end
  
  def everyones_last_tweet
    friends = @client.friends.sort_by { |f| @client.user(f).screen_name.downcase}
    friends.each do |friend|
      timestamp = @client.user(friend).created_at
      puts "#{@client.user(friend).screen_name} said this on #{timestamp.strftime("%A, %b %d")}"
      puts "#{@client.user(friend).status.text}"
      puts "- - - - - - - - - -"
    end
  end
  
  def followers_list
    screen_names = []
    @client.followers.each { |follower| screen_names << @client.user(follower).screen_name}
    screen_names
  end
  
  def spam_my_followers(message)
    followers_list.each { |name| dm(name, message)}
  end
  
  def shorten(original_url)
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    short_url = bitly.shorten(original_url).short_url
    puts "Shortening this URL: #{original_url} into: #{short_url}"
    short_url
  end
  
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1..-1].join)
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run

#<MicroBlogger:0xb86515b8 @client=#<JumpstartAuth::TwitterClient:0xb85d3168 @consumer_key="mJ5otbhPGNoDCgCL7j5g", @consumer_secret="M0XkT6GeBnjxdlWHcSGYX1JutMVS9D5ISlkqRfShg", @access_token="4745056812-LCHsQxz1Db38GnAqQZG3YgfHexCSvuvArgxC3cs", @access_token_secret="rHY1bMTwdvk1fkbRDORbP4tlizIgiEL4QPVB5UBPfxqRt">>

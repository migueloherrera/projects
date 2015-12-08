def substrings(string, dict)
  results = Hash.new(0)
  dict.each do |w|
    n = string.downcase.scan(/#{w}/)
    results[w] += n.length if n.length > 0
  end
  results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)

### Expected results ###
# {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}


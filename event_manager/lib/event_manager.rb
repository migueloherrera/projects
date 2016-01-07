require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone(phone)
  phone = phone.to_s.scan(/\d/).join
  phone[0] = '' if phone[0] == "1"
  phone.rjust(10,'0')[0..9]
end

def registration_date(date)
  DateTime.strptime(date, "%m/%d/%Y %H:%M")
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"
  filename = "output/thanks_#{id}.html"
  
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager Initialized!"

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
days = {0=>"Sunday", 1=>"Monday", 2=>"Tuesday", 3=>"Wednesday", 4=>"Thursday", 5=>"Friday", 6=>"Saturday"}
peak_day = Hash.new(0)
peak_hour = Hash.new(0)

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  save_thank_you_letters(id, form_letter)
  phone = clean_phone(row[:homephone])
  date = registration_date(row[:regdate])
  puts "         Name: #{name}"
  puts "        Phone: #{phone}"
  puts "Registered on: #{days[date.wday]} at #{date.hour}:#{date.minute} hours"
  peak_day[days[date.wday]] += 1
  peak_hour[date.hour] += 1
end
d = peak_day.sort_by {|_k,v| v}.reverse.to_h
puts "\n....Registration days...."
d.each do |d, n|
  puts "#{n} registered on #{d}"
end
puts "\n....Registration hours...."
h = peak_hour.sort_by {|_k,v| v}.reverse.to_h
h.each do |d, n|
  puts "#{n} at #{d} hours"
end

puts " "
puts "EventManager finished!"

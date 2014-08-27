require 'csv'
require 'sunlight/congress'
require 'erb'
require 'date'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"
	
	filename = "output/thanks_#{id}.html"
	
	File.open(filename, "w") do |file|
		file.puts form_letter
	end
end

def clean_phone(phone)
	phone.gsub!(/\D/,'')
	if phone.length == 10
		phone
	elsif phone.length == 11 && phone[0] == "1"
		phone = phone[-10..-1]
	else
		phone = "None"
	end
end

def clean_date(datetime)
	DateTime.strptime(datetime, '%m/%d/%y %H:%M')
end

def mean(ary)
	sum = ary.inject(0) { |sum,element| sum + element }
	sum/ary.length
end

def median(ary)
	ary.sort[(ary.length / 2)]
end

def mode(ary)
	frequency = ary.inject(Hash.new(0)){|h,v| h[v] += 1; h }
	ary.max_by {|v| frequency[v]}
end

puts "Ready!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.html.erb"
erb_template = ERB.new template_letter
hours = []
weekdays = []

contents.each do |row|
	name = row[:first_name].split.map(&:capitalize)*' '
	zipcode = clean_zipcode row[:zipcode]
	id = row[0]
	phone = clean_phone row[:homephone]
	datetime = row[:regdate]
	#legislators = legislators_by_zipcode(zipcode)
	
	#form_letter = erb_template.result(binding)
	
	#save_letters(id, form_letter)
	cleandate = clean_date(datetime)
	hours << cleandate.hour
	weekdays << cleandate.wday
end
print "Hours registered: ", hours.sort, "\n"
puts "Mean: ", mean(hours)
puts "Median: ",median(hours)
puts "Mode: ", mode(hours)

print "Day of the week: ", weekdays.sort, "\n"
puts "Most popular day(s): ", mode(weekdays)
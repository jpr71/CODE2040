require 'rest_client'
require 'json'

res = RestClient.post "http://challenge.code2040.org/api/time", {
  :email => 'aaaaaaa@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1'
  }.to_json

  puts res

result = JSON.parse(res)
hash = result["result"]
date = hash["datestamp"]
interval = hash["interval"]
seconds_in_year = 31557600.0 #assuming you're counting years as being 365.25 days long

months = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

def number_to_string (num)
  if num < 10 #special case because you have to put a 0 in front of the single digits -> 09, 08, etc
    num = "0"+num.to_s
  else
    num.to_s
  end
end


def leapyear (year)
  if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
    return true
  else
    return false
  end
end

years_decimal = (interval/seconds_in_year)
years_to_add = years_decimal.to_i
puts "years: #{years_to_add}"

days_decimal = (years_decimal % 1)*365.25
days_to_add = days_decimal.to_i
puts "days: #{days_to_add}"

hours_decimal = (days_decimal % 1)*24
hours_to_add = hours_decimal.to_i
puts "hours: #{hours_to_add}"

minutes_decimal = (hours_decimal % 1)*60
minutes_to_add = minutes_decimal.to_i
puts "minutes: #{minutes_to_add}"

seconds_decimal = (minutes_decimal % 1)*60
seconds_to_add = seconds_decimal.to_i
puts "seconds: #{seconds_to_add}"



new_month = date[5..6].to_i
new_day = date[8..9].to_i
new_hour = date[11..12].to_i
new_min = date[14..15].to_i
new_seconds = date[17..18].to_i


while seconds_to_add > 0
  if new_seconds == 59
    new_seconds = 0
    minutes_to_add += 1
  else
    new_seconds += 1
  end
  seconds_to_add -= 1
end

while minutes_to_add > 0
  if new_min == 59
    new_min = 0
    hours_to_add += 1
  else
    new_min += 1
  end
  minutes_to_add -= 1
end

while hours_to_add > 0
  if new_hour == 23
    new_hour = 0
    days_to_add += 1
  else
    new_hour += 1
  end
  hours_to_add -= 1
end

new_year = date[0..3].to_i + years_to_add

while days_to_add > 0
  if new_month == 2 and new_day > 27 and leapyear new_year
    if new_day == 28
      new_day = 29
    else
      new_month += 1
      new_day = 01
    end
  elsif months[new_month] == new_day
    if new_month == 12
      new_month = 01
      years_to_add += 1
    else
      new_month += 1
    end
    new_day = 01
  else
    new_day += 1
  end
  days_to_add -= 1
end

new_year = date[0..3].to_i + years_to_add

date[0..3] = new_year.to_s
date[5..6] = number_to_string new_month
date[8..9] = number_to_string new_day
date[11..12] = number_to_string new_hour
date[14..15] = number_to_string new_min
date[17..18] = number_to_string new_seconds

p date


res1 = RestClient.post "http://challenge.code2040.org/api/validatetime", {
  :email => 'aaaaaa@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1',
  :datestamp => date
  }.to_json

puts res1

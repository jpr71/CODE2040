require 'rest_client'
require 'json'
require 'time'

res = RestClient.post "http://challenge.code2040.org/api/time", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1'
  }.to_json

result = JSON.parse(res)
hash = result["result"]
date = hash["datestamp"]
interval = hash["interval"]

time = (Time.parse(date) + interval).iso8601(3)


res1 = RestClient.post "http://challenge.code2040.org/api/validatetime", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1',
  :datestamp => time
  }.to_json

puts res1


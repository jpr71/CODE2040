require 'rest_client'
require 'json'

res = RestClient.post "http://challenge.code2040.org/api/haystack", {
  :email => 'aaaaaaa@gmail.com', #this is a fake email
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1'
  }.to_json

result = JSON.parse (res)
hash = result["result"]
haystack = hash["haystack"]
needle = hash["needle"]
index = 0

while haystack[index] != needle
  index += 1
end

res1 = RestClient.post "http://challenge.code2040.org/api/validateneedle", {
  :email => 'aaaaaaa@gmail.com', #this is a fake email
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1',
  :needle => index
  }.to_json

puts res1

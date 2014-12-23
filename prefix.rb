require 'rest_client'
require 'json'

res = RestClient.post "http://challenge.code2040.org/api/prefix", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1'
  }.to_json

result = JSON.parse (res)
hash = result["result"]
array = hash["array"]
prefix = hash["prefix"]
length = prefix.length()-1

array.delete_if { |str| str[0..length] == prefix}

res1 = RestClient.post "http://challenge.code2040.org/api/validateprefix", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1',
  :array => array
  }.to_json

puts res1

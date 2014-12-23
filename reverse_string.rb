require 'rest_client'
require 'json'

res = RestClient.post "http://challenge.code2040.org/api/getstring", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1'
  }.to_json

hash = JSON.parse(res)

res1 = RestClient.post "http://challenge.code2040.org/api/validatestring", {
  :email => 'joshuapr1@gmail.com',
  :github => 'https://github.com/jpr71',
  :token => 'dNs4ea9kg1',
  :string => hash["result"].reverse!
  }.to_json

  puts res1


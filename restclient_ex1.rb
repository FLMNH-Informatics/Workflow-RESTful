# TwitterTrends1.rb
require 'rubygems'
require 'rest_client'

response = RestClient.post 'http://10.243.11.78:3000/muscles', :fileParam => File.new("example.fasta", 'rb'), :output_format => '-clw'


puts response.body

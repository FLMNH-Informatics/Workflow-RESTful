# restclient_muscle2s.rb
require 'rubygems'
require 'rest_client'

response = RestClient.post 'http://10.243.11.78:3000/muscle2s', :fileParam => File.new("example.fasta", 'rb'), :output_format => '-fasta', :maxiters => '2'


puts response.body
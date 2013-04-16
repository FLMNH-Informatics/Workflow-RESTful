# restclient_fasta2phylip.rb
require 'rubygems'
require 'rest_client'
require 'json'

#step 1:: parse the parameters

filename = ''
maxiters = ''
outputformat = ''
wtaskid = ''


ARGV.each do |a|
  #puts a
  #puts 'ARGV.index(a):: ' + ARGV.index(a).to_s
  if a == "-in"
    filename = ARGV[ARGV.index(a)+1]
  end


  if a == "-wtaskid"
    wtaskid = ARGV[ARGV.index(a)+1]
  end

end

puts 'filename :: ' + filename
puts 'maxiters :: ' + maxiters
puts 'outputformat :: ' + outputformat


response = RestClient.post 'http://10.243.11.78:3000/fasta2phylips', :fileParam => File.new(filename, 'rb'), :wtaskid => wtaskid
puts 'REST Response :: ' + response.body














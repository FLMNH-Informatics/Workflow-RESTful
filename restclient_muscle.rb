# restclient_muscle.rb
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
  if a == "-maxiters"
    puts a
    maxiters = ARGV[ARGV.index(a)+1]
  end
  if a == "-outputformat"
    puts a
    outputformat = ARGV[ARGV.index(a)+1]
  end
  if a == "-wtaskid"
    wtaskid = ARGV[ARGV.index(a)+1]
  end

end

puts 'filename :: ' + filename
puts 'maxiters :: ' + maxiters
puts 'outputformat :: ' + outputformat


response = RestClient.post 'http://10.243.11.78:3000/muscles', :fileParam => File.new(filename, 'rb'), :output_format => outputformat, :maxiters => maxiters, :wtaskid => wtaskid
puts 'REST Response :: ' + response.body

#return 'REST Response :: ' + response.body

#step 2:: save the result folder
#copy the folder back to workflow folder?
#Or just record/save the job_id?

#if job_ib exists -> means this task is successfully running
#Update this task's status from 'initial' to 'done'
#@wtask = Wtask.find(wtaskid)
#@wtask.update_attribute('wtask_status', 'done')


#save the job_id to table::wtasks
#copy the completed alignment file back to workflow folder
#@wtask.update_attribute('wtask_folder', '1234')












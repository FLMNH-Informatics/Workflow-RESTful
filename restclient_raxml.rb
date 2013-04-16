# restclient_raxml.rb
require 'rubygems'
require 'rest_client'
require 'json'

#step 1:: parse the parameters

filename = ''
modelofevolution = ''
numberofruns = ''
wtaskid = ''


ARGV.each do |a|
  #puts a
  #puts 'ARGV.index(a):: ' + ARGV.index(a).to_s
  if a == "-s"
    filename = ARGV[ARGV.index(a)+1]
  end
  if a == "-m"
    puts a
    modelofevolution = ARGV[ARGV.index(a)+1]
  end
  if a == "-#"
    puts a
    numberofruns = ARGV[ARGV.index(a)+1]
  end
  if a == "-wtaskid"
    wtaskid = ARGV[ARGV.index(a)+1]
  end

end

puts 'filename :: ' + filename
puts 'modelofevolution :: ' + modelofevolution
puts 'numberofruns :: ' + numberofruns


response = RestClient.post 'http://10.243.11.78:3000/raxmls', :fileParam => File.new(filename, 'rb'), :modelofevolution => modelofevolution, :numberofruns => numberofruns, :wtaskid => wtaskid
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












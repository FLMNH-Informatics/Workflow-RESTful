# app/controllers/muscles_controller.rb

class MusclesController < ApplicationController
  # GET /muscles
  # GET /muscles.json
  def index
    a = [ 1, "cat", 3.14 ]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: a }
    end
  end


  # GET /muscles/1
  # GET /muscles/1.json
  def show
    job_id = params[:id]

    is_aligned = false

    #if (File.exist?("public/services/rest/muscle/result/"+job_id + '.output') and File.file?("public/services/rest/muscle/result/"+job_id + '.output'))
    if (File.exist?("public/services/rest/muscle/result/"+job_id+"/"+job_id+'.alignment') and File.file?("public/services/rest/muscle/result/"+job_id+"/"+job_id+ '.alignment'))
      is_aligned = true
    end

    status = ''
    if is_aligned
      status = 'Done'
    else
      status = 'Under Running or Error'
    end

    #puts status
    #show_doc_type = params[:show_doc_type]




    pwd =  `pwd`



    #server_uri = request.env["REQUEST_URI"]
    #server_uri_array = server_uri.split('/')

    #server_path = ''
    #server_uri_array[0..-6].each do |w|
    #  server_path += w + '/'
    #end


    server_name = request.env["SERVER_NAME"]
    server_port = request.env["SERVER_PORT"]
    server_path = server_name + ':' + server_port

    source = "http://"+server_path + "/services/rest/muscle/result/"+job_id.to_s+"/"+job_id.to_s+".source"
    statistics = "http://"+server_path + "/services/rest/muscle/result/"+job_id.to_s+"/"+job_id.to_s+".statistics"
    alignment = "http://"+server_path + "/services/rest/muscle/result/"+job_id.to_s+"/"+job_id.to_s+".alignment"




    #results= { "Status" => status, "Source" => source, "Stat" => stat, "Output" => output, "PWD" => pwd, "Job_id" => job_id}
    results= { "Status" => status, "Source" => source, "Statistics" => statistics, "Alignment" => alignment}
    #puts results



    #redirect_to a
    respond_to do |format|
      #format.html { render :json job_id } # equal to format.html { render json: job_id }
      format.html { render json: results.to_json }
      format.json { render json: results.to_json }
      #  format.html # index.html.erb
      #  format.json { render json: a }
    end
  end


  # POST /muscles
  # POST /muscles.json
  def create

    results = ''

    uploaded_io = params[:fileParam]
    output_format = params[:output_format]
    maxiters = params[:maxiters]


    if uploaded_io
      #puts 'Yes'

      #puts uploaded_io.content_type
      #puts uploaded_io.headers

      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file| #read the uploaded file as
        file.write(uploaded_io.read)
      end



      pwd =  `pwd`
      puts '111::' + pwd


      dirname = `./job_builder.sh`
      filename = ''
      filename = uploaded_io.original_filename
      mv_command = "mv public/uploads/" + uploaded_io.original_filename + " " + dirname.to_s

=begin
      fasta_array = Array.new

      file = Bio::FastaFormat.open("public/uploads/" + uploaded_io.original_filename)
      file.each do |entry|
        #puts "entry_ID"
        #puts entry.entry_id
        fasta_array.push('>'+entry.definition)
        #puts "Sequence"
        #puts entry.naseq             #aaseq for protein sequence
        #puts "Illegal bases"
        #fasta_array.push(entry.naseq.upcase.gsub('-', '') )
        fasta_array.push(entry.naseq.upcase)
      end

      File.open(filename, 'w') do |f|
        fasta_array.each do |fasta_line|
          f.puts fasta_line
          #f.puts '\n'
        end
      end
=end

      system mv_command
      #system "mv " + filename + " " + dirname

      #system "mv sequence.txt "+ dirname

      #seq_dest = dirname.chomp+"/" + filename#no use anymore
      #output_dest = dirname.chomp+"/"+dirname.chomp+".output" #no use anymore

      if output_format == ''
        output_format = '-fasta'
      end

      if maxiters == ''
        maxiters = '2'
      end

      system "mv "+dirname.chomp+"/ public/services/rest/muscle/result/"

      #align_dest = dirname.chomp+"/"+dirname.chomp+"." + output_format[1..-1]#no use anymore
      #puts 'sequence destination is ::' + seq_dest

      pwd =  `pwd`
      puts pwd

      Dir.chdir "public/services/rest/muscle/result/" + dirname.chomp
      system "cp " + filename + " " + dirname.chomp + ".source"



      task_execution_command = "./../../../../../../muscle3.8.31_i86linux32 -in "+filename+" -verbose -log "+dirname.chomp+".statistics"+" " + output_format + " -out "+dirname.chomp+".alignment" + " -group -maxiters " + maxiters + "&"
      system task_execution_command

      #


      #system "./muscle3.8.31_i86linux32 -in "+seq_dest+" -verbose -log "+output_dest+" -quiet " + output_format + " -out "+align_dest+" -group -maxiters " + maxiters + "&"
      #system "./muscle3.8.31_i86linux64 -in "+seq_dest+" -verbose -log "+output_dest+" -quiet " + output_format + " -out "+align_dest+" -group"

      #system "cd .."
      #system "cd .."
      #system "cd .."
      #system "cd .."
      #system "cd .."
      #system "cd .."

      Dir.chdir ".."
      Dir.chdir ".."
      Dir.chdir ".."
      Dir.chdir ".."
      Dir.chdir ".."
      Dir.chdir ".."

      pwd2 = `pwd`
      puts pwd2



      server_name = request.env["SERVER_NAME"]
      server_port = request.env["SERVER_PORT"]
      puts server_name + ':' + server_port

      job_id = dirname.chomp
      #results = title + ' ::222:: ' + eml_address
      #results= { "job_id" => dirname.chomp }
      #results= { "job_id" => job_id }

      #results = 'Successfully submitted!<br><br>Please go to the following links to check your submitted results:<br>'
      #results += '<a href="/services/rest/muscle/result/'+ job_id + '/'+ job_id + '.alignment">Aligned File</a><br>'
      #results += '<a href="/services/rest/muscle/result/'+ job_id + '/'+ job_id + '.output">Output</a><br>'

      #results= { "task_execution_command" => task_execution_command, "pwd2" => pwd2, "job_id" => job_id, "alignment" => "/services/rest/muscle/result/"+ job_id + "/"+ job_id + "." + output_format[1..-1], "stat" => "/services/rest/muscle/result/"+ job_id + "/"+ job_id + ".output" }
      results = {"TaskLocation" => request.env["REQUEST_URI"] + '/' + job_id}

      #write down the output to a file for futher reference
      #

      #return 'REST Response :: ' + response.body

=begin

      #step 2:: save the result folder
      #copy the folder back to workflow folder?
      #Or just record/save the job_id?

      #if job_ib exists -> means this task is successfully running
      #Update this task's status from 'initial' to 'done'
      @wtask = Wtask.find(wtaskid)
      @wtask.update_attribute('wtask_status', 'done')

      #copy the completed alignment file back to workflow folder
      @wflow = Wflow.find(@wtask[:wflow_id])



      cp_alignment = "cp public/services/rest/muscle/result/"+ job_id + "/"+ job_id + "." + output_format[1..-1] + " public/services/workflows/" + @wflow[:wfolder]
      puts cp_alignment
      system cp_alignment

      system "cp -r public/services/rest/muscle/result/"+ job_id + "/ public/services/workflows/" + @wflow[:wfolder]

=end

      #save the job_id to table::wtasks

      #@wtask.update_attribute('wtask_folder', job_id)




=begin

      #:wtask_id, :ptype, :ploc
      #http://apidock.com/rails/v3.1.0/ActiveRecord/Base/assign_attributes
      @wtask_ports = Workflow::WtaskPort.where( :wtask_id => wtaskid)
      @wtask_ports.each do |a|
        puts 'ID is :: ' + a.id.to_s
        @wtask_port = Workflow::WtaskPort.find(a.id)
        puts 'pname is :: ' + @wtask_port["pname"]

        if @wtask_port["pname"] == "source"
          @wtask_port.update_attribute('ploc', "/services/rest/muscle/result/" + seq_dest)
        end
        if @wtask_port["pname"] == "alignment"
          @wtask_port.update_attribute('ploc', "/services/rest/muscle/result/" + align_dest)
        end
        if @wtask_port["pname"] == "statistics"
          @wtask_port.update_attribute('ploc', "/services/rest/muscle/result/" + output_dest)
        end

      end
=end






    else
      #puts 'No'
      #results = 'Fail! No input.'
      results= { "job_id" => 0 }
    end


    respond_to do |format|
      #format.html { render 'Was successfully created.' }#is that correct?
      #format.html { render 'Successfully submitted! Please go to the following links to check your submitted results:<br><a href="/services/rest/muscle/result/'+ job_id + '">Aligned File</a><br><a href="">Output</a>' }

      format.html { render json: results }
      #format.html { render json: results.to_json }
      #format.json { render json: results.to_json }

      #if b
      #format.html { render b }
      ##format.html { render 'Person was successfully created.' }
      #format.json { render json: b }
      #else
      #format.html { render b }
      ##format.html { render 'Not created.' }
      #format.json { render json: b }
      #end
    end


  end

end
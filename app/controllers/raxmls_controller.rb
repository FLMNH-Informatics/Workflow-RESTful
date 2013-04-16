# app/controllersraxmls_controller.rb

class RaxmlsController < ApplicationController
  # GET /raxmls
  # GET /raxmls.json
  def index
    a = [ 1, "cat", 3.14 ]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: a }
    end
  end


  # GET /raxmls/1
  # GET /raxmls/1.json
  def show
    job_id = params[:id]



    #show_doc_type = params[:show_doc_type]




    pwd =  `pwd`



    #server_uri = request.env["REQUEST_URI"]
    #server_uri_array = server_uri.split('/')

    #server_path = ''
    #server_uri_array[0..-6].each do |w|
    #  server_path += w + '/'
    #end

    Dir.chdir "public/services/rest/raxml/result/" + job_id
    system "cp RAxML_info." + job_id +".source.out " + job_id + ".statistics"
    system "tar -zcvf " + job_id + ".tar.gz *.*"

    is_completed = false

    if (File.exist?(job_id+'.statistics') and File.file?(job_id+'.statistics'))
      file = job_id + '.statistics'
      f = File.open(file, "r")
      f.each_line { |line|
        #puts line
        if line =~ /Overall execution time:/ or line =~ /Overall Time/
          is_completed = true
        elsif line =~ /ERROR:/ and line =~ /exiting.../
          #exiting...
          #ERROR:
          is_completed = false
        end


      }
      f.close
    end
    #if (File.exist?("public/services/rest/muscle/result/"+job_id + '.output') and File.file?("public/services/rest/muscle/result/"+job_id + '.output'))
    #if (File.exist?("public/services/rest/muscle/result/"+job_id+"/"+job_id+'.alignment') and File.file?("public/services/rest/muscle/result/"+job_id+"/"+job_id+ '.alignment'))
    #  is_aligned = true
    #end

    status = ''
    if is_completed
      status = 'Done'
    else
      status = 'Under Running or Error'
    end




    Dir.chdir ".."
    Dir.chdir ".."
    Dir.chdir ".."
    Dir.chdir ".."
    Dir.chdir ".."
    Dir.chdir ".."
    pwd2 =  `pwd`

    server_name = request.env["SERVER_NAME"]
    server_port = request.env["SERVER_PORT"]
    server_path = server_name + ':' + server_port






    source = "http://"+server_path + "/services/rest/raxml/result/"+job_id.to_s+"/"+job_id.to_s+".source"
    statistics = "http://"+server_path + "/services/rest/raxml/result/"+job_id.to_s+"/"+job_id.to_s+".statistics"
    results = "http://"+server_path + "/services/rest/raxml/result/"+job_id.to_s+"/"+job_id.to_s+".tar.gz"




    #results= { "Status" => status, "Source" => source, "Stat" => stat, "Output" => output, "PWD" => pwd, "Job_id" => job_id}
    #results= { "Status" => status, "Source" => source, "Statistics" => statistics, "Results" => results, "PWD" => pwd, "PWD2" => pwd2 }
    results= { "Status" => status, "Source" => source, "Statistics" => statistics, "Results" => results }

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



  # POST /raxmls
  # POST /raxmls.json
  def create



    uploaded_io = params[:fileParam]
    modelofevolution = params[:modelofevolution]
    numberofruns = params[:numberofruns]

    wtaskid = params[:wtaskid]





    dirname = `./job_builder.sh`
    filename = ''

    results = ''


    if uploaded_io
      #puts 'Yes'
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
        file.write(uploaded_io.read)
      end
      filename = uploaded_io.original_filename
      mv_command = "mv public/uploads/" + uploaded_io.original_filename + " " + dirname

      system mv_command
      #system "mv sequence.txt "+ dirname


      pwd =  `pwd`
      puts pwd

      system "mv "+dirname.chomp+"/ public/services/rest/raxml/result/"
      Dir.chdir "public/services/rest/raxml/result/" + dirname.chomp
      system "cp " + filename + " " + dirname.chomp + ".source"






      #puts seq_dest

      # no need anymore
      #seq_dest = dirname.chomp+"/" + filename
      #output_dest = dirname.chomp+"/"+filename+".out"
      #cp_seq_file = "cp " + seq_dest + " " + filename
      #puts cp_seq_file
      #system cp_seq_file
      # no need anymore
      system "cp " + filename + " " + dirname.chomp + ".source"
      source_file = dirname.chomp + ".source"

      task_execution_command  = "./../../../../../../raxmlHPC -s " + source_file + " -n " + source_file + ".out -m " + modelofevolution +" -# " + numberofruns +  " &"

      system task_execution_command
      puts task_execution_command




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
      #results += '<a href="/services/rest/raxml/result/'+ job_id + '/RAxML_info.' + filename + '.out">Output</a><br>'
      #results += '<a href="/services/rest/raxml/result/'+ job_id + '/results.tar.gz">Tar Result</a><br>'

      #results= { "job_id" => job_id, "results" => "/services/rest/raxml/result/" + job_id + "/results.tar.gz", "stat" => "/services/rest/raxml/result/" + job_id + "/RAxML_info." + filename + ".out" }


      #return 'REST Response :: ' + response.body

      #results = {"TaskLocation" => request.env["REQUEST_URI"] + '/' + job_id, "task_execution_command" => task_execution_command }
      results = {"TaskLocation" => request.env["REQUEST_URI"] + '/' + job_id }





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
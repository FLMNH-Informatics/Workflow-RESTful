# app/controllers/fasta2phylips_controller.rb

class Fasta2phylipsController < ApplicationController

  require 'bio'

  # GET /fasta2phylips
  # GET /fasta2phylips.json
  def index
    #a = [ 1, "cat", 3.14 ]
    respond_to do |format|
      format.html # index.html.erb
                  #format.json { render json: a }
    end
  end


  # GET /fasta2phylips/1
  # GET /fasta2phylips/1.json
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

    Dir.chdir "public/services/rest/fasta2phylip/result/" + job_id

    system "tar -zcvf " + job_id + ".tar.gz *.*"

    is_completed = false

    if (File.exist?(job_id+'.phylip') and File.file?(job_id+'.phylip'))

      is_completed = true

    end


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






    source = "http://"+server_path + "/services/rest/fasta2phylip/result/"+job_id.to_s+"/"+job_id.to_s+".source"
    phylip_output = "http://"+server_path + "/services/rest/fasta2phylip/result/"+job_id.to_s+"/"+job_id.to_s+".phylip"





    #results= { "Status" => status, "Source" => source, "Stat" => stat, "Output" => output, "PWD" => pwd, "Job_id" => job_id}
    #results= { "Status" => status, "Source" => source, "Statistics" => statistics, "Results" => results, "PWD" => pwd, "PWD2" => pwd2 }
    results= { "Status" => status, "Source" => source, "Phylip_output" => phylip_output }

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


  # POST /fasta2phylips
  # POST /fasta2phylips.json
  def create

    results = ''

    uploaded_io = params[:fileParam]



    if uploaded_io
      #puts 'Yes'

      #puts uploaded_io.content_type
      #puts uploaded_io.headers

      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file| #read the uploaded file as
        file.write(uploaded_io.read)
      end

      dirname = `./job_builder.sh`
      filename = ''
      filename = uploaded_io.original_filename
      mv_command = "mv public/uploads/" + uploaded_io.original_filename + " " + dirname

      system mv_command
      #system "mv sequence.txt "+ dirname





      seq_dest = dirname.chomp+"/" + filename
      output_dest = dirname.chomp+"/"+dirname.chomp+".phylip"
      system "cp " + dirname.chomp + "/" + filename + " " + dirname.chomp + "/" + dirname.chomp + ".source"



      seq_ary = Array.new
      ff = Bio::FlatFile.auto(seq_dest)
      ff.each_entry do |entry|
        seq_ary.push(entry)
        #puts entry.entry_id          # prints the identifier of the entry
        #puts entry.definition        # prints the definition of the entry
        #puts entry.seq               # prints the sequence data of the entry
      end

      # Creates a multiple sequence alignment (possibly unaligned) named
      # 'seqs' from array 'seq_ary'.
      seqs = Bio::Alignment.new(seq_ary)
      #seqs.each { |seq| puts seq.to_s }

      # Writes multiple sequence alignment (possibly unaligned) 'seqs'
      # to a file in PHYLIP format.
      File.open(output_dest, 'w') do |f|
        f.write(seqs.output(:phylip))
      end

      mv_command = "mv "+dirname.chomp+"/ public/services/rest/fasta2phylip/result/"
      puts mv_command
      system mv_command

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

      #results= { "job_id" => job_id, "phylip_file" => "/services/rest/fasta2phylip/result/"+ job_id + "/"+ job_id + ".phylip" }
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
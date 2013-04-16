
require 'bio'

seq_ary = Array.new
ff = Bio::FlatFile.auto('example.fasta')
ff.each_entry do |entry|
  seq_ary.push(entry)
  puts entry.entry_id          # prints the identifier of the entry
  puts entry.definition        # prints the definition of the entry
  puts entry.seq               # prints the sequence data of the entry
end

# Creates a multiple sequence alignment (possibly unaligned) named
# 'seqs' from array 'seq_ary'.
seqs = Bio::Alignment.new(seq_ary)
seqs.each { |seq| puts seq.to_s }


puts seqs.output(:phylip)

# Writes multiple sequence alignment (possibly unaligned) 'seqs'
# to a file in PHYLIP format.
File.open('out.phylip', 'w') do |f|
  f.write(seqs.output(:phylip))
end
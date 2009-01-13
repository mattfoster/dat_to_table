#! /usr/bin/ruby 
# Convert data file to LaTeX table
# 
# License: BSD
# 
# Matt Foster <ee1mpf@bath.ac.uk>

require 'rubygems'

begin
  require 'extensions/all'  
  exts = true
rescue LoadError => e
  $stderr.puts 'No extensions available.'
  exts = false
end

def line_to_row(line)
  # Comment lines are labels
  line.sub!('#', '')
  # Join cells with &, terminate with \\
  line.split("\t").join(' & ') << "\\\\\n"
end

def truncate_floats(line, exts, format_float = '%2.4f', 
                    format_int = '%d', short_first = true)
  if exts
    line = line.split.map_with_index do |val, ind|
      # If there's a remainder after dividing by 1, it's a float.
      if val.to_f.divmod(1)[1] > 0
        if ind == 0 and short_first
          sprintf('%2.1f', val.to_f)
        else
          sprintf(format_float, val.to_f)
        end
      else
        sprintf(format_int, val.to_i)
      end
    end
    line = line.join("\t") << "\n"
  else
    line = line.split.map do |val|
      # If there's a remainder after dividing by 1, it's a float.
      if val.to_f.divmod(1)[1] > 0
        sprintf(format_float, val.to_f)
      else
        sprintf(format_int, val.to_i)
      end
    end
    line = line.join("\t") << "\n"
  end  
end

def header(align, caption = 'test', label = 'table:label')
  puts <<-END
\\begin{table}[!t]
\\caption{#{caption}}
\\label{#{label}}
\\centering
\\begin{tabular}{|#{align}}
\\hline
END
end

def footer
  puts <<-END
\\end{tabular}
\\end{table}
END
end

input_file = ARGV.shift || nil

if input_file == nil
  puts "Usage: #{$0} <input.dat> '<caption>' '<label>'"
  exit
else
  unless File.exist?(input_file)
    puts "Input file #{input_file} doesn't exist."
    exit
  end
end

caption = ARGV.shift || nil
label = ARGV.shift || nil

data = File.readlines(input_file)

fields = data[0].split.length

align = (0..fields).map {'c|'}
align = align.join('')

# print table header
header(align, caption, label)

# Fist label line
puts line_to_row(data.shift)

puts '\hline'
data.each do |line|
  line = truncate_floats(line, exts)
  puts line.gsub(/\t/, ' & ').sub("\n", " \\\\\\\\\n")
  puts '\hline'
end

# print footer
footer

require 'date'
require 'yaml'

require_relative 'duplicati'

def run
  all_backups.each do |id, name|
    metadata = backup_metadata(id)

    file_size = metadata['SourceFilesSize'].to_i

    puts "#{field_name(name)}.value #{file_size / 1024.0 / 1024.0 / 1024.0}"
  end
end

def config
  puts "graph_title duplicati backup size"
  puts "graph_category backups"
  puts "graph_vlabel size (gb)"
  puts "graph_args -l 0 --base 1024"
  puts "graph_scale no"
  all_backups.each do |id, name|
    puts "#{field_name(name)}.label #{name}"
  end
end

if $0 == __FILE__
  if ARGV[0] == "config"
    config
  else
    run
  end
end

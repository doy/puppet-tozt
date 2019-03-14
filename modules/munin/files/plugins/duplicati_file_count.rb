require 'date'
require 'yaml'

require_relative 'duplicati'

def run
  all_backups.each do |id, name|
    metadata = backup_metadata(id)

    file_count = metadata['SourceFilesCount'].to_i

    puts "#{field_name(name)}.value #{file_count}"
  end
end

def config
  puts "graph_title duplicati number of files"
  puts "graph_category backups"
  puts "graph_vlabel number of files"
  puts "graph_args -l 0"
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

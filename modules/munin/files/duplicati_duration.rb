require 'date'
require 'yaml'

require_relative 'duplicati'

def run
  all_backups.each do |id, name|
    metadata = backup_metadata(id)

    took = parse_duration(metadata['LastBackupDuration'])

    puts "#{field_name(name)}.value #{took / 60.0}"
  end
end

def config
  puts "graph_title duplicati backup duration"
  puts "graph_category backups"
  puts "graph_vlabel duration (min)"
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

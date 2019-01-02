require 'date'
require 'yaml'

require_relative 'duplicati'

def run
  now = Time.now

  all_backups.each do |id, name|
    metadata = backup_metadata(id)

    last_run_date = DateTime.iso8601(metadata['LastBackupDate'])
    ago = now - last_run_date.to_time

    puts "#{field_name(name)}.value #{ago / 60.0 / 60.0 / 24.0}"
  end
end

def config
  puts "graph_title duplicati time since last run"
  puts "graph_category backups"
  puts "graph_vlabel time since last run (days)"
  puts "graph_args -l 0"
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

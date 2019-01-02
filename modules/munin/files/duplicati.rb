require 'date'
require 'yaml'

def parse_duration(dur)
  hours, minutes, seconds = dur.split(/:/)
  3600 * hours.to_f + 60 * minutes.to_f + seconds.to_f
end

def field_name(name)
  name.gsub(/\A[^A-Za-z_]/, '_').gsub(/[^A-Za-z0-9_]/, '_')
end

def backup_metadata(id)
    backup = YAML.load(%x{duplicati-client describe backup #{id}})
    backup[0]['Backup']['Metadata']
end

def all_backups
  _ = %x{duplicati-client login}
  backups = YAML.load(%x{duplicati-client list backups})
  ret = {}
  backups.each do |backup|
    name = backup.keys[0]
    id = backup[name]['ID']
    ret[id] = name
  end
  ret
end

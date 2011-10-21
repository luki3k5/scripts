require "rubygems"
require "google_spreadsheet"
require 'yaml'
require 'spreedsheet2yaml'

config = ""
begin 
  config = YAML.load_file("config.yml")
rescue Exception => ex 
  puts("config file missing!") 
  exit 
end

# Getting the login information
login = config['google_user_id']
# getting password information
password = config['google_password']
# getting spreedsheet id
spreedsheet_key = config['google_spreedsheet_to_process']

# Logs in.
session = GoogleSpreadsheet.login(login, password)
# getting the first worksheet 
ws = session.spreadsheet_by_key(spreedsheet_key).worksheets[0]

languages = {}
(3..ws.num_cols).each do |c|
  languages["#{ws[1,c]}"] = c
end

# Create flat HASH from Spreedsheet that will be processed 
languages.keys.each do |lang| 
  (2..ws.num_rows).each do |row|
    puts [[lang,ws[row, 1]].join('.'), ws[row, languages[lang]]].join(": ")
  end
  
  #   f = File.open("#{lang}.yml", 'w+') { Spreedsheet2yaml.create_yaml() }
end


#   # create a file: 
#   f = File.open("#{lang}.yml", 'w+') { Spreedsheet2yaml.create_yaml() }
#   # drop content to file from the keys and corresponding lang:
#   f.close
# end
require "rubygems"
require "google_spreadsheet"
require 'yaml'

# Getting the login information
puts "google docs login:"  
STDOUT.flush
login = gets.chomp  

# getting password information
puts "google docs password:"
STDOUT.flush  
password = gets.chomp  

# Logs in.
session = GoogleSpreadsheet.login(login, password)
# getting the first worksheet 
ws = session.spreadsheet_by_key("0Anp_bn4ib4f7dEo5R1FSSWdCTFdLbGs4cnlETnFVNHc").worksheets[0]

languages = {}
(3..ws.num_cols).each do |c|
  languages["#{ws[1,c]}"] = c
end

languages.keys.each do |lang| 
  # create a file: 
  f = File.open("#{lang}.yml", 'w+')
  # drop content to file from the keys and corresponding lang:
  (2..ws.num_rows).each do |row|
    f.puts [ws[row, 1], ws[row, languages[lang]]].join(": ")
  end
  f.close
end

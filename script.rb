require "rubygems"
require "google_spreadsheet"

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

(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    puts ws[row, col]
  end
end

#puts ws.rows


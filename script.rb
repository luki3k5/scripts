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

# -2 columns because the first on would be keys and second one is description
no_of_languages = ws.num_cols-2

languages = {}
(3..ws.num_cols).each do |c|
  languages["#{ws[1,c]}"] = c
end

# puts "I have following languages in columns: #{languages.inspect}"

languages.keys.each do |lang| 
  # create a file: 
  f = File.open(lang, 'w+')
  # drop content to file from the keys and corresponding lang:
  (2..ws.num_rows).each do |row|
    f.puts [ws[row, 1], ws[row, languages[lang]]].join(":")
  end
  f.close
end

# i18n_file = {}
# (2..ws.num_rows).each do |r|
#   languages.keys.each do |lang_key|
#      i18n_file["#{ws[r,1]}"] = ws[r, languages[lang_key]]
#   end
# end


# puts i18n_file.inspect
# # puts languages.class 
# # puts languages.inspect


# # (1..ws.num_rows).each do |row|
# #   (1..ws.num_cols).each do |col|
# #     puts ws[row, col]
# #   end
# # end

# # #puts ws.rows


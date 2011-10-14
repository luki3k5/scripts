#
# This script allows you to customize your /etc/hosts file so it will 
# prevent your browsers to reach out to ad servers. 
#
# This does not run any software just grabs the lists of know Advertisement servers 
# and produces output file that your can then examine and add to your /etc/hosts.  

# Here you can read what is the hosts file: http://en.wikipedia.org/wiki/Hosts_file

require 'open-uri'

input_file_name  = "lists.txt"
output_file_name = "hosts.txt"
lists, lists_urls = [], []

# Get the lists:
File.open(input_file_name).each { |line| lists_urls << line.scan(/(.*)[#]/)  }

lists_urls.each do |t|
  
  puts "#{t} - #{t.empty?}"
end


# for each list we get uri
lists_urls.each do |list|
  uri = URI.parse(list.to_s.strip)
  # we connect to uri and grab content 
  open(uri) do |content| 
    # we append on the fly to output file cleaning incoming content from html tags 
    File.open(output_file_name, 'a') {|f| f.write(content.read.gsub(/<\/?[^>]*>/, "").strip) } 
  end
end
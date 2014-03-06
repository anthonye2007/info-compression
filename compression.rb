#!/usr/bin/ruby
# Anthony Elliott
# Information Storage and Retrieval
# 3/6/2014

# size, base word * remainder of first word * remainder of second word

input = File.read(ARGV.first)
words = input.split("\n")
puts words.length.to_s

=begin
words.first.each_byte do |ascii|
  puts ascii
end
=end

output = File.open('output.txt', 'wb')

words.each do |word|
  output << word
  output << [word.length].pack('C')
end

output.close
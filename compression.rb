#!/usr/bin/ruby
# Anthony Elliott
# Information Storage and Retrieval
# 3/6/2014

input = File.read(ARGV.first)
words = input.split("\n")
puts words.length.to_s

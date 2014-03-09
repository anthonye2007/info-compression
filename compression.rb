#!/usr/bin/ruby
# Anthony Elliott
# Information Storage and Retrieval
# 3/6/2014

def second_compression(words)
  output = File.open('second.bin', 'wb')
  root_length = 5

  lengths = Hash.new

  root = ''
  remainders = []
  words.each do |word|
    if word.length < root_length
      # not long enough to be stemmed
      output << word.length
      output << word
    elsif word[0..root_length-1] == root
      # should be stemmed
      remainder = word.slice(root_length, word.length - 1)
      remainders.push(remainder)
    else
      # new root
      output << print_root(root, remainders) unless root == ''

      root = word[0..root_length-1]
      remainders = []
      remainder = word.slice(root.length, word.length - 1)
      remainders.push(remainder)
    end

    lengths[root] = remainders.length
  end

  output.close
end

def print_root(root, remainders)
  if remainders.length > 1
    str = root.length.to_s + root + '*'

    remainders.each do |remainder|
      str += remainder.length.to_s + remainder
    end
    str += '@'
  else
    word = root + remainders.first
    str = word.length.to_s + word
  end

  str
end

input = File.read(ARGV.first)
words = input.split("\n")

second_compression(words)

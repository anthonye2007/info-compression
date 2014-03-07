#!/usr/bin/ruby
# Anthony Elliott
# Information Storage and Retrieval
# 3/6/2014

# size, base word * remainder of first word * remainder of second word

def first_compression(words)
  output = File.open('first.bin', 'wb')

  words.each do |word|
    output << word
    output << [word.length].pack('C')
  end

  output.close
end

def stemming(words)
  # make one pass and do porter stemming to get base words
  # make second pass to output base word * remainder

  stems = []
  words.each do |word|
    if word.length >= 4 && word.slice(-4, word.length) == 'sses'
      stem = word[0..-3] # sses -> ss
      stems.push(stem) unless stems[-1] == stem
    elsif word.length >= 3 && word.slice(-3, word.length) == 'ies'
      stem = word[0..-3] # ies -> ss
      stems.push(stem) unless stems[-1] == stem
    elsif word.length >= 2 && word.slice(-2, word.length) == 'ss'
      stem = word
      stems.push(stem) unless stems[-1] == stem
    elsif word.length >= 2 and word.slice(-1, word.length) == 's'
      stem = word[0..-2] # s ->
      stems.push(stem) unless stems[-1] == stem
    end
  end

  puts stems.to_s
  puts 'Number of stems: ' + stems.length.to_s
end

def second_compression(words)
  output = File.open('second.bin', 'wb')
  root_length = 3

  root = ''
  remainders = []
  words.each do |word|
    if word.length < root_length
      output << word.length
      output << word
    elsif word[0..root_length-1] == root
      remainder = word.slice(root_length, word.length - 1)
      remainders.push(remainder)
    else
      # new root
      output << print_root(root, remainders) unless root == ''

      root = word[0..root_length-1]
      remainders = []
      remainder = word.slice(root_length, word.length - 1)
      remainders.push(remainder)
    end

  end

  output.close
end

def print_root(root, remainders)
  if remainders.length > 1
    str = root.length.to_s + root + '@'

    remainders.each do |remainder|
      str += remainder.length.to_s + remainder
    end
    str += '*'
  else
    word = root + remainders.first
    str = word.length.to_s + word
  end

  str
end

# max length of word is 28 characters
# can represent with 5 bits
def max_length (words)
  max = 0;
  words.each do |word|
    if word.length > max
      max = word.length
      puts word
    end
  end

  puts "Max length: " + max.to_s
end

input = File.read(ARGV.first)
words = input.split("\n")

#first_compression(words)
second_compression(words)

#!/usr/bin/env ruby

def fizz_buzz(num)
  if (num % 15).zero?
    'FizzBuzz'
  elsif (num % 3).zero?
    'Fizz'
  elsif (num % 5).zero?
    'Buzz'
  else
    num
  end
end

(1..20).each { |num| puts fizz_buzz(num) }

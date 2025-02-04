#!/usr/bin/env ruby
require 'date'
require 'optparse'

opt = OptionParser.new
date = {}
opt.on('-m [VAL]', Integer)
opt.on('-y [VAL]', Integer)
opt.parse!(ARGV, into: date)
date.fetch(:y) { date[:y] = Date.today.year}
date.fetch(:m) do
  if date[:y] == Date.today.year
    date[:m] = Date.today.month
  else
    date[:m] = 1
  end
end

first = Date.new(date[:y].to_i, date[:m], 1)
last = Date.new(date[:y].to_i, date[:m], -1)

puts "      #{first.month}月 #{first.year}"
puts %w(日 月 火 水 木 金 土).join(' ') + "\n"

last_day = last.day
spaces = [' '] * first.wday
puts (1..last_day)
  .to_a
  .unshift(*spaces)
  .each_slice(7)
  .map {|week| week.map { |day| day.to_s.rjust(2) }.join(' ') }
  .join("\n")

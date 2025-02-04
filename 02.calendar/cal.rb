#!/usr/bin/env ruby
require 'date'
require 'optparse'

option_parser = OptionParser.new
params = {}
option_parser.on('-m [VAL]', Integer) {|m| params[:month] = m}
option_parser.on('-y [VAL]', Integer) {|m| params[:year] = m}
option_parser.parse!(ARGV, into: params)

params[:year] ||= Date.today.year
params[:month] ||= (params[:year] == Date.today.year ? Date.today.month : 1)

first_day = Date.new(params[:year], params[:month], 1)
last_day = Date.new(params[:year], params[:month], -1)

puts "      #{first_day.month}月 #{first_day.year}"
puts %w(日 月 火 水 木 金 土).join(' ') + "\n"

days_in_month = last_day.day
leading_spaces = [' '] * first_day.wday

puts (1..days_in_month)
  .to_a
  .unshift(*leading_spaces)
  .each_slice(7)
  .map {|week| week.map { |day| day.to_s.rjust(2) }.join(' ') }
  .join("\n")

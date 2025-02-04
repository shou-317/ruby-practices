#!/usr/bin/env ruby
require 'date'
require 'optparse'

def parse_arguments
  option_parser = OptionParser.new
  params = {}
  option_parser.on('-m [VAL]', Integer) {|m| params[:month] = m}
  option_parser.on('-y [VAL]', Integer) {|m| params[:year] = m}
  option_parser.parse!(ARGV, into: params)
  params[:year] ||= Date.today.year
  params[:month] ||= (params[:year] == Date.today.year ? Date.today.month : 1)
  generate_calendar(params)
end

def generate_calendar(params)
  first_day = Date.new(params[:year], params[:month], 1)
  last_day = Date.new(params[:year], params[:month], -1)
  days_in_month = last_day.day
  leading_spaces = [' '] * first_day.wday
  calendar_rows = (1..days_in_month)
    .to_a
    .unshift(*leading_spaces)
    .each_slice(7)
    .map {|week| week.map { |day| day.to_s.rjust(2) }.join(' ') }
    .join("\n")
  display_calendar(params, calendar_rows)
end

def display_calendar(params, calendar_rows)
  puts "      #{params[:month]}月 #{params[:year]}"
  puts %w(日 月 火 水 木 金 土).join(' ') + "\n"
  puts calendar_rows
end

parse_arguments

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

def main
  params = parse_arguments
  calendar_rows = generate_calendar(params)
  display_calendar(params, calendar_rows)
end

def parse_arguments
  option_parser = OptionParser.new
  params = {}
  option_parser.on('-m [VAL]', Integer) { |m| params[:month] = m }
  option_parser.on('-y [VAL]', Integer) { |m| params[:year] = m }
  option_parser.parse!(ARGV, into: params)
  today = Date.today
  params[:year] ||= today.year
  params[:month] ||= (params[:year] == today.year ? today.month : 1)
  params
end

def generate_calendar(params)
  first_date = Date.new(params[:year], params[:month], 1)
  last_date = Date.new(params[:year], params[:month], -1)
  days_in_month = last_date.day
  leading_spaces = [' '] * first_date.wday

  (1..days_in_month)
    .to_a
    .unshift(*leading_spaces)
    .each_slice(7)
    .map { |week| week.map { |day| day.to_s.rjust(2) }.join(' ') }
    .join("\n")
end

def display_calendar(params, calendar_rows)
  puts "      #{params[:month]}月 #{params[:year]}"
  puts "#{%w[日 月 火 水 木 金 土].join(' ')}\n"
  puts calendar_rows
end

main if __FILE__ == $PROGRAM_NAME

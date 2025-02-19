#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  entries = fetch_directory_entries
  max_length = calculate_max_length(entries)
  col_width = calculate_column_width(max_length)
  entries = format_entries(entries, col_width)
  display_entries(entries)
end

def fetch_directory_entries
  Dir.entries('.').reject { |entry| entry.match?(/^\./) }.sort
end

def calculate_max_length(entries)
  entries.max_by(&:length).length || 0
end

def calculate_column_width(max_length)
  col_width = [(max_length.to_f / 8).ceil * 8, 16].max
  col_width += 8 if col_width == max_length
  col_width
end

def format_entries(entries, width)
  entries.map { |entry| entry.ljust(width) }
end

def display_entries(entries)
  entries.each_slice(3) do |row|
    puts row.join
  end
end

main if $PROGRAM_NAME == __FILE__

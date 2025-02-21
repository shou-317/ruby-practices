#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE = [10].freeze

def main
  scores = ARGV[0]
  shots = parse_score_input(scores)
  frames = generate_frames(shots)
  point = calculate_point(frames)
  puts point
end

def parse_score_input(scores)
  scores.split(',').flat_map { |score| score == 'X' ? [10, 0] : score.to_i }
end

def generate_frames(shots)
  frames = shots.each_slice(2).map { |frame| frame == [10, 0] ? STRIKE : frame }
  frames[9..] = [frames[9..].flatten]
  frames
end

def calculate_point(frames)
  frames.each_with_index.sum do |frame, index|
    next frame.sum if index == 9

    bonus = if frame == STRIKE
              frames[index + 1][0] + (frames[index + 1][1] || frames[index + 2][0])
            elsif frame.sum == 10
              frames[index + 1][0]
            end

    frame.sum + bonus.to_i
  end
end

main if __FILE__ == $PROGRAM_NAME

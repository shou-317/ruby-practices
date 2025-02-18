#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE = [10].freeze
scores = ARGV[0].split(',')

shots = scores.flat_map { |score| score == 'X' ? [10, 0] : score.to_i }

frames = shots.each_slice(2).to_a

frames = frames.map { |frame| frame == [10, 0] ? STRIKE : frame }
frames[9..] = [frames[9..].flatten]

point = frames.each_with_index.sum do |frame, index|
  frame_sum = frame.sum
  next frame_sum if index == 9

  if frame == STRIKE
    second_bonus_ball = frames[index + 1][1] || frames[index + 2][0]
    frame_sum + frames[index + 1][0] + second_bonus_ball
  elsif frame_sum == 10
    frame_sum + frames[index + 1][0]
  else
    frame_sum
  end
end

puts point

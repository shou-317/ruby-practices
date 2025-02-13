#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')

shots = []
shots = scores.flat_map { |score| score == 'X' ? [10, 0] : score.to_i }

frames = []
frames = shots.each_slice(2).to_a

frames = frames.map { |frame| frame == [10, 0] ? [10] : frame }
frames[9..] = [frames[9..].flatten]

point = 0
point = frames.each_with_index.sum do |frame, index|
  next frame.sum if index == 9

  if frame[0] == 10
    second_bonus_ball = frames[index + 1][1] || frames[index + 2][0]
    frame.sum + frames[index + 1][0] + second_bonus_ball
  elsif frame.sum == 10
    frame.sum + frames[index + 1][0]
  else
    frame.sum
  end
end

puts point

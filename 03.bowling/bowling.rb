#!/usr/bin/env ruby

params = ARGV[0]

shots = []
scores = params.split(',')
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

frames = shots.each_slice(2).to_a
if frames[9][0] == 10
  if frames[10][0] == 10
    frames[9].concat(frames[10], frames[11])
    frames.pop(2)
  else
    frames[9].concat(frames[10])
    frames.pop(1)
  end
  frames[9].delete(0)
end

point = 0
frames.each_with_index do |frame, idx|
  if idx == 9
    point += frame.sum
  elsif frame[0] == 10
    if frames[idx + 1][0] == 10
      if idx >= 8
        point += frame[0] + frames[idx + 1][0..1].sum
      else
        point += frame[0] + frames[idx + 1][0..1].sum + frames[idx + 2][0]
      end
    else
      point += frame[0] + frames[idx + 1][0..1].sum
    end
  elsif frame.sum == 10
    point += frame.sum + frames[idx + 1][0]
  else
    point += frame.sum
  end
end

puts point

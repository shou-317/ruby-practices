#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアをカンマ区切りで取得
scores = ARGV[0].split(',')

# スコアを数値化
shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

# フレームを作成
frames = []
shots.each_slice(2) do |shot|
  frames << shot
end
# ストライクのフレームを1投にする
frames = frames.map { |frame| frame == [10, 0] ? [10] : frame }
# 10フレーム以降の投球を1つにまとめる
frames[9..] = [frames[9..].flatten]

# スコア計算
point = 0
point += frames.each_with_index.sum do |frame, index|
  # 10フレーム目はストライクやスペアを考慮せず合計を求める
  next frame.sum if index == 9

  if frame[0] == 10 # ストライクのとき
    # 次の2投を加算する（次のフレームがストライクなら、さらにその次の1投も考慮）
    next_two_shots = frames[index + 1][1] || frames[index + 2][0]
    10 + frames[index + 1][0] + next_two_shots
  elsif frame.sum == 10 # スペアのとき
    # 次の1投を加算
    10 + frames[index + 1][0]
  else
    # フレームの合計を求める
    frame.sum
  end
end

puts point

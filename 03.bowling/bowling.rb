#!/usr/bin/env ruby
# frozen_string_literal: true

# コマンドライン引数を配列にする
scores = ARGV[0].split(',')

# データの整形
# 文字列を整数に変換する
shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

# 整数の配列を2つずつ分ける
frames = []
shots.each_slice(2) do |shot|
  frames << shot
end
# 0が入ると処理が複雑化するため、[10,0]を[10]にする
frames = frames.map { |frame| frame == [10, 0] ? [10] : frame }
# 10フレーム以降の要素を1つにまとめる
frames[9..] = [frames[9..].flatten]

# スコア計算
point = 0
point += frames.each_with_index.sum do |frame, index|
  # 10投目はフレームの合計
  if index == 9
    frame.sum
  elsif frame[0] == 10 # ストライクのとき
    # 次のフレームがストライクかどうかで条件分岐
    if frames[index + 1][0] == 10
      # [[10], [10], [n(, n)]..]のとき、frames[index + 1][1]はnilのため、frames[index + 2][0]を2投目として加算する
      frame[0] + frames[index + 1][0] + (frames[index + 1][1] || frames[index + 2][0])
    else
      frame[0] + frames[index + 1][0..1].sum # 次の2投を加算
    end
  elsif frame.sum == 10 # スペアのとき
    frame.sum + frames[index + 1][0] # 次の1投を加算
  else
    frame.sum
  end
end

puts point

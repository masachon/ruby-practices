# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = frames.each_with_index.sum do |frame, index|
  base_score = frame.sum

  bonus_score = if index >= 9
                  0
                elsif frame[0] == 10 && frames[index + 1][0] == 10
                  10 + frames[index + 2][0]
                elsif frame[0] == 10
                  frames[index + 1][0] + frames[index + 1][1]
                elsif frame.sum == 10
                  frames[index + 1][0]
                else
                  0
                end

  base_score + bonus_score
end

puts point

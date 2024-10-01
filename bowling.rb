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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0

frames.each_with_index do |frame, index|
  point += if index >= 9
             frame.sum
           elsif frame[0] == 10 && frames[index + 1] && frames[index + 1][0] == 10
             10 + 10 + (shots[index * 2 + 4] || 0)
           elsif frame[0] == 10
             10 + (shots[index * 2 + 2] || 0) + (shots[index * 2 + 3] || 0)
           elsif frame.sum == 10
             10 + (shots[index * 2 + 2] || 0)
           else
             frame.sum
           end
end

puts point

# frozen_string_literal: true

def list_files
  # 現在のディレクトリのファイルを取得し、ソート
  Dir.entries(Dir.pwd).select { |entry| entry != '.' && entry != '..' }.sort
end

def calculate_max_widths(formatted_output)
  # 各列の最大幅を計算
  max_widths = Array.new(3, 0)
  formatted_output.each do |row|
    row.each_with_index do |file, column_index|
      max_widths[column_index] = [max_widths[column_index], file.to_s.length].max if file
    end
  end
  max_widths
end

def format_and_display(files, columns = 3)
  sorted_files = files.sort_by { |file| file.to_i.to_s.length }
  max_rows = (sorted_files.size.to_f / columns).ceil
  formatted_output = Array.new(max_rows) { [] }

  # 各ファイルを配置
  sorted_files.each_with_index do |file, index|
    row_index = index % max_rows
    formatted_output[row_index] << file
  end

  # 最大幅を計算
  max_widths = calculate_max_widths(formatted_output)

  # 各行を出力
  formatted_output.each do |row|
    row_output = row.map.with_index do |file, column_index|
      file.nil? ? ' ' * max_widths[column_index] : file.ljust(max_widths[column_index])
    end.join(' ' * 2) # 2スペースで区切って表示
    puts row_output
  end
end

# メインプログラム
files = list_files
format_and_display(files)

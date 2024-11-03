# frozen_string_literal: true

def list_files
  # 現在のディレクトリのファイルを取得し、ソート
  Dir.glob('*').sort
end

# 列数を定数として設定
COLUMNS = 3

def calculate_max_widths(formatted_output)
  # 各列の最大幅を計算
  max_widths = Array.new(COLUMNS, 0)
  formatted_output.each do |row|
    row.each_with_index do |file, column_index|
      max_widths[column_index] = [max_widths[column_index], file.to_s.length].max
    end
  end
  max_widths
end

def format_and_display(files)
  sorted_files = files.sort_by(&:to_i)
  max_rows = (sorted_files.size.to_f / COLUMNS).ceil
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
      (file || '').ljust(max_widths[column_index])
    end.join(' ' * 2)
    puts row_output
  end
end

# メインプログラム
files = list_files
format_and_display(files)

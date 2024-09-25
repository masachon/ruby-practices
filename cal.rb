#!/usr/bin/env ruby

require 'optparse'
require 'date'

options = {
  year: Date.today.year,
  month: Date.today.month,
}

OptionParser.new do |opts|
  opts.on("-yYEAR") do |y|
    options[:year] = y.to_i
  end
    
  opts.on("-mMONTH") do |m|
    options[:month] = m.to_i
  end
end.parse!

def print_calendar(month, year)
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  days_in_month = (first_day..last_day)

  puts "#{Date::MONTHNAMES[month]} #{year}".center(20)
  puts "Su Mo Tu We Th Fr Sa"

  print "   " * first_day.wday

  days_in_month.each do |date|
    print date.day.to_s.rjust(2) + " "
    puts if date.saturday?
  end
  puts
end

print_calendar(options[:month], options[:year])

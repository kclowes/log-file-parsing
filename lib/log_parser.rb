class LogParser

  def initialize(input)
    @input = input
  end

  def formatter
    result = []
    @input.each do |line|
      result << line[0]
      line.split(', ')[1].split('] ').map do |l|
        result << l.gsub('[', '').split
      end
    end
    returns = []
    i = 0
    while i <= (@input.length * 2)
      first_array = result[i..(i+1)], result[i+2].join(' ')
      returns << first_array.flatten
      i += 3
    end
    returns
  end

  def date_range
    time_array = []
    formatter.each do |array|
      time_array << array[1]
    end
    DateTime.parse(time_array.last) - DateTime.parse(time_array.first)
  end

  def count_date(year, month, day)
    count = 0
    formatter.each do |array|
      date = Date.new(year, month, day).to_s
      if array[1].include?(date.to_s)
        count += 1
      end
    end
    count
  end
end



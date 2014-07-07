require 'spec_helper'
require './lib/log_parser'

describe LogParser do

  it 'will return the array in a normal format' do
    input = ["D, [2014-05-10T14:48:19.093626 #85971] DEBUG -- : maximize proactive e-business",
             "I, [2014-05-10T14:48:19.093737 #85971]  INFO -- : benchmark vertical functionalities"]
    expected = ["D", '2014-05-10T14:48:19.093626', '#85971', 'DEBUG -- : maximize proactive e-business'],
      ["I", '2014-05-10T14:48:19.093737', '#85971', "INFO -- : benchmark vertical functionalities"]
    actual = LogParser.new(input).formatter
    expect(actual).to eq(expected)
  end

  it 'will return the range of dates of the log file' do
    input = ["D, [2014-05-10T14:48:19.093626 #85971] DEBUG -- : maximize proactive e-business", "I, [2014-05-10T14:48:19.093737 #85971]  INFO -- : benchmark vertical functionalities"]
    parser = LogParser.new(input)
    actual = parser.date_range

    expected = 1.2847222222222222e-09
    expect(actual).to eq(expected)
  end

  it 'will return how many entries are on a given day' do
    input = ["D, [2014-05-10T14:48:19.093626 #85971] DEBUG -- : maximize proactive e-business",
             "W, [2014-05-11T14:48:19.100888 #85971]  WARN -- : envisioneer vertical paradigms",
             "I, [2014-05-10T14:48:19.093737 #85971]  INFO -- : benchmark vertical functionalities"]
    parser = LogParser.new(input)
    actual = parser.count_date(2014, 05, 10)
    expect(actual).to eq(2)
  end
end
# Anti Single Responsibility Principle
#
# Calculator
#   Is responsible for parsing the input, calculating the result
#   and then printing it

require 'minitest/autorun'

class Calculator
  def calculate(str)
    result = "error"

    if str =~ /(\d+) \+ (\d+)/
      result = $1.to_i + $2.to_i
    end

    puts result
    result
  end
end


describe Calculator do
  before do
    @calculator = Calculator.new
  end

  it "should add two numbers" do
    assert_equal 6, @calculator.calculate("2 + 4")
  end
end

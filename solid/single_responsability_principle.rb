# Single Responsability Principle
#
# AdditionOperation
#   Is just responsible for adding two numbers together
# ResultPrinter
#   Is just responsible for printing the result on the screen
# Calculator
#   Is just responsible for parsing the equations and gluing the
#   Printing and Operation components together to make the calculator...
#   well... calculate.

require 'minitest/autorun'

class AdditionOperation
  def calculate(a, b)
    a + b
  end
end

class ResultPrinter
  def print(result)
    puts result
  end
end

class Calculator
  def initialize
    @operation = AdditionOperation.new
    @printer   = ResultPrinter.new
  end

  def parse(str)
    m = /(\d+) (\+) (\d+)/.match(str)
    { :op => m[2], :a => m[1].to_i, :b => m[3].to_i}
  end

  def calculate(str)
    args = parse(str)
    result = @operation.calculate(args[:a], args[:b])
    @printer.print(result)
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

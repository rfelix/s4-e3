# Single Responsability Principle
#
# AdditionOperation
#   Is just responsible for adding two numbers together
# ResultPrinter
#   Is just responsible for printing the result on the screen
# Calculator
#   Is just responsible for printing the users calculation

require 'minitest/autorun'

class AdditionOperation
  def calculate(str)
    result = "error"

    if str =~ /(\d+) \+ (\d+)/
      result = $1.to_i + $2.to_i
    end

    result
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

  def calculate(str)
    result = @operation.calculate(str)
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

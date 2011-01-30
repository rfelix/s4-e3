# Dependency Inversion Principle
#
# The first version of the code created instances of AdditionOperation and
# ResultPrinter in the constructor of Calculator, thus creating a dependency on
# on concrete objects.
#
# By allowing those instances to be passed into the Calculator constructor, we
# effectively invert the dependency by injecting the needed instance into the class.
# This way, we can easily change the type of Operation for the calculator to perform
# and we can easily supply mock objects to make testing easier.

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

class SubtractionOperation
  def calculate(str)
    result = "error"

    if str =~ /(\d+) \- (\d+)/
      result = $1.to_i - $2.to_i
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
  def initialize(options = {})
    @operation = options[:operation] || AdditionOperation.new
    @printer   = options[:printer]   || ResultPrinter.new
  end

  def calculate(str)
    result = @operation.calculate(str)
    @printer.print(result)
    result
  end
end

describe Calculator do
  it "should add two numbers" do
    calculator = Calculator.new
    assert_equal 6, calculator.calculate("2 + 4")
  end

  it "should subtract two numbers" do
    calculator = Calculator.new :operation => SubtractionOperation.new
    assert_equal -2, calculator.calculate("2 - 4")
  end

  it "should be easier to test using mocks" do
    operation_mock = MiniTest::Mock.new
    operation_mock.expect :calculate, 4, ["2 + 2"]
    calculator = Calculator.new :operation => operation_mock
    assert_equal 4, calculator.calculate("2 + 2")
    operation_mock.verify
  end
end

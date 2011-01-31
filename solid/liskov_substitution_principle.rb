# Liskov Substitution Principle
#
# Operation is the base class that the rest of the operations
# inherit from. As long as they define the calculate method that
# accepts two integers and returns a result, the LSP violation
# won't be violated.
#
# This is why the operation variable is defined using a case
# statement, because any of the subclasses can be used as if
# we were using the parent Operation class. So once we've
# identified the right operation class, we just call the calculate
# method and supply the right arguments.

require 'minitest/autorun'

class Calculator
  def initialize
  end

  def parse(str)
    m = /(\d+) (.) (\d+)/.match(str)
    { :op => m[2], :a => m[1].to_i, :b => m[3].to_i}
  end

  def calculate(str)
    args = parse(str)
    operation = case args[:op]
                 when '+'
                   AdditionOperation.new
                 when '-'
                   SubtractionOperation.new
                 when '*'
                   MultiplicationOperation.new
                 else
                   Operation.new
                 end
    result = operation.calculate(args[:a], args[:b])

    puts result
    result
  end
end

class Operation
  def calculate(a, b)
    raise "Unknown Operation"
  end
end

class AdditionOperation < Operation
  def calculate(a,b)
    a + b
  end
end

class SubtractionOperation < Operation
  def calculate(a,b)
    a - b
  end
end

class MultiplicationOperation < Operation
  def calculate(a,b)
    a * b
  end
end

describe Calculator do
  it "should add two numbers" do
    calculator = Calculator.new
    assert_equal 6, calculator.calculate("2 + 4")
  end

  it "should subtract two numbers" do
    calculator = Calculator.new
    assert_equal -2, calculator.calculate("2 - 4")
  end

  it "should multiply two numbers" do
    calculator = Calculator.new
    assert_equal 8, calculator.calculate("2 * 4")
  end
end

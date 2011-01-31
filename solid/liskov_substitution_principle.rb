# Liskov Substitution Principle
#
# The AdditionOperation is the main operation class that can
# add two numbers together.
#
# Because of the methods it defines, we can easily create subclasses
# that override just two methods (accepted_regexp and perform_operation)
# in order to provide support for new operations (OCP present here too).
#
# Because the new subclasses SubtractionOperation and MultiplicationOperation
# don't don't do anything they're not supposed to, they can be used anywhere
# the AdditionOperation class is used.

require 'minitest/autorun'

class Calculator
  def initialize(operation = AdditionOperation.new)
    @operation = operation
  end

  def calculate(str)
    result = "error"

    result = @operation.calculate(str)

    puts result
    result
  end
end

class AdditionOperation
  def accepts_str?(str)
    str =~ accepted_regexp
  end

  def calculate(str)
    m = accepted_regexp.match(str)
    perform_operation(m[1].to_i, m[2].to_i)
  end

  def perform_operation(a,b)
    a + b
  end

  def accepted_regexp
    /(\d+) \+ (\d+)/
  end
end

class SubtractionOperation < AdditionOperation
  def perform_operation(a,b)
    a - b
  end

  def accepted_regexp
    /(\d+) \- (\d+)/
  end
end

class MultiplicationOperation < AdditionOperation
  def perform_operation(a,b)
    a * b
  end

  def accepted_regexp
    /(\d+) \* (\d+)/
  end
end

describe Calculator do
  it "should add two numbers" do
    calculator = Calculator.new
    assert_equal 6, calculator.calculate("2 + 4")
  end

  it "should subtract two numbers" do
    calculator = Calculator.new SubtractionOperation.new
    assert_equal -2, calculator.calculate("2 - 4")
  end

  it "should multiply two numbers" do
    calculator = Calculator.new MultiplicationOperation.new
    assert_equal 8, calculator.calculate("2 * 4")
  end
end

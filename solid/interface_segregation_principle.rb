# Interface Segregation Principle
#
# The ISP was removed from the LSP example by defining a protocol
# where Subclasses of Operation can identify their textual operator
# be defining the belongs_to? method.
#
# This was the Calclator object doesn't rely or have any dependency
# on any Operation subclass. Instead, it uses a small "interface" to
# identify which of the available operations can be used to calculate
# the specified equation.


require 'minitest/autorun'

class Calculator
  def initialize
    @operations = [
      AdditionOperation.new,
      SubtractionOperation.new,
      MultiplicationOperation.new,
      Operation.new
    ]
  end

  def parse(str)
    m = /(\d+) (.) (\d+)/.match(str)
    { :op => m[2], :a => m[1].to_i, :b => m[3].to_i}
  end

  def calculate(str)
    args = parse(str)
    @operation = @operations.detect { |o| o.belongs_to?(args[:op]) }
    result = @operation.calculate(args[:a], args[:b])

    puts result
    result
  end
end

class Operation
  def calculate(a, b)
    raise "Unknown Operation"
  end

  def belongs_to?(op)
    true
  end
end

class AdditionOperation < Operation
  def calculate(a,b)
    a + b
  end

  def belongs_to?(op)
    op == '+'
  end
end

class SubtractionOperation < Operation
  def calculate(a,b)
    a - b
  end

  def belongs_to?(op)
    op == '-'
  end
end

class MultiplicationOperation < Operation
  def calculate(a,b)
    a * b
  end

  def belongs_to?(op)
    op == '*'
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

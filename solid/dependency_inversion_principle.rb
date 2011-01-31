# Dependency Inversion Principle
#
# The DIP violation from ISP is removed by eliminating the
# dependencies the Calculator object had on the concrete
# Operation subclasses.
#
# Instead, we allow the user of the Calculator class to pass
# in all the available Operations, and thus removing the
# dependency on concrete classes.
#
# Doing this also makes that code easier to test using mock objects
# which can be passed to the constructor and act like Operation classes.

require 'minitest/autorun'

class Calculator
  def initialize(operations = [Operation.new])
    @operations = operations
  end

  def parse(str)
    m = /(\d+) (.) (\d+)/.match(str)
    { :op => m[2], :a => m[1].to_i, :b => m[3].to_i}
  end

  def calculate(str)
    args = parse(str)
    @operation = @operations.detect { |o|
      o.belongs_to?(args[:op])
    }
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
  before do
    @calculator = Calculator.new([
      AdditionOperation.new,
      SubtractionOperation.new,
      MultiplicationOperation.new,
      Operation.new
    ])
  end

  it "should add two numbers" do
    assert_equal 6, @calculator.calculate("2 + 4")
  end

  it "should subtract two numbers" do
    assert_equal -2, @calculator.calculate("2 - 4")
  end

  it "should multiply two numbers" do
    assert_equal 8, @calculator.calculate("2 * 4")
  end

  it "should be easier to test using mocks" do
    operation_mock = MiniTest::Mock.new
    operation_mock.expect :belongs_to?, true, ['+']
    operation_mock.expect :calculate,   4,    [2, 2]
    calculator = Calculator.new [operation_mock]
    assert_equal 4, calculator.calculate("2 + 2")
    operation_mock.verify
  end
end

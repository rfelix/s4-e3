# Anti Open Closed Principle
#
# This code violates the OCP princple in two ways:
#
# Using the if statement to identify which operation to perform
# makes this method open for modification because the day we need
# to add more operations to the Calculator we will have to modify the
# calculate method.
#
# Another case we would need to modify the Calculator#calculate method
# is when we want to change the way the results are printed out or
# to where the results are printed to (e.g. printer)

require 'minitest/autorun'

class Calculator
  def parse(str)
    m = /(\d+) (.) (\d+)/.match(str)
    { :op => m[2], :a => m[1].to_i, :b => m[3].to_i}
  end

  def calculate(str)
    args = parse(str)

    result = if args[:op] == "+"
      AdditionOperation.new.calculate(args[:a], args[:b])
    else
      Operation.new.calculate(args[:a], args[:b])
    end

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


describe Calculator do
  it "should add two numbers" do
    calculator = Calculator.new
    assert_equal 6, calculator.calculate("2 + 4")
  end
end

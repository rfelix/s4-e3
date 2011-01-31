# Open Closed Principle
#
# The Calculator class is closed for modification with regards to
# the printing of the result, but it is open to extension using
# Ruby blocks.
#
# By passing a block to the calculate method, we can extend the way
# the calculators results are displayed. The default display is just
# printing the result on screen. The second example changes the display
# so that a box of * is created around the calculation's result.

require 'minitest/autorun'
require 'stringio'


class Calculator
  def initialize(&block)
    @print_block = block || lambda { |r| puts r }
  end

  def calculate(str, &block)
    result = "error"

    if str =~ /(\d+) \+ (\d+)/
      result = $1.to_i + $2.to_i
    end

    @print_block.call(result)

    result
  end
end


describe Calculator do
  it "should add two numbers" do
    calculator = Calculator.new
    output, err = capture_io do
      assert_equal 6, calculator.calculate("2 + 4")
    end

    assert_equal "6\n", output
  end

  it "should print a box around the addition of two numbers" do
    calculator = Calculator.new do |result|
      puts "*" * (result.to_s.length + 4)
      puts "* #{result} *"
      puts "*" * (result.to_s.length + 4)
    end

    output, err = capture_io do
      assert_equal 6, calculator.calculate("2 + 4")
    end

    assert_equal "*****\n* 6 *\n*****\n", output
  end
end

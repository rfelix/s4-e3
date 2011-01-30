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
  def calculate(str, &block)
    result = "error"

    if str =~ /(\d+) \+ (\d+)/
      result = $1.to_i + $2.to_i
    end

    if block
      block.call(result)
    else
      puts result
    end

    result
  end
end


describe Calculator do
  before do
    @calculator = Calculator.new
  end

  def capture_output
    old_stdout = $stdout
    new_stdout = StringIO.new
    $stdout = new_stdout
    yield
    $stdout = old_stdout
    new_stdout.string
  end

  it "should add two numbers" do
    output = capture_output do
      assert_equal 6, @calculator.calculate("2 + 4")
    end

    assert_equal "6\n", output
  end

  it "should print a box around the addition of two numbers" do
    output = capture_output do
      assert_equal 6, @calculator.calculate("2 + 4") { |result|
        puts "*" * (result.to_s.length + 4)
        puts "* #{result} *"
        puts "*" * (result.to_s.length + 4)
      }
    end

    assert_equal "*****\n* 6 *\n*****\n", output
  end
end

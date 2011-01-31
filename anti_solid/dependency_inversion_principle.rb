# Anti Dependency Inversion Principle
#
# This code violates the DIP (among others) due to the fact that in the
# Constructor of Calculator there is a reference to the concrete object
# StdoutPrinter.
#
# Because this is a concrete object, we're depending directly on it.  So if the
# object ever to change the method print, to say puts, we would need to change
# StdoutPrinter. Using DIP, if that ever happened, we could create a printer
# adapter to make a brigde between the different interfaces.
#
# Violating DIP also limits us to what the Calculator can do, because we can't
# customize or add different printers to the Calculator.

require 'minitest/autorun'

class StdoutPrinter
  def print(result)
    puts result
  end
end

class Calculator
  def initialize
    @printer = StdoutPrinter.new
  end

  def calculate(str)
    result = "error"

    if str =~ /(\d+) \+ (\d+)/
      result = $1.to_i + $2.to_i
    end

    @printer.print result
    result
  end
end


describe Calculator do
  before do
    @calculator = Calculator.new
  end

  it "should add two numbers" do
    out, err = capture_io do
      assert_equal 6, @calculator.calculate("2 + 4")
    end
    assert_equal "6\n", out
  end
end

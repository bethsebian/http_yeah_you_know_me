require 'pry'

class Iteration_0

  attr_accessor :output, :counter

  def initialize(counter, output = [])
    @output = output
    @counter = counter
  end


  def process_request
    @output = ["Hello, World! (#{@counter})"]
  end

end

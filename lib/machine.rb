class Iteration_0

  attr_accessor :input, :output

  def initialize(counter, input = [], output = [])
    @input = input
    @output = output
    @counter = counter
  end


  def process_request
    @output = input + ["\n\n COUNT: #{@counter}"]
  end

end

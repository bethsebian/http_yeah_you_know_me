require 'pry'

class Iteration_2
  attr_accessor :output, :input, :path, :counter

  def initialize(counter, input, output = [])
    @output = output
    @input = input
    @path = @input[0].split[1]
    @counter = counter
  end

  def process_request
    case path
      when "/"
        iteration_1 = Iteration_1.new(input)
        iteration_1.process_request
        self.output = iteration_1.output
      when "/hello"
        iteration_0 = Iteration_0.new(counter,input)
        iteration_0.process_request
        self.output = iteration_0.output
      when "/datetime"
        t = Time.now
        self.output = [t.strftime("%l:%M %p on %A, %B %d, %Y")]
      when "/shutdown"
        self.output = ["shutdown","Total Requests: #{@counter}"]
      else
    end
  end
end
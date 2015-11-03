require 'pry'
require_relative 'executable'

class Machine

  attr_reader :parser

  def initialize(to_machine)
    @parser = Parser.new(to_machine)
    @counter = 0
    @hello_counter = 0
  end

  def process_request(counter,hello_counter)
    @counter += 1
    case @parser.path
      when "/"
        ["Hello, World! Iteration 1 occurred"]
      when "/hello"
        @hello_counter += 1
        ["Hello"] +[" World! (#{@hello_counter})"]
      when "/datetime"
        [Time.now.strftime("%l:%M %p on %A, %B %d, %Y")]
      when "/shutdown"
        ["shutdown","Total Requests: #{counter}"]
      else
    end
  end
end

# need 404 if unknown path entered

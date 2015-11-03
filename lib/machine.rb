require 'pry'
require_relative 'executable'

class Machine
  def path(input)
    input[0].split[1]
  end

  def process_request(input,counter,hello_counter)
    case path(input)
      when "/"
        ["Hello, World! Iteration 1 occurred"]
      when "/hello"
        ["Hello"] +[" World! (#{hello_counter})"]
      when "/datetime"
        [Time.now.strftime("%l:%M %p on %A, %B %d, %Y")]
      when "/shutdown"
        ["shutdown","Total Requests: #{counter}"]
      else
    end
  end
end

# need 404 if unknown path entered

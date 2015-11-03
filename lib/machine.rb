require 'pry'
require_relative 'executable'

class Machine

  attr_reader :parser

  def initialize(to_machine)
    @parser = Parser.new(to_machine)
  end

  def process_request(counter,hello_counter)
    case @parser.path
      when "/"
        ["Verb: #{parser.verb}"] + ["Path: #{parser.path}"] + ["Protocol: #{parser.protocol}"] + ["Host: #{parser.host}"] + ["Port: #{parser.port}"] + ["Origin: #{parser.origin}"] + ["Accept: #{parser.accept}"]
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


# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>

# Verb: @input[0].split[0]
# Path: / @input[0].split[1]
# Protocol: HTTP/1.1    @input[0].split[2]
# Host: 127.0.0.1   @input[1].split(":")[1].strip
# Port: 9292 @input[1].split(":")[2].strip
# Origin: 127.0.0.1   @input[1].split(":")[1].strip
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8 @input[3]
# </pre>
#

# need 404 if unknown path entered

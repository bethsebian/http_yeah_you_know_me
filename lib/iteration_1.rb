require 'pry'

class Iteration_1

  attr_accessor :output, :input

  def initialize(input, output = [])
    @output = output
    @input = input
  end

  def process_request
    binding.pry
    @output = ["Hello, World! (#{@counter})"]
  end

end

  @output =
  @input[0]

# 0 ["GET / HTTP/1.1",
# 1 "Host: 127.0.0.1:9292",
# 2 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0",
# 3 "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
# 4 "Accept-Language: en-US,en;q=0.5",
# 5 "Accept-Encoding: gzip, deflate",
# 6 "Connection: keep-alive"]

# Let's start to rip apart that request and output it in your response. In the body of your response, include a block of HTML like this including the actual information from the request:
#
# <pre>
# Verb: @input[0].split[0]
# Path: / @input[0].split[1]
# Protocol: HTTP/1.1    @input[0].split[2]
# Host: 127.0.0.1   @input[1].split(":")[1].strip
# Port: 9292 @input[1].split(":")[2].strip
# Origin: 127.0.0.1   @input[1].split(":")[1].strip
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8 @input[3]
# </pre>
#
# Keep the code that outputs this block at the bottom of all your future outputs to help with your debugging.

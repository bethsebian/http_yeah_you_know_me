require 'minitest/autorun'
require_relative '../lib/executable'
require 'socket'
require 'pry'

class ExecutableTest < Minitest::Test

  def test_executable_class_exists
    assert Executable
  end

  # each new executable has a client
  # each has a counter
  # method(s) for looping and incrementing counters to do stuff


  def test_input_from_client_to_machine
    client_input = InputFromClient.new(:no_client, [1,2,3])
    input = client_input.to_machine
    machine = Machine.new(input)
    assert_equal [1,2,3], machine.input
  end


end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

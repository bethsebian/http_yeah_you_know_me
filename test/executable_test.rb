require 'minitest/autorun'
require_relative '../lib/executable'
require 'socket'
require 'pry'

class ExecutableTest < Minitest::Test

  def test_executable_class_exists
    assert Executable
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

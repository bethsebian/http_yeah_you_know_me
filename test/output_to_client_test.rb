require 'minitest/autorun'
require_relative '../lib/output_to_client'
require 'socket'

class OutputToClientTest < Minitest::Test

  def test_input_from_client_exists
    assert OutputToClient
  end

  def test_initializes_with_nothing_from_machine
    output = OutputToClient.new

    assert_equal [], output.from_machine
  end

  def test_initializes_with_client_server_output
    tcp_server = TCPServer.new(9292)
    output = InputFromClient.new(tcp_server)

    assert_equal tcp_server, output.client
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

require 'minitest/autorun'
require_relative '../lib/input_from_client'
require 'socket'

class InputFromClientTest < Minitest::Test

  def test_input_from_client_exists
    assert InputFromClient
  end

  def test_initializes_with_client_variable
    input = InputFromClient.new

    assert_equal :no_client, input.client
  end

  def test_initializes_with_empty_to_machine
    input = InputFromClient.new

    assert_equal [], input.to_machine
  end

  def test_initializes_with_client_server_input
    tcp_server = TCPServer.new(9292)
    input = InputFromClient.new(tcp_server)

    assert_equal tcp_server, input.client
  end

  def test_responds_to_read_request
    input = InputFromClient.new
    assert input.respond_to?(:read_request)
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

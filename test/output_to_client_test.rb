require 'minitest/autorun'
require_relative '../lib/output_to_client'
require 'socket'

class OutputToClientTest < Minitest::Test

  def test_input_from_client_exists
    assert OutputToClient
  end

  def test_initializes_with_no_client
    writer = OutputToClient.new

    assert_equal :no_client, writer.client
  end

  def test_responds_to_write_request
    output = OutputToClient.new
    assert output.respond_to?(:write_request_to_browser)
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

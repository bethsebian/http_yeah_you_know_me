require 'minitest/autorun'
require_relative '../lib/machine'
require 'socket'

class MachineTest < Minitest::Test

  def test_input_from_client_exists
    assert Machine
  end

  def test_initializes_with_input_and_output_empty
    machine = Machine.new
    assert_equal [], machine.input
    assert_equal [], machine.output
  end

  def test_can_initialize_with_inputs_and_outputs
    machine = Machine.new([1,2,3],["h","e"])

    assert_equal [1,2,3], machine.input
    assert_equal ["h","e"], machine.output
  end


  def test_responds_to_process_request
    machine = Machine.new

    assert machine.respond_to?(:process_request)
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

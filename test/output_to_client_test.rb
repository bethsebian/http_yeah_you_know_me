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

  def test_it_redirects_when_status_code_is_303
  end
  

end


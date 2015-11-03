require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'

class Executable

  attr_accessor :client, :counter, :tcp_server, :hello_counter

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @client = tcp_server.accept
    @counter = 0
    @hello_counter = 0
  end

  def input_from_client
    client_input = InputFromClient.new(client)
    client_input.read_request
    client_input.to_machine
  end

  def output_response_to_client(output)
    client_friendly_output = OutputToClient.new(output,client)
    client_friendly_output.write_request_to_browser
  end

  def process_single_request
    input = input_from_client
    m = Machine.new
    output = m.process_request(input,counter,hello_counter)
    output_response_to_client(output)
  end

  def process_many_requests
    loop do
      process_single_request
      @counter += 1
      # will need to add parser.path to trigger shutdown
    end
    client.close
  end
end

if __FILE__ == $0
  executor = Executable.new(9292)
  executor.process_many_requests
end

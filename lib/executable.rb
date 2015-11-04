require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'
require_relative 'parser'

class Executable

  attr_accessor :client, :counter, :tcp_server, :hello_counter

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @client = tcp_server.accept
    @counter = 1
    @hello_counter = 1
  end

  def input_from_client
    client_input = InputFromClient.new(client)
    client_input.read_request
    client_input.to_machine
  end

  def output_response_to_client(output)
    client_friendly_output = OutputToClient.new(client)
    client_friendly_output.write_request_to_browser(output)
  end

  def process_many_requests
    loop do
      to_machine = input_from_client
      parse = Parser.new(to_machine)
      m = Machine.new(parse)
      output = m.process_request(counter,hello_counter)
      output_response_to_client(output)

      if parse.path == "/hello"
        @hello_counter += 1
      elsif parse.path == "/shutdown"
        break
      end
      @counter += 1

    end
    client.close
  end
end

if __FILE__ == $0
  executor = Executable.new(9292)
  executor.process_many_requests
end

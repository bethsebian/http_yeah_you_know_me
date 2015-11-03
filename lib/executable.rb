require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'



class Executable

  attr_accessor :client, :counter, :tcp_server

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @client = tcp_server.accept
    @counter = 0
  end

  def input_from_client
    client_input = InputFromClient.new(client)
    client_input.read_request
    client_input.to_machine
  end

  def prepare_response(input, counter = @counter)
    machine = Machine.new(counter, input)
    machine.process_request
    machine.output
  end

  def output_response_to_client(output)
    client_friendly_output = OutputToClient.new(output,client)
    client_friendly_output.write_request_to_browser
  end

  def looper

    loop do
      self.counter += 1
      input = input_from_client
      output = prepare_response(input)
      output_response_to_client(output)
    end
    client.close
  end

end

if __FILE__ == $0
  executor = Executable.new(9292)
  executor.looper
end



# if __FILE__ == $0
#   tcp_server = TCPServer.new(9292)
#   client = tcp_server.accept
#   counter = 0
#
#   loop do
#     counter += 1
#     client_input = InputFromClient.new(client)
#     client_input.read_request
#     to_machine = client_input.to_machine
#     machine = Machine.new(to_machine)
#     machine.process_request
#     from_machine = machine.output
#     client_friendly_output = OutputToClient.new(from_machine,client)
#     client_friendly_output.write_request_to_browser
#   end
#
#   client.close
# end

require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'iteration_0'
require_relative 'prep_iter_0'

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

  def output_response_to_client(output)
    client_friendly_output = OutputToClient.new(output,client)
    client_friendly_output.write_request_to_browser
  end

  def prepare_iteration_0(counter = @counter)
    PrepIter0.new(counter).output
  end

  # def iterations
  #   {0 => lambda{ |counter| PrepIter0.new(counter).output} }
  # end
  #
  # def prepare_iteration_x(num, count = @counter)
  #   iterations[num][count]
  # end

  def iteration_0
    loop do
      self.counter += 1
      input = input_from_client
      output = prepare_iteration_0(counter)
      output_response_to_client(output)
    end
    client.close
  end

  def prepare_iteration_1(counter = @counter)
    machine = Iteration_0.new(counter)
    machine.process_request
    machine.output
  end

  def iteration_1
    loop do
      self.counter += 1
      input = input_from_client
      output = prepare_iteration_0(counter)
      output_response_to_client(output)
    end
    client.close
  end

end

if __FILE__ == $0
  executor = Executable.new(9292)
  executor.iteration_0
end

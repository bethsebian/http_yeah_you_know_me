require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'
require_relative 'parser'

class Server
  attr_accessor :client, :counter, :tcp_server, :hello_counter, :game_running, :guess, :guess_verdict, :magic_number

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @counter = 1
    @hello_counter = 1
    @game_running = false
    @game_correct_answer = nil
    @game_guess = nil
    @game_guess_counter = 0
  end

  def accept_client
    @client = tcp_server.accept
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

  def update_executable_variables(parse)
    case parse.path

      when "/hello"
        @hello_counter += 1

      when "/start_game"
        if parse.verb == "POST"
          @game_running = true
          @magic_number = rand(100)
        end

      when "/game"
        if parse.verb == "POST"
          @guess = parse.guess
        # elsif parse.verb == "GET"
        #
        end
      end

    @counter += 1
  end

  # def guess_verdict
  #   verdict = @guess <=> @magic_number
  # end

  def process_many_requests
    loop do
      input = input_from_client

      parsed_input = Parser.new(input)
      machine = Machine.new(parsed_input,@magic_number,@game_running)
      output = machine.process_request(counter,hello_counter)
      output_response_to_client(output)

      update_executable_variables(parsed_input)

      if parsed_input.path == "/shutdown"
        break
      end

    end
    client.close
  end


end

if __FILE__ == $0
  executor = Server.new(9292)
  executor.accept_client
  executor.process_many_requests
end

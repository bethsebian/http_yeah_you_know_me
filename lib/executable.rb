require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'
require_relative 'parser'
require_relative 'catch_all'

class Server
  attr_accessor :client, :counter, :tcp_server, :hello_counter, :game_running, :guess, :guess_verdict, :magic_number, :game_guess_counter

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @counter = 1
    @hello_counter = 1
    @game_running = false
    @magic_number = nil
    @guess = nil
    @game_guess_counter = 0
    @status_code = 000
    @catch_all = CatchAll.new(counter,hello_counter)
  end

  def accept_client
    @client = tcp_server.accept
  end

  def input_from_client
    client_input = InputFromClient.new(client)
    client_input.read_request
    client_input.to_machine
  end

  def output_response_to_client(output,status_code = nil)
    client_friendly_output = OutputToClient.new(client)
    client_friendly_output.write_request_to_browser(output, status_code)
  end

  def update_executable_variables(parse)
    puts "update_executable_variables running"
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
          @guess = parse.word_param_entry
          @game_guess_counter += 1
          @status_code = 303
        elsif parse.verb == "GET"
          @game_running = false if parse.word_param_entry == @magic_number
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
        machine = Machine.new(parsed_input,@catch_all,@magic_number,@game_running,@game_guess_counter)
        output = machine.process_request(counter,hello_counter)

        update_executable_variables(parsed_input)

        output_response_to_client(output,@status_code)

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

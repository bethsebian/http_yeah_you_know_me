require_relative 'game'
require_relative 'catch_all'
require_relative 'word'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'parser'
require 'socket'
require 'pry'

class ServerExec

  attr_reader :word, :catch_all, :game, :client, :status_code, :tcp_server
  attr_accessor :counter

  def initialize(tcp_server = nil)
    @tcp_server = tcp_server
    @counter = 0
    @word = Word.new
    @catch_all = CatchAll.new(counter)
    @game = Game.new
  end

  def accept_client
    @client = tcp_server.accept
  end

  def input_from_client
    client_input = InputFromClient.new(client)
    client_input.read_request
  end

  def assign(parse)
    self.counter += 1
    case parse.path
      when "/word_search" then word.process(parse)
      when "/start_game"  then game.process(parse)
      when "/game"        then game.process(parse)
      else catch_all.process(parse,counter)
    end
  end

  def output_response_to_client(output,status_code = nil)
    client_friendly_output = OutputToClient.new(client)
    client_friendly_output.write_request_to_browser(output, status_code)
  end

  def process_many_requests
    loop do
      accept_client
      input = input_from_client
      parsed_input = Parser.new(input)
      output = assign(parsed_input)
      output_response_to_client(output,game.status_code)
      client.close
      if parsed_input.path == "/shutdown"
        break
      end
    end

  end
end


if __FILE__ == $0
  tcp_server = TCPServer.new(9292)
  server = ServerExec.new(tcp_server)
  # server.accept_client
  server.process_many_requests
end

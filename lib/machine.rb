require 'pry'
require_relative 'executable'
require_relative 'responses'

class Machine
  include Responses

  attr_reader :parser, :game, :guess_verdict, :guess
  attr_accessor :magic_number, :game_running

  def initialize(parse,magic_number = nil,game_running=false, game_guess_counter = 0)
    @parser = parse
    @game_running = game_running
    @guess = parse.guess
    @magic_number = magic_number
    @game_guess_counter = game_guess_counter
  end

  def game_results
    verdict = @guess <=> @magic_number
    case verdict
    when -1 then ["too low"]
    when 0  then ["correct"]
    when 1  then ["too high"]
    end
  end



  def process_request(counter,hello_counter)
    output = [""]
    case @parser.path
    when "/hello"       then output = Responses.hello(hello_counter)
    when "/datetime"    then output = Responses.datetime
    when "/shutdown"    then output = Responses.shutdown(counter)
    when "/word_search" then output = Responses.word_search(@parser.word_param_entry)

    when "/start_game"
      if @parser.verb == "POST"              # TO DO: define a number to measure against
        ["Good Luck"]
      else
        ["No game started"]
      end
    when "/game"
      if @parser.verb == "GET" && @game_running
          game_results + ["Total guesses: #{game_guess_counter}"]
      elsif @parser.verb == "POST" && @game_running
        # execute redirect back to get game
          # TO DO: define method for looping back to process_request with new input
      else
        ["Not in game!"]
      end
    else

    end
    output += ["\n\n\n"] + Responses.root(@parser.diagnostics)

  end
end

# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>

# Verb: @input[0].split[0]
# Path: / @input[0].split[1]
# Protocol: HTTP/1.1    @input[0].split[2]
# Host: 127.0.0.1   @input[1].split(":")[1].strip
# Port: 9292 @input[1].split(":")[2].strip
# Origin: 127.0.0.1   @input[1].split(":")[1].strip
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8 @input[3]
# </pre>
#

# need 404 if unknown path entered

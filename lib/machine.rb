require 'pry'
require_relative 'executable'

class Machine

  def dictionary
    ["hello", "pizza", "tired"]
  end

  attr_reader :parser, :game

  def initialize(parse)
    @parser = parse
    @game = false
  end

  def process_request(counter,hello_counter)
    case @parser.path
      when "/"
        ["Verb: #{parser.verb}"] + ["Path: #{parser.path}"] + ["Protocol: #{parser.protocol}"] + ["Host: #{parser.host}"] + ["Port: #{parser.port}"] + ["Origin: #{parser.origin}"] + ["Accept: #{parser.accept}"]
      when "/hello"
        ["Hello"] +[" World! (#{hello_counter})"]
      when "/datetime"
        [Time.now.strftime("%l:%M %p on %A, %B %d, %Y")]
      when "/shutdown"
        ["shutdown","Total Requests: #{counter}"]
      when "/word_search"
        if dictionary.include?(@parser.word_param_entry)
          ["word is a known word"]
        else
          ["word is not a known word"]
        end
      when "/start_game"
        if @parser.verb == "POST"
          @game = true
          ["Good Luck"]
        else
          ["No game started"]
        end
        # starts game too
      when "/game"
          if @parser.verb == "GET" && game
            # how many guesses have been taken
            # for each guess, too high, too low, correct
          elsif @parser.verb == "POST" && game
            # if @parser.guess == true 
            #   @parser.guess_value gets saved
            #   execute redirect


            # request includes parameter named guess
            # sends user redirect response
          else
            ["Not in game!"]
          end
      else

    end
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

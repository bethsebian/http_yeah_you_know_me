require_relative 'responses'


class Game
  include Responses

  attr_accessor :game_guess_counter, :guess, :magic_number, :game_running

  def initialize(guess = nil, magic_number = nil,game_running = false)
    @game_guess_counter = 0
    @game_running = game_running
    @guess = guess
    @magic_number = magic_number
  end


  def game_results
    verdict = (self.guess <=> self.magic_number)
    case verdict
      when -1 then ["too low"]
      when 0  then ["Correct!!! Play again... now."]
      when 1  then ["too high"]
    end
  end

  def process(parse)

    case parse.path
      when "/start_game"

        if parse.verb == "POST"
          self.magic_number = rand(10)
          self.game_running = true
          ["Good Luck"]
        else
          ["Game has not started, try POST request"]
        end

      when "/game"
        if parse.verb == "GET" && game_running
          self.game_guess_counter +=1
          self.game_running = false if game_results == ["Correct!!! Play again... now."]
          game_results + ["Total guesses: #{game_guess_counter}"]
        elsif parse.verb == "POST" && game_running
          self.guess = parse.word_param_entry.to_i
          ["Good guess! Let's see..."]
        else
          ["Start a game first!"]
        end

      else
        [""]
    end
  end


end

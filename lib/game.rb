require_relative 'responses'


class Game
  include Responses

  attr_accessor :game_guess_counter, :guess, :magic_number, :game_running, :status_code

  def initialize(guess = nil, magic_number = nil,game_running = false)
    @game_guess_counter = 0
    @game_running = game_running
    @guess = guess
    @magic_number = magic_number
    @status_code = 000
  end


  def game_results
    verdict = (self.guess <=> self.magic_number)
    case verdict
      when -1 then ["too low"]
      when 0  then ["Correct!!! Play again... now."]
      when 1  then ["too high"]
    end
  end


  def process_start_game(parse)
    if parse.verb == "POST"
      self.magic_number = rand(10)
      self.game_running = true
      ["Good Luck"]
    else
      ["Game has not started, try POST request"]
    end
  end


  def process_game_get_and_post(parse)
    if parse.verb == "GET" && game_running
      self.game_guess_counter += 1
      temp = game_results
      if game_results == ["Correct!!! Play again... now."]
        self.game_running = false
        self.game_guess_counter = 0
        self.guess = nil
      end
      self.status_code = 000
      temp + ["Total guesses: #{game_guess_counter}"]
    elsif parse.verb == "POST" && game_running
      self.guess = parse.word_param_entry.to_i
      self.status_code = 302
      ["Good guess! Let's see..."]
    else
      ["Start a game first!"]
    end
  end


  def process(parse)
    output = case parse.path
      when "/start_game"
        process_start_game(parse)
      when "/game"
        process_game_get_and_post(parse)
      else
        [""]
    end
    output + ["\n\n\n"] + parse.diagnostics
  end


end

require_relative 'game'
require_relative 'catch_all'
require_relative 'word'


class Server_Exec

  attr_reader :word, :catch_all, :game
  attr_accessor :counter

  def initialize
    @counter = 0
    @word = Word.new
    @catch_all = CatchAll.new(counter,0)
    @game = Game.new
  end

  def assign(parse)

    case parse.path
      when "/word_search"
        word.process(parse)
      when "/game_start"
        game.process(parse)
      when "/game"
        game.process(parse)
      else
        catch_all.process(parse)
    end

    self.counter += 1

  end


end

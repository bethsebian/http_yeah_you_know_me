require_relative 'game'
require_relative 'catch_all'
require_relative 'word'
require 'pry'

class ServerExec

  attr_reader :word, :catch_all, :game
  attr_accessor :counter

  def initialize
    @counter = 0
    @word = Word.new
    @catch_all = CatchAll.new(counter,0)
    @game = Game.new
  end

  def assign(parse)

    # self.counter += 1

    case parse.path
      when "/word_search"
        word.process(parse)
      when "/start_game"
        game.process(parse)
      when "/game"
        game.process(parse)
      else
        catch_all.process(parse)
    end


  end


end

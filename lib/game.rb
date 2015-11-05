require_relative 'responses'


class Game
  include Responses

  attr_accessor :game_guess_counter, :guess, :magic_number, :game_running

  def initialize
    @game_guess_counter = 0
    @game_running = false
  end





end

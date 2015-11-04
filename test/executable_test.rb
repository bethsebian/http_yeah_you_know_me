require 'minitest/autorun'
require_relative '../lib/executable'
require 'socket'
require 'pry'

class ExecutableTest < Minitest::Test

  def test_executable_class_exists
    assert Executable
  end

  def test_updates_counter_when_update_called
    # executor = Executable.new
  end

  def test_a_new_game_begins_with_a_number_the_player_doesnt_know
    skip
  end

  def test_guess_is_stored
    skip
  end

  def test_guess_larger_than_game_number_returns_too_high
    skip
  end

  def test_guess_smaller_than_game_number_returns_too_low
    skip
  end

  def test_guess_thats_same_as_game_number_returns_correct
    skip
  end

  def test_game_sends_player_back_to_verb_get_and_path_game_when_guess_is_made
    skip
  end

  def test_guesses_are_counted
    skip
  end

end

# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted

# in executable we write tcp_server = TCPServer.new(9292)
# input = InputFromClient.new(tcp_server)
# input.client = tcp_server.accept

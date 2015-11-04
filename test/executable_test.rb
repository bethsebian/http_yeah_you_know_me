require 'minitest/autorun'
require_relative '../lib/executable'
require 'socket'
require 'pry'

class ExecutableTest < Minitest::Test

  def input(path = "/", verb = "GET")
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive"]
  end

  def test_executable_class_exists
    assert Executable
  end

  def test_updates_counter_when_update_called
    executor = Executable.new(9292)
    parse = Parser.new(input)

    assert_equal 1, executor.counter

    executor.update_executable_variables(parse)

    assert_equal 2, executor.counter

    executor.tcp_server.close
  end

  def test_updates_hello_counter_when_update_called
    executor = Executable.new(9292)
    parse = Parser.new(input("/hello"))

    assert_equal 1, executor.hello_counter

    executor.update_executable_variables(parse)

    assert_equal 2, executor.hello_counter

    executor.tcp_server.close
  end

  def test_doesnt_update_hello_counter_when_update_called_wrong_path
    executor = Executable.new(9292)
    parse = Parser.new(input("/"))

    assert_equal 1, executor.hello_counter

    executor.update_executable_variables(parse)

    assert_equal 1, executor.hello_counter

    executor.tcp_server.close
  end

  def test_game_running_defaults_to_false
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

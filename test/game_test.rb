require 'minitest/autorun'
require_relative '../lib/machine'
require_relative '../lib/parser'
require_relative '../lib/game'
require 'pry'

class GameTest < Minitest::Test

  def input(path = "/", verb = "GET")
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive"]
  end


  def diagnostics_tester(path = "/shutdown")
    ["\n\n\n"] + ["Verb: GET", "Path: #{path}", "Protocol: HTTP/1.1", "Host: 127.0.0.1:9292", "Port: 9292", "Origin: 127.0.0.1", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
  end

  def test_game_accurately_identifies_results
    game = Game.new(10,15)

    assert_equal ["too low"], game.game_results

    game = Game.new(15,10)

    assert_equal ["too high"], game.game_results

    game = Game.new(10,10)

    assert_equal ["correct"], game.game_results
  end

  def test_game_reads_start_script
    game = Game.new(0,0)
    parse = Parser.new(input("/start_game", "POST"))

    assert_equal ["Good Luck"], game.process(parse)
  end

  def test_game_reads_start_imperative_script
    game = Game.new(0,0)
    parse = Parser.new(input("/start_game", "GET"))

    assert_equal ["Game has not started, try POST request"], game.process(parse)
  end

  def test_game_reads_game_results_if_game_running
    game = Game.new(5,0,true)
    parse = Parser.new(input("/game?guess=9", "GET"))

    assert_equal ["too high", "Total guesses: 1"], game.process(parse)
  end

  def test_game_responds_when_guess_made
    game = Game.new(5,0,true)
    parse = Parser.new(input("/game?guess=4", "POST"))

    assert_equal ["Good guess! Let's see..."], game.process(parse)
  end

  def test_game_has_hissy_if_game_hasnt_been_started
    game = Game.new(5,0)
    parse = Parser.new(input("/game", "POST"))

    assert_equal ["Start a game first!"], game.process(parse)
  end

  def test_game_sets_magic_number_when_game_starts
    game = Game.new

    refute game.magic_number

    parse = Parser.new(input("/start_game", "POST"))
    game.process(parse)

    assert game.magic_number
  end

  def test_game_sets_guess
    game = Game.new(nil,nil,true)

    refute game.magic_number

    parse = Parser.new(input("/game?guess=9", "POST"))
    game.process(parse)

    assert_equal 9, game.guess
  end


end

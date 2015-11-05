require 'minitest/autorun'
require_relative '../lib/machine'
require_relative '../lib/parser'
require 'socket'
require 'pry'

class MachineTest < Minitest::Test

  def input(path = "/", verb = "GET", guess = nil)
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive",guess]
  end

  def diagnostics_tester(path = "/shutdown")
    ["\n\n\n"] + ["Verb: GET", "Path: #{path}", "Protocol: HTTP/1.1", "Host: 127.0.0.1:9292", "Port: 9292", "Origin: 127.0.0.1", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
  end

  def test_machine_exists
    assert Machine
  end

  def test_machine_initializes_with_parse_objects
    parse = Parser.new(input("/"))
    catcher = CatchAll.new(3,4)
    machine = Machine.new(parse,catcher)

    assert_equal parse, machine.parser
  end

  

  def test_machine_says_good_luck_when_path_start_game_and_verb_post
    skip
    parse = Parser.new(input("/start_game", "POST"))
    machine = Machine.new(parse)
    expected = ["Good Luck"]

    assert_equal expected, machine.process_request(8,7)
  end

  def test_machine_says_nothing_when_path_start_game_and_verb_not_post
    skip
    parse = Parser.new(input("/start_game", "GET"))
    machine = Machine.new(parse)
    expected = ["No game started"]

    assert_equal expected, machine.process_request(8,7)
  end

  def test_machine_starts_game_when_path_start_game_and_post
    skip
    parse = Parser.new(input("/start_game", "POST"))
    machine = Machine.new(parse)
    machine.process_request(8,8)

    assert_equal true, machine.game_running
  end

  def test_machine_does_not_start_game_when_path_is_not_start_game_and_post
    skip
    parse = Parser.new(input("/start_game", "GET"))
    machine = Machine.new(parse)
    machine.process_request(8,8)

    refute machine.game_running
  end

  def test_game_returns_too_low_when_guess_less_than_magic_number
    skip
    parse = Parser.new(input("/game", "POST",46))
    machine = Machine.new(parse)

    machine.magic_number = 50

    assert_equal 50, machine.magic_number
    assert_equal 46, machine.guess
    assert_equal "too low", machine.game_results[0]
  end

  def test_game_returns_too_high_when_guess_greater_than_magic_number
    skip
    parse = Parser.new(input("/game", "POST",46))
    machine = Machine.new(parse)

    machine.magic_number = 44

    assert_equal 44, machine.magic_number
    assert_equal 46, machine.guess
    assert_equal "too high", machine.game_results[0]
  end

  def test_game_returns_too_low_when_guess_less_than_magic_number
    skip
    parse = Parser.new(input("/game", "POST",46))
    machine = Machine.new(parse)

    machine.magic_number = 46

    assert_equal 46, machine.magic_number
    assert_equal 46, machine.guess
    assert_equal "correct", machine.game_results[0]
  end

  def test_machine_returns_results_to_guess
    skip
    parse = Parser.new(input("/game", "POST",46))
    machine = Machine.new(parse)

    machine.magic_number = 50
    machine.game_running = true

    assert_equal "too_low", machine.process_request(7,8)
  end









end

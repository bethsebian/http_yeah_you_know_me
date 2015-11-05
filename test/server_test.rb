require 'minitest/autorun'
require_relative '../lib/machine'
require_relative '../lib/parser'
require_relative '../lib/server_exec'
require 'pry'

class ServerExecTest < Minitest::Test

  def input(path = "/", verb = "GET", guess = nil)
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive",guess]
  end


  def diagnostics_tester(path = "/shutdown")
    ["\n\n\n"] + ["Verb: GET", "Path: #{path}", "Protocol: HTTP/1.1", "Host: 127.0.0.1:9292", "Port: 9292", "Origin: 127.0.0.1", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
  end

  def test_assigner_exists
    assert ServerExec
  end

  def test_initializes_with_counter_and_processing_classes
    server = ServerExec.new

    assert_equal 0, server.counter
    assert_equal Word, server.word.class
    assert_equal CatchAll, server.catch_all.class
    assert_equal Game, server.game.class
  end

  def test_assigns_client_request_to_word_when_word_search
    server = ServerExec.new
    parse = Parser.new(input("/word_search?word=piz"))

    assert_equal server.word.process(parse), server.assign(parse)
  end

  def test_assigns_client_request_to_word_when_word_search_not_word
    server = ServerExec.new
    parse = Parser.new(input("/word_search?word=pizza"))

    assert_equal server.word.process(parse), server.assign(parse)
  end

  def test_assigns_client_request_to_catch_all_when_catch_all
    server = ServerExec.new
    parse = Parser.new(input("/hello"))

    assert_equal ["Hello", " World! (1)"], server.assign(parse)
  end

  def test_assigns_client_request_to_game_when_game_start
    server = ServerExec.new
    parse = Parser.new(input("/start_game"))

    assert_equal server.game.process(parse), server.assign(parse)
  end

end

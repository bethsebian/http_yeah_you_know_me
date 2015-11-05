require 'minitest/autorun'
require_relative '../lib/parser'
require_relative '../lib/catch_all'
require 'pry'

class CatchAllTest < Minitest::Test

  def input(path = "/", verb = "GET", guess = nil)
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive",guess]
  end

  def diagnostics_tester(path = "/shutdown")
    ["\n\n\n"] + ["Verb: GET", "Path: #{path}", "Protocol: HTTP/1.1", "Host: 127.0.0.1:9292", "Port: 9292", "Origin: 127.0.0.1", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
  end

  def test_machine_returns_iteration_1_with_empty_path
    parse = Parser.new(input("/"))
    catcher = CatchAll.new

    expected = [""] + diagnostics_tester("/")

    assert_equal expected, catcher.process(parse)
  end

  def test_machine_returns_iteration_0_with_hello_path
    parse = Parser.new(input("/hello"))
    catcher = CatchAll.new(3)
    expected = ["Hello World! (4)"] + diagnostics_tester("/hello")

    assert_equal expected, catcher.process(parse)
  end

  def test_machine_returns_iteration_0_with_hello_path_different_hello_counter
    parse = Parser.new(input("/hello"))
    catcher = CatchAll.new(8)
    expected = ["Hello World! (9)"] + diagnostics_tester("/hello")

    assert_equal expected, catcher.process(parse)
  end

  def test_machine_returns_datetime_with_datetime_path
    parse = Parser.new(input("/datetime"))
    catcher = CatchAll.new
    expected = [Time.now.strftime("%l:%M %p on %A, %B %d, %Y")] + diagnostics_tester("/datetime")

    assert_equal expected, catcher.process(parse)
  end

  def test_machine_returns_shut_down_output_with_shutdown_path
    parse = Parser.new(input("/shutdown"))
    catcher = CatchAll.new
    expected = ["Total Requests: "] + diagnostics_tester("/shutdown")

    assert_equal expected, catcher.process(parse)
  end

end

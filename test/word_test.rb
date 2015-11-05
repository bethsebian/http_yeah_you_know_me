require 'minitest/autorun'
require_relative '../lib/machine'
require_relative '../lib/parser'
require_relative '../lib/word'
require 'pry'

class WordTest < Minitest::Test

  def input(path = "/", verb = "GET", guess = nil)
    ["#{verb} #{path} HTTP/1.1", "Host: 127.0.0.1:9292", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language: en-US,en;q=0.5","Accept-Encoding: gzip, deflate", "Connection: keep-alive",guess]
  end


  def diagnostics_tester(path = "/shutdown")
    ["\n\n\n"] + ["Verb: GET", "Path: #{path}", "Protocol: HTTP/1.1", "Host: 127.0.0.1:9292", "Port: 9292", "Origin: 127.0.0.1", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
  end

  def test_machine_says_word_when_its_a_word
    parse = Parser.new(input("/word_search?word=pizza"))
    word = Word.new
    machine = Machine.new(parse,nil,word)
    expected = ["word is a known word"] + diagnostics_tester("/word_search")

    assert_equal expected , machine.process_request(3,4)
  end

  def test_machine_says_not_word_when_its_not_a_word
    parse = Parser.new(input("/word_search?word=piz"))
    word = Word.new
    machine = Machine.new(parse,nil,word)
    expected = ["word is not a known word"] + diagnostics_tester("/word_search")

    assert_equal expected , machine.process_request(3,4)
  end

end

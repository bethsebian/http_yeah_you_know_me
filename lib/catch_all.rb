require_relative 'responses'
require 'pry'

class CatchAll
  include Responses

  attr_accessor :hello_counter, :counter

  def initialize(counter,hello_counter)
    @counter = counter
    @hello_counter = hello_counter
  end

  def process(parse)
    case parse.path
      when "/"            then output = [""]
      when "/hello"
        self.hello_counter += 1
        output = Responses.hello(hello_counter)
      when "/datetime"    then output = Responses.datetime
      when "/shutdown"    then output = Responses.shutdown(counter)
    end
  end

end
#

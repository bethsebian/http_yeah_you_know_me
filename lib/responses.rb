module Responses

  def self.dictionary
    ["hello", "pizza", "tired"]
  end

  def self.root(diagnostics)
    diagnostics
  end

  def self.hello(hello_counter)
    ["Hello World! (#{hello_counter})"]
  end

  def self.datetime
    [Time.now.strftime("%l:%M %p on %A, %B %d, %Y")]
  end

  def self.shutdown(counter)
    ["Total Requests: #{counter}"]
  end

  def self.word_search(word)
    if dictionary.include?(word)
      ["word is a known word"]
    else
      ["word is not a known word"]
    end
  end
end

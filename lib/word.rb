require_relative 'responses'


class Word
  include Responses

  def process(parse)
    Responses.word_search(parse.word_param_entry)
  end

end

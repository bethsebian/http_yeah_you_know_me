require_relative 'responses'

class Word
  include Responses

  def process(parse)
    output = Responses.word_search(parse.word_param_entry)
    output + ["\n\n\n"] + parse.diagnostics
  end

end

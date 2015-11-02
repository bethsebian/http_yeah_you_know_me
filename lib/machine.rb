class Machine

  attr_reader :input, :output

  def initialize(input = [], output = [])
    @input = input
    @output = output
  end


  def process_request
    # starts with @input, does a bunch of stuff
    # finishes with @output = transformed input
  end

end

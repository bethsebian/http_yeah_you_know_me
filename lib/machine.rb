class Machine

  attr_reader :input, :output

  def initialize(input = [], output = [])
    @input = input
    @output = output
  end


  def process_request
    @output = input
  end

end

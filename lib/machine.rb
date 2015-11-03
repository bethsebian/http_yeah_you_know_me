class Machine

  attr_accessor :input, :output

  def initialize(input = [], output = [])
    @input = input
    @output = output
    @counter = 0
  end


  def process_request
    @counter +=1
    @output = input + [@counter]
  end

end

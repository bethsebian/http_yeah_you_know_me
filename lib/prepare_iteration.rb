require_relative 'executable'

class PrepareIteration

  def iterations(counter,input, hello_counter = nil)
    { 0=> Iteration_0.new(hello_counter) ,
      1=> Iteration_1.new(input),
      2=> Iteration_2.new(counter,input),
      3=> nil,
      4=> nil,
      5=> nil}

  end

  def initialize(num, counter, input, hello_counter = nil)
    @iteration = iterations(counter,input)[num]
  end

  def iteration_prep
    @iteration.process_request
    @iteration.output
  end


end

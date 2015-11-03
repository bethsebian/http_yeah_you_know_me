require_relative 'executable'

class PrepIter0

  attr_reader :machine, :output

  def initialize(counter)
    @machine = Iteration_0.new(counter)
    machine.process_request
    @output = machine.output
  end

end

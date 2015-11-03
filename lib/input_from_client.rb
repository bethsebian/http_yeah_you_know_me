require 'pry'

class InputFromClient
  attr_accessor :client, :to_machine

  def initialize(client=:no_client, to_machine = [])
    @client = client
    @to_machine = to_machine
  end

  def read_request
    while line = client.gets and !line.chomp.empty?
      @to_machine << line.chomp
    end
  end

end

class Parser




end

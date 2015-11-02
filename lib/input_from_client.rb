require 'pry'

class InputFromClient
  attr_reader :client, :to_machine

  def initialize(client=:no_client)
    @client = client
    @to_machine = []
  end

  def read_request
    while line = client.gets and !line.chomp.empty?
      @to_machine << line.chomp
    end
  end

end

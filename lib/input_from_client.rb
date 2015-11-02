require 'pry'

class InputFromClient
  attr_reader :client, :to_machine

  def initialize(client=:no_client)
    @client = client
    @to_machine = []
  end

  def read_request
    channel = client.accept
    while line = channel.gets and !line.chomp.empty?
      @to_machine << line.chomp
    end
    channel.close
  end

end

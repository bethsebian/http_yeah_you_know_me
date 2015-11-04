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
  attr_reader :to_machine

  def initialize(to_machine)
    @to_machine = to_machine
  end

  def path
    to_machine[0].split[1]
  end

  def verb
    to_machine[0].split[0]
  end

  def protocol
    to_machine[0].split[2]
  end

  def host
    to_machine[1].split(":")[1].strip
  end

  def port
    to_machine[1].split(":")[2].strip
  end

  def origin
    to_machine[1].split(":")[1].strip
  end

  def accept
    to_machine[3]
  end

end

class InputFromClient
  attr_reader :client, :to_machine

  def initialize(tcp_server=:no_client)
    @client = tcp_server
    @to_machine = []
  end

  def accept_request
    client.accept
  end

  def read_request
    channel = accept_request
    while line = channel.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    @to_machine = request_lines
  end


end

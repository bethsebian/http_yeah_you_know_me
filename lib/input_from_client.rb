class InputFromClient
  def initialize(tcp_server=:no_client)
    @client = tcp_server
  end

  def client
    @client
  end
end
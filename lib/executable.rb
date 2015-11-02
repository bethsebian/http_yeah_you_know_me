require 'socket'
require 'pry'
require_relative 'input_from_client'
require_relative 'output_to_client'
require_relative 'machine'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept

client_input = InputFromClient.new(client)

client_input.read_request

to_machine = client_input.to_machine

machine = Machine.new(to_machine)
machine.process_request
from_machine = machine.output
client_friendly_output = OutputToClient.new(from_machine,client)
client_friendly_output.write_request_to_browser
client.close

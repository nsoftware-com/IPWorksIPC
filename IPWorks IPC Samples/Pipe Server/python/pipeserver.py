# 
# IPWorks IPC 2024 Python Edition - Sample Project
# 
# This sample project demonstrates the usage of IPWorks IPC in a 
# simple, straightforward way. It is not intended to be a complete 
# application. Error handling and other checks are simplified for clarity.
# 
# www.nsoftware.com/ipworksipc
# 
# This code is subject to the terms and conditions specified in the 
# corresponding product license agreement which outlines the authorized 
# usage and restrictions.
# 

import sys
import string
from ipworksipc import *

input = sys.hexversion<0x03000000 and raw_input or input

def ensureArg(args, prompt, index):
  if len(args) <= index:
    while len(args) <= index:
      args.append(None)
    args[index] = input(prompt)
  elif args[index] is None:
    args[index] = input(prompt)



def fireConnected(e):
  print("PipeClient " + str(pipeserver.get_connection_id(e.connection_id)) + " has connected.")

def fireDataIn(e):
  print("Echoing '" + bytes.decode(e.text) + "' back to client.")
  pipeserver.send_text(e.connection_id, bytes.decode(e.text))

def fireDisconnected(e):
  print("PipeClient " + str(pipeserver.get_connection_id(e.connection_id)) + " has disconnected.")

def fireError(e):
  print(e.description)

def fireReadyToSend(e):
  print("PipeClient " + str(pipeserver.get_connection_id(e.connection_id)) + " is ready to send.")

pipeserver = PipeServer()
pipeserver.on_connected = fireConnected
pipeserver.on_data_in = fireDataIn
pipeserver.on_disconnected = fireDisconnected
pipeserver.on_error = fireError
pipeserver.on_ready_to_send = fireReadyToSend

print("*****************************************************************")
print("* This demo shows how to use the PipeServer component to accept *")
print("* connections from a PipeClient.                                *")
print("*****************************************************************")
try:
  servername = input("Pipe Name (MyPipeServer): ")
  if servername == "":
    servername = "MyPipeServer"
  pipeserver.set_pipe_name(servername)

  pipeserver.start_listening()
  print(servername + " listening... press Ctrl-C to shutdown.")

  while True:
    pipeserver.do_events()

except IPWorksIPCError as e:
  print("ERROR %s" %e.message)

except KeyboardInterrupt:
  print("Exiting...")
  pipeserver.shutdown()



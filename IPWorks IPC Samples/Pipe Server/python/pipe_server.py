# 
# IPWorks IPC 2022 Python Edition - Sample Project
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
  elif args[index] == None:
    args[index] = input(prompt)


def fireConnected(e):
  print("PipeClient %s has connected.\r\n "%str(pipeserver.get_connection_id(0)))

def fireDataIn(e):
  print("Echoing '%s' back to client.\r\n"%e.text.decode("utf-8"))
  pipeserver.set_data_to_send(int(pipeserver.get_connection_id(0)),e.text)

def fireDisconnected(e):
  print("PipeClient %s has disconnected.\r\n "%str(pipeserver.get_connection_id(0)))

def fireError(e):
  print(e.description)

def fireReadyToSend(e):
  print("Client %s is ready to send"%str(pipeserver.get_connection_id(0)))

pipeserver = PipeServer()
pipeserver.on_connected = fireConnected
pipeserver.on_data_in = fireDataIn
pipeserver.on_disconnected = fireDisconnected
pipeserver.on_error = fireError
pipeserver.on_ready_to_send = fireReadyToSend

print("*****************************************************************\n")
print("* This demo shows how to use the PipeServer component to accept *\n")
print("* connections from a PipeClient.                                *\n")
print("*****************************************************************\n")
try:
  servername = input("Pipe Name: ")
  if servername == "":
    servername = "MyPipeServer"
  pipeserver.set_pipe_name(servername)

  pipeserver.listening = True
  print(servername + " Listening")

  while pipeserver.listening:
    pipeserver.do_events()
except IPWorksIPCError as e:
  print("ERROR %s" %e.message)


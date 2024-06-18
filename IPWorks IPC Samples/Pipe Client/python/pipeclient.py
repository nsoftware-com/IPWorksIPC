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



global dataInReceived

def fireConnected(e):
  print("Connected")

def fireDataIn(e):
  print("Received '" + bytes.decode(e.text) + "' from Pipe Server.")
  global dataInReceived
  dataInReceived = True

def fireDisconnected(e):
  print("Disconnected")

def fireError(e):
  print(e.description)

pipeclient = PipeClient()
pipeclient.on_connected = fireConnected
pipeclient.on_data_in = fireDataIn
pipeclient.on_disconnected = fireDisconnected
pipeclient.on_error = fireError

print("*****************************************************************")
print("* This is a demo to show hot to use the PipeClient component to *")
print("* connect to a PipeServer and receive the echoed response.      *")
print("*****************************************************************")

try:
  servername = input("Pipe Name (MyPipeServer): ")
  if servername == "":
    servername = "MyPipeServer"
  pipeclient.pipe_name = servername

  pipeclient.connect()
  if not pipeclient.get_connected():
    print("Error connecting")
    sys.exit()
  print("Type and press enter to send. Press Ctrl-C to exit the application.\n")
  while True:
    dataInReceived = False
    data = input("")
    if (len(data) > 0):
      pipeclient.send_text(data)
      # Wait for response
      while not dataInReceived:
        pipeclient.do_events()

except IPWorksIPCError as e:
  print("ERROR %s" %e.message)

except KeyboardInterrupt:
  print("Exiting...")
  pipeclient.disconnect()






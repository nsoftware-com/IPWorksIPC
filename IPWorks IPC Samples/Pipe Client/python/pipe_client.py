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


global dataInReceived

def fireConnected(e):
  print("Connected")

def fireDataIn(e):
  print("Received %s from Pipe Server.\r\n"%e.text.decode("utf-8"))
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

print("*****************************************************************\n")
print("* This is a demo to show hot to use the PipeClient component to *\n")
print("* connect to a PipeServer and receive the echoed response.      *\n")
print("*****************************************************************\n")

try:
  servername = input("Pipe Name: ")
  if servername == "":
    servername = "MyPipeServer"
  pipeclient.set_pipe_name(servername)

  pipeclient.connect()
  if not pipeclient.get_connected():
    print("Error connecting")
    sys.exit()
  while True:
    dataInReceived = False
    cmd = input("\nPlease input command: \r\n- 1 Send Data \r\n- 2 Exit \r\n")
    if cmd == "1":
      data = input("Please enter data to send: ")
      pipeclient.data_to_send = data
      print("Waiting for response...\n")
      while not dataInReceived:
        pipeclient.do_events()
    elif cmd == "2":
      break
    else:
      print("Command not recognized\n")
except IPWorksIPCError as e:
  print("ERROR %s" %e.message)







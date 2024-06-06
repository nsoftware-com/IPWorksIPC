/*
 * IPWorks IPC 2024 .NET Edition - Sample Project
 *
 * This sample project demonstrates the usage of IPWorks IPC in a 
 * simple, straightforward way. It is not intended to be a complete 
 * application. Error handling and other checks are simplified for clarity.
 *
 * www.nsoftware.com/ipworksipc
 *
 * This code is subject to the terms and conditions specified in the 
 * corresponding product license agreement which outlines the authorized 
 * usage and restrictions.
 * 
 */

﻿using System;
using nsoftware.IPWorksIPC;

class PipeServerSampleProject
{
  // Define a private static variable for the PipeServer
  private static PipeServer pipeServer;

  // The main method is async to support non-blocking operations
  static void Main()
  {
    // Initialize the pipeServer
    pipeServer = new PipeServer();

    // Subscribe to events using custom methods defined below
    pipeServer.OnConnected += FireConnected;
    pipeServer.OnDataIn += FireDataIn;
    pipeServer.OnDisconnected += FireDisconnected;
    pipeServer.OnError += FireError;
    pipeServer.OnReadyToSend += FireReadyToSend;

    // Print basic information about the demo
    Console.WriteLine("*****************************************************************");
    Console.WriteLine("* This demo shows how to use the PipeServer component to accept *");
    Console.WriteLine("* connections from a PipeClient.                                *");
    Console.WriteLine("*****************************************************************");

    try
    {
      // Prompt for the pipe name with a default value
      Console.Write("Pipe Name [MyPipeServer]: ");
      var serverName = Console.ReadLine();
      pipeServer.PipeName = string.IsNullOrEmpty(serverName) ? "MyPipeServer" : serverName;

      // Begin listening for connections
      pipeServer.StartListening();

      Console.WriteLine($"{pipeServer.PipeName} Listening");

      // Continuously process events until the server stops listening
      while (pipeServer.Listening)
      {
        pipeServer.DoEvents();
      }
    }
    // Catch and handle any exceptions thrown by the IPWorksIPC library
    catch (IPWorksIPCException ex)
    {
      Console.WriteLine($"ERROR {ex.Message}");
    }
  }

  // Event handler for when a client connects
  private static void FireConnected(object s, PipeServerConnectedEventArgs e)
  {
    Console.WriteLine($"PipeClient {e.ConnectionId} has connected.\r\n");
  }

  // Event handler for when data is received
  private static void FireDataIn(object s, PipeServerDataInEventArgs e)
  {
    var data = e.Text;
    Console.WriteLine($"Echoing '{data}' back to client.\r\n");

    // Echo the received data back to the client
    pipeServer.SendLine(e.ConnectionId, e.Text);
  }

  // Event handler for when a client disconnects
  private static void FireDisconnected(object s, PipeServerDisconnectedEventArgs e)
  {
    Console.WriteLine($"PipeClient {e.ConnectionId} has disconnected.\r\n");
  }

  // Event handler for when an error occurs
  private static void FireError(object s, PipeServerErrorEventArgs e)
  {
    Console.WriteLine(e.Description);
  }

  // Event handler for when a client is ready to send data
  private static void FireReadyToSend(object s, PipeServerReadyToSendEventArgs e)
  {
    Console.WriteLine($"Client {e.ConnectionId} is ready to send");
  }
}




class ConsoleDemo
{
  /// <summary>
  /// Takes a list of switch arguments or name-value arguments and turns it into a dictionary.
  /// </summary>
  public static System.Collections.Generic.Dictionary<string, string> ParseArgs(string[] args)
  {
    System.Collections.Generic.Dictionary<string, string> dict = new System.Collections.Generic.Dictionary<string, string>();

    for (int i = 0; i < args.Length; i++)
    {
      // Add an key to the dictionary for each argument
      if (args[i].StartsWith("/"))
      {
        // If the next argument does NOT start with a "/" then it is a value.
        if (i + 1 < args.Length && !args[i + 1].StartsWith("/"))
        {
          // Save the value and skip the next entry in the list of arguments.
          dict.Add(args[i].ToLower().TrimStart('/'), args[i + 1]);
          i++;
        }
        else
        {
          // If the next argument starts with a "/", then we assume the current one is a switch.
          dict.Add(args[i].ToLower().TrimStart('/'), "");
        }
      }
      else
      {
        // If the argument does not start with a "/", store the argument based on the index.
        dict.Add(i.ToString(), args[i].ToLower());
      }
    }
    return dict;
  }
  /// <summary>
  /// Asks for user input interactively and returns the string response.
  /// </summary>
  public static string Prompt(string prompt, string defaultVal)
  {
    Console.Write(prompt + (defaultVal.Length > 0 ? " [" + defaultVal + "]": "") + ": ");
    string val = Console.ReadLine();
    if (val.Length == 0) val = defaultVal;
    return val;
  }
}
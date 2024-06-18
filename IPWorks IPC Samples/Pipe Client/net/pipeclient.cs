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

class Program
{
  private static PipeClient pipeclient = new PipeClient();
  private static bool dataInReceived = false;

  static void Main(string[] args)
  {
    Console.WriteLine("*****************************************************************\n");
    Console.WriteLine("* This is a demo to show how to use the PipeClient component to *\n");
    Console.WriteLine("* connect to a PipeServer and receive the echoed response.      *\n");
    Console.WriteLine("*****************************************************************\n");

    pipeclient.OnConnected += FireConnected;
    pipeclient.OnDataIn += FireDataIn;
    pipeclient.OnDisconnected += FireDisconnected;
    pipeclient.OnError += FireError;

    try
    {
      Console.Write("Pipe Name: ");
      string servername = Console.ReadLine();
      if (string.IsNullOrWhiteSpace(servername))
        servername = "MyPipeServer";
      pipeclient.PipeName = servername;

      pipeclient.Connect();
      if (!pipeclient.Connected)
      {
        Console.WriteLine("Error connecting");
        Environment.Exit(0);
      }
      while (true)
      {
        dataInReceived = false;
        Console.WriteLine("\nPlease input command: \r\n- 1 Send Data \r\n- 2 Exit \r\n");
        string cmd = Console.ReadLine();
        if (cmd == "1")
        {
          Console.Write("Please enter data to send: ");
          string data = Console.ReadLine();
          pipeclient.SendText(data);
          Console.WriteLine("Waiting for response...\n");
          while (!dataInReceived)
          {
            pipeclient.DoEvents();
          }
        }
        else if (cmd == "2")
        {
          break;
        }
        else
        {
          Console.WriteLine("Command not recognized\n");
        }
      }
    }
    catch (IPWorksIPCException e)
    {
      Console.WriteLine($"ERROR {e.Message}");
    }
  }

  private static void FireConnected(object sender, EventArgs e)
  {
    Console.WriteLine("Connected");
  }

  private static void FireDataIn(object sender, PipeClientDataInEventArgs e)
  {
    Console.WriteLine($"Received {e.Text} from Pipe Server.\r\n");
    dataInReceived = true;
  }

  private static void FireDisconnected(object sender, EventArgs e)
  {
    Console.WriteLine("Disconnected");
  }

  private static void FireError(object sender, PipeClientErrorEventArgs e)
  {
    Console.WriteLine(e.Description);
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
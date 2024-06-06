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

﻿
using System;
using nsoftware.IPWorksIPC;


class Program
{
  // The main method of the program. It is marked as async because it will use asynchronous operations.
  static void Main(string[] args)
  {
    // Creating an instance of the PipeExec component from the IPWorks IPC library
    PipeExec pipeexec = new PipeExec();

    // Print out some introduction about this program to console
    Console.WriteLine("*****************************************************************");
    Console.WriteLine("* This demo shows how to use the Process class to launch a *");
    Console.WriteLine("* process then send and receive data to and from the process. *");
    Console.WriteLine("*****************************************************************");

    // Define strings for process path and arguments
    string processPath;
    string processArgs;

    // Check the platform the program is running on
    if (Environment.OSVersion.Platform == PlatformID.Unix)
    {
      // Prompt the user to enter the process name
      Console.Write("Process [ls]: ");
      processPath = Console.ReadLine();
      // If no process name is entered, use 'ls' as default
      if (string.IsNullOrEmpty(processPath)) pipeexec.ProcessFileName = "ls";

      // Prompt the user to enter the process arguments
      Console.Write("Process Args [-la]: ");
      processArgs = Console.ReadLine();
      // If no process arguments are entered, use '-la' as default
      if (string.IsNullOrEmpty(processArgs)) pipeexec.ProcessArgs = "-la";
    }
    else
    {
      // For non-Unix platforms, use similar approach but with different defaults
      Console.Write("Process Path [C:\\Windows\\System32\\cmd.exe]: ");
      processPath = Console.ReadLine();
      if (string.IsNullOrEmpty(processPath)) pipeexec.ProcessFileName = "C:\\Windows\\System32\\cmd.exe";

      Console.Write("Process Args [/Q]: ");
      processArgs = Console.ReadLine();
      if (string.IsNullOrEmpty(processArgs)) pipeexec.ProcessArgs = "/Q";
    }

    // Prompt the user to start the process
    Console.Write("Press enter to start process. Enter 'exit' to exit.");
    Console.ReadLine();

    // Attach an event handler to the OnStdout event. This handler will print the standard output to the console.
    pipeexec.OnStdout += (sender, e) =>
    {
      Console.Write(e.Text);

    };

    // Attach an event handler to the OnStderr event. This handler will print the standard error to the console.
    pipeexec.OnStderr += (sender, e) =>
    {
      Console.WriteLine(e.Text);
    };

    // Start the process asynchronously
    pipeexec.StartProcess();

    // Infinite loop that keeps the program running until the user enters 'exit'
    while (true)
    {
      string input = Console.ReadLine();
      if (input != "exit")
      {
        // Send user input to the process
        pipeexec.SendLine(input);
      }
      else
      {
        // If the user enters 'exit', break the loop
        break;
      }

    }

    // Stop the process asynchronously
    pipeexec.StopProcess();

    // Notify the user that the program is exiting and wait for a key press
    Console.WriteLine("Exiting... (press enter)");
    Console.ReadLine();
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
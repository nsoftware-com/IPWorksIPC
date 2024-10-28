(*
 * IPWorks IPC 2024 Delphi Edition - Sample Project
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
 *)

program pipeserver;

uses
  Forms,
  pipeserverf in 'pipeserverf.pas' {FormPipeserver};

begin
  Application.Initialize;

  Application.CreateForm(TFormPipeserver, FormPipeserver);
  Application.Run;
end.


         

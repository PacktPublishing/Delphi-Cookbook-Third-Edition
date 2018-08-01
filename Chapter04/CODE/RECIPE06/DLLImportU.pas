unit DLLImportU;

interface

uses
  CommonsU;

procedure Execute(const Caption: String; Callback: TDLLCallback); stdcall; external 'fmxproject';

implementation

end.

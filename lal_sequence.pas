unit lal_sequence;

interface

uses
  Classes, ZConnection, ZSequence, lal_connection;

type
  TLalSequence = class(TZSequence)
  private
  public
    constructor Create(AOwner: TComponent; cnx: TLalConnection); reintroduce;
    function SerialByName(const name: string): integer;
    function get: integer;
  end;

implementation

uses
  SysUtils;

{ TGPZSequence }

constructor TLalSequence.Create(AOwner: TComponent; cnx: TLalConnection);
begin
  inherited Create(AOwner);
  Connection := cnx.get;
end;

function TLalSequence.get: integer;
begin
  if SequenceName = '' then
    raise Exception.Create('Le nom de la séquence n''est pas défini !');
  Result       := GetNextValue;
  Assert(Result > 0);
end;

function TLalSequence.SerialByName(const name: string): integer;
begin
  SequenceName := UpperCase(name);
  Result       := GetNextValue;
  Assert(Result > 0);
end;

end.

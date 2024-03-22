unit UFunctions;

interface

uses
  FireDAC.Comp.Client, SysUtils;

type
  TFunctions = class
  private

  public
    class procedure ExecutaSQL(sSQL: string; Query:TFDQuery; forceFlag: Integer = -1);
  end;

implementation

{ TFunctions }

class procedure TFunctions.ExecutaSQL(sSQL: string; Query: TFDQuery; forceFlag: Integer = -1);
function RetornaTipoSQL(sSQL: String): Integer;
  var
    I: Integer;
  begin
    Result:= 0;

    for I:= 1 to Length(sSQL) do
    begin
      if (AnsiUpperCase(Copy(sSQL, I, 7)) = 'EXECUTE') then
      begin
        if AnsiUpperCase(sSQL).Contains('RETURNS') then
          Result:= 1
        else
          Result:= 0;
        Exit;
      end;

      if (AnsiUpperCase(sSQL).Contains('RETURNING')) then
      begin Result:= 1; Exit; end;

      if (AnsiUpperCase(Copy(sSQL, I, 14)) = 'CREATE TRIGGER') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 13)) = 'ALTER TRIGGER') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 23)) = 'CREATE OR ALTER TRIGGER') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 6)) = 'SELECT') then
      begin Result:= 1; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 6)) = 'UPDATE') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 6)) = 'INSERT') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 6)) = 'DELETE') then
      begin Result:= 0; Exit; end;
      if (AnsiUpperCase(Copy(sSQL, I, 5)) = 'ALTER') then
      begin Result:= 0; Exit; end;
    end;
  end;

begin
  with Query do
  begin
    ResourceOptions.MacroExpand:= False;
    Close;
    SQL.Clear;
    SQL.Add(sSQL);

    if (forceFlag < 0) then
      forceFlag:= RetornaTipoSQL(sSQL);

    if forceFlag = 0 then
      ExecSQL
    else
      Open;
  end;
end;

end.

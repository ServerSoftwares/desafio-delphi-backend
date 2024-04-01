unit uValidarModel;

interface

uses
  Vcl.Forms, Winapi.Windows, System.SysUtils, Vcl.Mask;
type TValidarModel = class
  private
  public
  function RemoverNaoNumericos(const Str: string): string;
  function removeMask(MaskEdit: TMaskEdit) : string;
end;

implementation

{ TValidarModel }

function TValidarModel.removeMask(MaskEdit: TMaskEdit): string;
var
  Mask: String;
begin
  Mask := MaskEdit.EditMask;
  MaskEdit.EditMask := '';
  Result := MaskEdit.Text;
  MaskEdit.EditMask := Mask;
end;


function TValidarModel.RemoverNaoNumericos(const Str: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Str) do
  begin
    if CharInSet(Str[i], ['0'..'9']) then
      Result := Result + Str[i];
  end;
end;

end.

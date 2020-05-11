unit lal_utils;

interface

uses
  Forms, Classes, StdCtrls, Inifiles;

type
  TIniCallback = procedure (ini: TInifile) of object;

function GetAppVersion: string;                   overload;
function GetAppVersion(Filename: string): string; overload;
procedure dbgrid_keyDown(form: TForm; var Key: Word; Shift: TShiftState; firstWhenEOF: boolean);
procedure handle_formKeyDown(form: TForm; var Key: word; Shift: TShiftState);
function removeDirectory(const dir: string): boolean;
procedure ComboBox_AutoWidth(const theComboBox: TCombobox);
{: write the Form's position into inifile. The icb let the caller write into }
procedure writeFormPos(F: TForm; icb: TIniCallback);
{: read form's position from inifile }
procedure readFormPos(F: TForm; icb: TIniCallback);

implementation

uses
  Windows, SysUtils, DBGrids, DB, Messages, ShellApi;

function GetAppVersion : string;
begin
  Result := GetAppVersion(ParamStr(0));
end;

function GetAppVersion(FileName: string) : string;
{ ---------------------------------------------------------
   Extracts the FileVersion element of the VERSIONINFO
   structure that Delphi maintains as part of a project's
   options.

   Results are returned as a standard string.  Failure
   is reported as "".

   Note that this implementation was derived from similar
   code used by Delphi to validate ComCtl32.dll.  For
   details, see COMCTRLS.PAS, line 3541.
  -------------------------------------------------------- }
const
   NOVIDATA = '';

var
  dwInfoSize,           // Size of VERSIONINFO structure
  dwVerSize,            // Size of Version Info Data
  dwWnd: DWORD;         // Handle for the size call.
  FI: PVSFixedFileInfo; // Delphi structure; see WINDOWS.PAS
  ptrVerBuf: Pointer;   // pointer to a version buffer
  strFileName,          // Name of the file to check
  strVersion : string;  // Holds parsed version number
begin

   strFileName := Filename;
   dwInfoSize :=
      getFileVersionInfoSize( pChar( strFileName ), dwWnd);

   if ( dwInfoSize = 0 ) then
      result := NOVIDATA
   else
   begin

      getMem( ptrVerBuf, dwInfoSize );
      try

         if getFileVersionInfo( pChar( strFileName ),
            dwWnd, dwInfoSize, ptrVerBuf ) then

            if verQueryValue( ptrVerBuf, '\',
                              pointer(FI), dwVerSize ) then

            strVersion :=
               Format( '%d.%d.%d.%d',
                       [ hiWord( FI.dwFileVersionMS ),
                         loWord( FI.dwFileVersionMS ),
                         hiWord( FI.dwFileVersionLS ),
                         loWord( FI.dwFileVersionLS ) ] );

      finally
        freeMem( ptrVerBuf );
      end;
    end;
  Result := strVersion;
end;

procedure dbgrid_keyDown(form: TForm; var Key: Word; Shift: TShiftState; firstWhenEOF: boolean);
var
  grid: TDBGrid;
  data: TDataset;
begin
  if not (Screen.ActiveControl is TDBGrid) then
  begin
    if not(ssShift in Shift) then
      form.Perform(WM_NEXTDLGCTL,0,0)
    else
      form.Perform(WM_NEXTDLGCTL,1,0);
  end
  else
  begin
    grid := TDBGrid(Screen.ActiveControl);
    if (grid.DataSource <> nil) and (grid.DataSource.DataSet <> nil) then
    begin
      data := grid.DataSource.DataSet;
      if grid.SelectedIndex < grid.Columns.count - 1 then
        grid.SelectedIndex := grid.SelectedIndex + 1
      else
      begin
        grid.SelectedIndex := 0;
        if data.Active then
        begin
          data.Next;
          if firstWhenEOF and data.Eof then
            data.First;
        end;
      end;
    end;
  end;
end;

procedure handle_formKeyDown(form: TForm; var Key: word; Shift: TShiftState);
var
  g: TDBGrid;
  d: TDataset;
  col: integer;
begin
  case Key of
    VK_RETURN: begin
      if not (form.ActiveControl is TDBGrid) then begin
        form.Perform(WM_NEXTDLGCTL,0,0);
      end
      else
      begin
        g := TDBGrid(form.ActiveControl);
        if (g.DataSource <> nil) and (g.DataSource.DataSet <> nil) then
        begin
          d := g.DataSource.DataSet;
          col := g.SelectedIndex;
          if Succ(col) < g.Columns.Count then
            Inc(col)
          else
          begin
            col := 0;
            d.Next;
            if d.Eof then
              d.Insert;
          end;
          g.SelectedIndex := col;
        end;
      end;

    end;
  end;
end;

function removeDirectory(const dir: string): boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  Result := False;
  if (Trim(dir) <> '') and DirectoryExists(dir)
                 and (Lowercase(Trim(dir)) <> 'c:\provencale\')
                 and (Lowercase(Trim(dir)) <> 'c:\provencale')
                 and (Lowercase(Trim(dir)) <> 'c:\provencale\bin')
                 and (Lowercase(Trim(dir)) <> 'c:\provencale\bin\')
                 and (IncludeTrailingPathDelimiter(Trim(dir)) <> IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))) then
  begin
    try
     Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
     FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
     StrPCopy(DirBuf, dir) ;
     with SHFileOpStruct do begin
      Wnd := 0;
      pFrom := @DirBuf;
      wFunc := FO_DELETE;
      fFlags := FOF_ALLOWUNDO;
      fFlags := fFlags or FOF_NOCONFIRMATION;
      fFlags := fFlags or FOF_SILENT;
     end;
      Result := (SHFileOperation(SHFileOpStruct) = 0) ;
     except
      Result := False;
    end;
  end;
end;

procedure ComboBox_AutoWidth(const theComboBox: TCombobox);
const
HORIZONTAL_PADDING = 4;
var
itemsFullWidth: integer;
idx: integer;
itemWidth: integer;
begin
itemsFullWidth := 0;
// get the max needed with of the items in dropdown state
for idx := 0 to -1 + theComboBox.Items.Count do
begin
itemWidth := theComboBox.Canvas.TextWidth(theComboBox.Items[idx]);
Inc(itemWidth, 2 * HORIZONTAL_PADDING);
if (itemWidth > itemsFullWidth) then itemsFullWidth := itemWidth;
end;
// set the width of drop down if needed
if (itemsFullWidth > theComboBox.Width) then
begin
//check if there would be a scroll bar
if theComboBox.DropDownCount < theComboBox.Items.Count then
itemsFullWidth := itemsFullWidth + GetSystemMetrics(SM_CXVSCROLL);
SendMessage(theComboBox.Handle, CB_SETDROPPEDWIDTH, itemsFullWidth, 0);
end;
end;

procedure writeFormPos(F: TForm; icb: TIniCallback);
var
  ini: TInifile;
begin
  ini := TInifile.Create(Format('%s\%s',[IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)),
                                         ChangeFileExt(ExtractFileName(Application.ExeName),'.ini')]));
  try
    ini.WriteInteger(F.Name,'Left',F.Left);
    ini.WriteInteger(F.Name,'Top',F.Top);
    ini.WriteInteger(F.Name,'Width',F.Width);
    ini.WriteInteger(F.Name,'Height',F.Height);
    if Assigned(icb) then icb(ini);
  finally
    ini.Free;
  end;
end;

procedure readFormPos(F: TForm; icb: TIniCallback);
var
  ini: TInifile;
begin
  ini := TInifile.Create(Format('%s\%s',[IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)),
                                         ChangeFileExt(ExtractFileName(Application.ExeName),'.ini')]));
  try
    F.Left := ini.ReadInteger(F.Name,'Left',0);
    F.Top := ini.ReadInteger(F.Name,'Top',0);
    F.Width := ini.ReadInteger(F.Name,'Width',F.Width);
    F.Height := ini.ReadInteger(F.Name,'Height',F.Height);
    if Assigned(icb) then icb(ini);
  finally
    ini.Free;
  end;
end;

end.


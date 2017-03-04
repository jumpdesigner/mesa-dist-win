; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Mesa3D software rendering drivers for Windows"
#define MyAppVersion "17.0.1"
#define MyAppPublisher "Pal100x"
#define MyAppURL "https://github.com/pal1000/mesa-dist-win"
#define MyAppExeName "mesa-x86-{#MyAppVersion}-setup.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{865AE11F-2AA3-4C55-ADBD-367031956B07}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
LicenseFile=..\LICENSE
OutputDir=..\bin\
OutputBaseFilename=mesa-x86-{#MyAppVersion}-setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "..\bin\x86\opengl32sw.dll"; DestDir: "{win}\system32"; Flags: ignoreversion
Source: "..\bin\x86\swrAVX.dll"; DestDir: "{win}\system32"; Flags: ignoreversion
Source: "..\bin\x86\swrAVX2.dll"; DestDir: "{win}\system32"; Flags: ignoreversion
Source: "..\local\localdeploy-x86.cmd"; DestDir: "{app}"
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\OpenGLDrivers\MSOGL"; ValueType: string; ValueName: "DLL"; ValueData: "opengl32sw.dll"; Flags: createvalueifdoesntexist uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\OpenGLDrivers\MSOGL"; ValueType: dword; ValueName: "DriverVersion"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\OpenGLDrivers\MSOGL"; ValueType: dword; ValueName: "Flags"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\OpenGLDrivers\MSOGL"; ValueType: dword; ValueName: "Version"; ValueData: "2"; Flags: createvalueifdoesntexist uninsdeletekey

[UninstallDelete]
Type: files; Name: "{win}\system32\opengl32sw.dll"
Type: files; Name: "{win}\system32\swrAVX.dll"
Type: files; Name: "{win}\system32\swrAVX2.dll"

[Icons]
Name: "{commondesktop}\Mesa3D local deployment utility"; Filename: "cmd"; Parameters: "/c ""{app}\localdeploy-x86.cmd"""; AfterInstall: SetElevationBit ('{commondesktop}\Mesa3D local deployment utility.lnk')


[Code]

procedure SetElevationBit(Filename: string);
var
  Buffer: string;
  Stream: TStream;
begin
  Filename := ExpandConstant(Filename);
  Log('Setting elevation bit for ' + Filename);

  Stream := TFileStream.Create(FileName, fmOpenReadWrite);
  try
    Stream.Seek(21, soFromBeginning);
    SetLength(Buffer, 1);
    Stream.ReadBuffer(Buffer, 1);
    Buffer[1] := Chr(Ord(Buffer[1]) or $20);
    Stream.Seek(-1, soFromCurrent);
    Stream.WriteBuffer(Buffer, 1);
  finally
    Stream.Free;
  end;
end;
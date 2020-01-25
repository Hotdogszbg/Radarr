; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppName "Radarr"
#define AppPublisher "Team Radarr"
#define AppURL "https://radarr.video/"
#define ForumsURL "https://forums.radarr.video/"
#define AppExeName "Radarr.exe"
#define BaseVersion GetEnv('MAJORVERSION')
#define BuildNumber GetEnv('MINORVERSION')
#define BuildVersion GetEnv('RADARRVERSION')
#define BranchName GetEnv('BUILD_SOURCEBRANCHNAME')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{56C1065D-3523-4025-B76D-6F73F67F7F82}
AppName={#AppName}
AppVersion={#BaseVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#ForumsURL}
AppUpdatesURL={#AppURL}
DefaultDirName={commonappdata}\Radarr\bin
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputBaseFilename=Radarr.{#BranchName}.{#BuildVersion}.windows.{#Framework}
SolidCompression=yes
AppCopyright=Creative Commons 3.0 License
AllowUNCPath=False
UninstallDisplayIcon={app}\Radarr.exe
DisableReadyPage=True
CompressionThreads=2
Compression=lzma2/normal
AppContact={#ForumsURL}
VersionInfoVersion={#BaseVersion}.{#BuildNumber}
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"
Name: "windowsService"; Description: "Install Windows Service (Starts when the computer starts)"; GroupDescription: "Start automatically"; Flags: exclusive
Name: "startupShortcut"; Description: "Create shortcut in Startup folder (Starts when you log into Windows)"; GroupDescription: "Start automatically"; Flags: exclusive unchecked
Name: "none"; Description: "Do not start automatically"; GroupDescription: "Start automatically"; Flags: exclusive unchecked

[Files]
Source: "..\_artifacts\windows\{#Framework}\Radarr\Radarr.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\_artifacts\windows\{#Framework}\Radarr\*"; Excludes: "Radarr.Update"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "/icon"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "/icon"
Name: "{userstartup}\{#AppName}"; Filename: "{app}\Radarr.exe"; WorkingDir: "{app}"; Tasks: startupShortcut

[Run]
Filename: "{app}\Radarr.Console.exe"; StatusMsg: "Removing previous Windows Service"; Parameters: "/u"; Flags: runhidden waituntilterminated;
Filename: "{app}\Radarr.Console.exe"; Description: "Enable Access from Other Devices"; StatusMsg: "Enabling Remote access"; Parameters: "/registerurl"; Flags: postinstall runascurrentuser runhidden waituntilterminated; Tasks: startupShortcut none;
Filename: "{app}\Radarr.Console.exe"; StatusMsg: "Installing Windows Service"; Parameters: "/i"; Flags: runhidden waituntilterminated; Tasks: windowsService
Filename: "{app}\Radarr.exe"; Description: "Open Radarr Web UI"; Flags: postinstall skipifsilent nowait; Tasks: windowsService;
Filename: "{app}\Radarr.exe"; Description: "Start Radarr"; Flags: postinstall skipifsilent nowait; Tasks: startupShortcut none;

[UninstallRun]
Filename: "{app}\radarr.console.exe"; Parameters: "/u"; Flags: waituntilterminated skipifdoesntexist

[Code]
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: Integer;
begin
  Exec(ExpandConstant('{commonappdata}\Radarr\bin\Radarr.Console.exe'), '/u', '', 0, ewWaitUntilTerminated, ResultCode)
end;
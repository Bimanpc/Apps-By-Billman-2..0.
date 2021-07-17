@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

ECHO.

:: Initialize variables
SET CDROMDrive=
SET CDROMDrives=0
SET Track=0
SET VerboseOutput=
SET VLCPath=""

:: Check the target folder
IF "%~1"=="" GOTO Syntax
SET TargetFolder=%~1

:: If CDROM drive is specified on the command line, it overrules the automatic detection
IF     "%~2"=="" (CALL :FindCD)
IF /I  "%~2"=="/Q" (
	SET VerboseOutput=REM
	CALL :FindCD
)
IF NOT "%~2"=="" IF /I NOT "%~2"=="/Q" (
	REM :: Check if the second command line argument is a drive letter
	ECHO "%~2" | FINDSTR /R /B /I /C:"\""[D-Z]:\""" >NUL
	IF ERRORLEVEL 1 GOTO Syntax
	SET CDROMDrive=%~2
)
IF "%CDROMDrive%"=="" (
	ECHO ERROR:   Unable to find the CDROM drive.
	ECHO          Please specify the CDROM drive letter.
	ECHO.
	GOTO Syntax
)

IF /I "%~3"=="/Q" SET VerboseOutput=REM

:: Locate VLC.exe
CALL :FindVLC

:: Check if the specified output directory/target folder is a valid local filesystem path
ECHO "%~1" | FINDSTR /R /B /I /C:"\""[A-Z]:\\.*" >NUL
IF ERRORLEVEL 1 (
	REM :: Check if the specified output directory/target folder is a valid UNC path
	ECHO "%~1" | FINDSTR /R /B /I /C:"\""\\\\[A-Z0-9_][A-Z0-9_-]*\\[A-Z0-9_][A-Z0-9_-]*\$*\\.*" >NUL
	IF ERRORLEVEL 1 GOTO Syntax
)

:: Add a trailing backslash to the target path if necessary
IF DEFINED TargetFolder IF NOT "%TargetFolder:~-1%"=="\" SET TargetFolder=%TargetFolder%\

:: Create the output directory, if necessary
IF EXIST "%TargetFolder%" (
	IF "%VerboseOutput%"=="" (
		ECHO STATUS:  Output directory already exists, reusing it . . .
		IF EXIST "%TargetFolder%Track*.mp3" (
			ECHO.
			ECHO WARNING: Output directory contains Track*.mp3 files.
			REM :: The first character in the prompt after the /M switch is 0x08, otherwise the leading spaces would be ignored.
			CHOICE /C NY /N /D N /T 10 /M "         Do you want to overwrite existing files in this folder? [y/N] "
			IF NOT ERRORLEVEL 2 (
				ECHO.
				ECHO          Aborting.
				ENDLOCAL
				EXIT /B 2
			)
			ECHO.
		)
	)
)
:: Create target folder if it does not exist
IF NOT EXIST "%TargetFolder%" (
	%VerboseOutput% ECHO STATUS:  Trying to create output directory
	MD "%TargetFolder%"
	IF EXIST "%TargetFolder%" (
		ECHO STATUS:  Output directory created successfully
	) ELSE (
		ECHO ERROR:   Unable to access target folder %TargetFolder%
		TIMEOUT /T 6 >NUL 2>&1
		ECHO.
		GOTO Syntax
	)
)

%VerboseOutput% ECHO STATUS:  Exporting to "%TargetFolder%" . . .

:: Read and convert each track
%VerboseOutput% ECHO STATUS:  Reading tracks from CD in drive %CDROMDrive%
FOR /R %CDROMDrive%\ %%G IN (*.cda) DO (CALL :RunVLC "%%G")

:: Add leading zeroes if necessary
IF EXIST "%TargetFolder%Track10.mp3" (
	FOR /L %%A IN (1,1,9) DO (
		REN "%TargetFolder%Track%%A.mp3" Track0%%A.mp3
	)
)

:: Done
ENDLOCAL
GOTO:EOF




:RunVLC
:: Here's where the actual transcoding/conversion happens
SET /A Track += 1
%VerboseOutput% ECHO.
%VerboseOutput% ECHO STATUS:  Transcoding %1
SET OutTrack=%TargetFolder%Track%Track%.mp3
%VerboseOutput% ECHO STATUS:  Output to "%OutTrack%"
%VerboseOutput% ECHO STATUS:  Exporting . . .
:: The next line fires off a command to VLC.exe with the relevant arguments
START /WAIT "" %VLCPath% -I http cdda:///%CDROMDrive%/ --cdda-track=%Track% :sout=#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:std{access="file",mux=raw,dst="%OutTrack%"} vlc://quit
GOTO:EOF




:FindCD
:: Will set the variable CDROMDrive to contain the drive letter of the only CDROM drive that contains an audio CD
::
:: Get the CDROM drive count
FOR /F %%A IN ('WMIC.EXE Path Win32_CDROMDrive Get /Format:CSV ^| MORE /E +2 ^| FIND /C ","') DO (SET CDROMDrives=%%A)
IF "%CDROMDrives%"=="0" (
	ECHO ERROR:   No CDROM drive detected.
	ECHO          Please specify the drive to be used.
	TIMEOUT /T 10 >NUL 2>&1
	GOTO Syntax
)
:: Get all CDROM drive letters
SET Count=0
SET Drives.=
SET DriveLetters=
FOR /F "tokens=2 delims==" %%A IN ('WMIC.EXE Path Win32_CDROMDrive Get Drive /Format:Value') DO (
	FOR /F %%B IN ("%%~A") DO (
		SET Index=%%B
		SET Index=!Index:~0,1!
		SET Drives.!Index!=%%B
	)
)
:: Sort the drive letters and create a string
FOR /F "tokens=2 delims==" %%A IN ('SET Drives.') DO (
	SET /A Count += 1
	IF "!DriveLetters!"=="" (
		SET DriveLetters=%%A
	) ELSE (
		IF !Count! EQU %CDROMDrives% (SET DriveLetters=!DriveLetters! or %%A)
		IF !Count! NEQ %CDROMDrives% (SET DriveLetters=!DriveLetters!, %%A)
	)
)
:Retry
:: Get the CDROM drives with an audio CD inserted
SET CDLoaded=0
FOR /F "tokens=*" %%A IN ('WMIC.EXE Path Win32_CDROMDrive Where ^(MediaLoaded^=True And VolumeName LIKE "Audio%%"^) Get Drive^,VolumeName /Format:CSV 2^>NUL ^| MORE /E +2 ^| FIND /C ","') DO SET CDLoaded=%%A
:: Prompt to insert audio CD if none found
IF "%CDLoaded%"=="0" (
	ECHO USER:    Insert an audio CD in one of the CDROM drives ^(%DriveLetters%^)
	ECHO USER:    Press any key to continue
	PAUSE > NUL
	TIMEOUT /T 5 >NUL 2>&1
	GOTO :Retry
)
:: Abort if multiple audio CDs found
IF %CDLoaded% GTR 1 (
	ECHO ERROR:   Multiple CDROM drives detected with an audio CD loaded.
	ECHO          Either remove all audio CDs but one, or specify the CDROM
	ECHO          drive to be used ^(%DriveLetters%^).
	REM :: Wait 10 seconds
	TIMEOUT /T 10 >NUL 2>&1
	GOTO Syntax
)
:: Return the drive letter for the only CDROM drive containing an audio CD
FOR /F "tokens=*" %%A IN ('WMIC.EXE Path Win32_CDROMDrive Where ^(MediaLoaded^=True And VolumeName LIKE "Audio%%"^) Get Drive^,VolumeName /Format:Value 2^>NUL') DO (
	SET VolumeName=
	FOR /F "tokens=1* delims==" %%B IN ("%%~A") DO (
		FOR /F %%D IN ("%%~C") DO (SET %%B=%%D)
		SET CDROMDrive=!Drive!
	)
)
GOTO:EOF




:FindVLC
FOR /F "tokens=2*" %%A IN ('REG Query "HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC" /ve') DO SET VLCPath="%%~B"
IF ERRORLEVEL 1 GOTO Syntax
IF %VLCPath%=="" (
	ECHO ERROR:   VLC not found. VLC is required to rip CDs.
	REM :: The first character in the prompt after the /M switch is 0x08, otherwise the leading spaces would be ignored.
	CHOICE /C NY /D N /T 10 /M "         Do you want to open the VLC download page in your default browser?"
	IF ERRORLEVEL 2 START /MAX "" "http://www.videolan.org/"
	ECHO.
	GOTO Syntax
)
GOTO:EOF




:Syntax
ENDLOCAL

ECHO.
ECHO RipCD.bat,  Version 1.01
ECHO Save audio CD tracks as MP3s
ECHO.
ECHO Usage:   RIPCD  targetdir  [ drive: ]  [ /Q ]
ECHO.
ECHO Where:   targetdir    is the target folder to save the MP3s to
ECHO                       ^(e.g. "D:\MP3s\Mike Oldfield\Tubular Bells"^)
ECHO          drive:       is the CDROM drive letter for the audio CD
ECHO                       ^(usually not required, unless there are multiple
ECHO                       CDROM drives simultaneously containing an audio CD^)
ECHO          /Q           Quiet mode: less screen output, and overwrite existing
ECHO                       files without prompting for confirmation
ECHO.
ECHO Notes:   This batch file requires VLC Media Player ^(http://www.videolan.org^)
ECHO          If the batch file cannot find VLC, it will prompt you to download it.
ECHO          MP3 files are named Track1.mp3, Track2.mp3, etc. ^(or Track01.mp3,
ECHO          Track02.mp3, etc. if the number of tracks is 10 or more^).
ECHO.
ECHO Credits: Main functionality by elrobis ^(http://cartometric.com/blog/2015/03/07^)
ECHO          Automatic CDROM drive and VLC path detection by Rob van der Woude
ECHO.
ECHO Written by Rob van der Woude
ECHO http://www.robvanderwoude.com

EXIT 1

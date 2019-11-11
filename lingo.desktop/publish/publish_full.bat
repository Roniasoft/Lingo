@echo Starting deployment of lingo desktop....
@PING 1.1.1.1 -n 2 -w 3000>nul	REM to create a delay!

@echo Creating the directory...
@PING 1.1.1.1 -n 2 -w 3000>nul
if not exist publishFull mkdir publishFull

@echo Copying the images/qml files and qt runtimes...
@PING 1.1.1.1 -n 2 -w 3000>nul
robocopy ..\images publishFull\images /e
robocopy ..\QmlFiles publishFull\QmlFiles /e
robocopy dep\qt-5.12.2-ad0689c-win-x64 publishFull\qt-5.12.2-ad0689c-win-x64 /e

@echo Publishing the project...
@PING 1.1.1.1 -n 2 -w 3000>nul
dotnet publish ..\lingo.desktop.csproj -c Release --framework netcoreapp3.0 /p:RuntimeIdentifier=win-x64

@echo Copying all application files and dotnet core runtimes...
@PING 1.1.1.1 -n 2 -w 3000>nul
robocopy ..\bin\Release\netcoreapp3.0\win-x64\publish publishFull /e


echo Deployment finished successfully!!!
pause

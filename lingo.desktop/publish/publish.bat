@echo Starting deployment of lingo desktop....
@PING 1.1.1.1 -n 2 -w 3000>nul	REM to create a delay!

@echo Creating the directory...
@PING 1.1.1.1 -n 2 -w 3000>nul
if not exist publish mkdir publish


@echo Copying the images/qml files and qt runtimes...
@PING 1.1.1.1 -n 2 -w 3000>nul
robocopy ..\images publish\images /e
robocopy ..\QmlFiles publish\QmlFiles /e
robocopy dep\qt-5.12.2-ad0689c-win-x64 publish\qt-5.12.2-ad0689c-win-x64 /e


@echo Publishing the project...
@PING 1.1.1.1 -n 2 -w 3000>nul
dotnet publish ..\lingo.desktop.csproj -c Release --framework netcoreapp3.0 /p:RuntimeIdentifier=win-x64


@echo Building in Debug model. We'll need the runtime configs.
@PING 1.1.1.1 -n 2 -w 3000>nul
dotnet build ..\lingo.desktop.csproj --configuration Debug


@echo Copying the application files...
@PING 1.1.1.1 -n 2 -w 3000>nul
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\lingo.common.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\lingo.desktop.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\lingo.desktop.exe publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\lingo.filer.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\NetNativeLibLoader.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\Newtonsoft.Json.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\Qml.Net.dll publish
copy ..\bin\Release\netcoreapp3.0\win-x64\publish\QmlNet.dll publish
copy ..\bin\Debug\netcoreapp3.0\lingo.desktop.deps.json publish
copy ..\bin\Debug\netcoreapp3.0\lingo.desktop.runtimeconfig.dev.json publish
copy ..\bin\Debug\netcoreapp3.0\lingo.desktop.runtimeconfig.json publish

echo Deployment finished successfully!!!
pause

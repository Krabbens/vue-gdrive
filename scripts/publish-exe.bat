@echo off
if not exist ..\dist call pack-app.bat

rd /q /s ..\dist-exe
md ..\dist-exe\MyApp

pushd ..\dist-exe

xcopy /e ..\dist MyApp\dist\

app --copy-self MyApp\app 

pushd MyApp\dist
app shortcut -target "C:\Program Files\dotnet\dotnet.exe" ^
  -arguments "%%LocalAppData%%\MyApp\app\app.dll %%LocalAppData%%\MyApp\dist\app.settings" ^
  -workdir "%%LocalAppData%%\MyApp\dist"
popd

..\scripts\7za.exe -tzip a MyApp.zip MyApp

copy ..\scripts\install.ps1 .

rd /q /s VueDesktop

popd

@echo off
setlocal enableextensions

set rootpath=%cd%

if exist "%rootpath%\lib\build\" rd /s /q "%rootpath%\lib\build"
if exist "%rootpath%\lib\windows\" rd /s /q "%rootpath%\lib\windows"
md lib\build
md lib\windows
cd lib\build

cmake ..\.. -DDIRECTX=false -DSDL_SHARED=true -DCMAKE_INSTALL_PREFIX="%rootpath%\lib\build" -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
xcopy /y Release\SDL2.dll "%rootpath%\lib\windows"
xcopy /y Release\SDL2.lib "%rootpath%\lib\windows"

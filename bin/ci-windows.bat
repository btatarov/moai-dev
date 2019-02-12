@echo off

echo "Setting Moai Util path..."

pushd .
cd %~dp0%\..
set UTIL_PATH=%cd%\util

set PATH=%PATH%;%UTIL_PATH%

if "%VS120COMNTOOLS%"=="" echo Visual Studio not found
echo "Setting Visual Studio path..."

pushd .
call "%VS120COMNTOOLS%\VsDevCmd.bat"
popd

pushd .
echo "Building SDL"
cd %~dp0%\..\3rdparty\sdl2-2.0.0
call build\build-windows.bat
popd


echo Compiling Windows Libs
call bin\build-windows-untz.bat

popd

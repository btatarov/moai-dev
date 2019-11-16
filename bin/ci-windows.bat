@echo off

echo "Setting Moai Util path..."

pushd .
cd %~dp0%\..
set UTIL_PATH=%cd%\util

set PATH=%PATH%;%UTIL_PATH%

pushd .
set "VS_TOOLS=%VS140COMNTOOLS%"
if NOT EXIST "%VS_TOOLS%\VsDevCmd.bat"  set "VS_TOOLS=%VS120COMNTOOLS%"
if NOT EXIST "%VS_TOOLS%\VsDevCmd.bat" (
	@echo Visual Studio not found.
	exit /b 1
)
call "%VS_TOOLS%\VsDevCmd.bat"
call "%VS_TOOLS%\Vsvars32.bat"
popd

pushd .
echo "Building SDL"
cd %~dp0%\..\3rdparty\sdl2-2.0.0
call build\build-windows.bat
popd


echo Compiling Windows Libs
call bin\build-windows-untz.bat

popd

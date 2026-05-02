@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup script for Windows, version 3.2.0
@REM
@REM Required ENV vars:
@REM JAVA_HOME - location of a JDK home dir
@REM
@REM Optional ENV vars
@REM MAVEN_BATCH_ECHO - set to 'on' to enable the echoing of the batch commands
@REM MAVEN_BATCH_PAUSE - set to 'on' to wait for a key stroke before ending
@REM MAVEN_OPTS - parameters passed to the Java VM when running Maven
@REM     e.g. to debug Maven itself, use
@REM set MAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
@REM ----------------------------------------------------------------------------

@echo off
@setlocal

set ERROR_CODE=0

@REM To isolate internal variables from possible wrapper users, use the LW_ prefix
@REM LW_PRG - the script name
@REM LW_DIR - the script directory
set LW_PRG=%~0
set LW_DIR=%~dp0

@REM Set the echoing of the batch signals
if "%MAVEN_BATCH_ECHO%" == "on"  echo %MAVEN_BATCH_ECHO%

@REM Execute a user defined script before this one
if not "%MAVEN_SKIP_RC%" == "" goto skipArgs
if exists "%USERPROFILE%\mavenrc_pre.bat" call "%USERPROFILE%\mavenrc_pre.bat"
if exists "%LW_DIR%mavenrc_pre.bat" call "%LW_DIR%mavenrc_pre.bat"
:skipArgs

@REM Find the project base directory, i.e. the directory that contains the folder ".mvn".
@REM Fallback to current working directory if not found.

set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
if not "%MAVEN_PROJECTBASEDIR%" == "" goto endDetectBaseDir

set MAVEN_PROJECTBASEDIR=%LW_DIR%
:findBaseDir
if exist "%MAVEN_PROJECTBASEDIR%\.mvn" goto endDetectBaseDir
set "MAVEN_PROJECTBASEDIR=%MAVEN_PROJECTBASEDIR%\.."
if exist "%MAVEN_PROJECTBASEDIR%\.mvn" goto endDetectBaseDir
if "%MAVEN_PROJECTBASEDIR%" == "%MAVEN_PROJECTBASEDIR%\.." goto baseDirNotFound
goto findBaseDir

:baseDirNotFound
set MAVEN_PROJECTBASEDIR=%LW_DIR%

:endDetectBaseDir

set LW_JAR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar

@REM Extension to help the users with the jar download
if exist "%LW_JAR%" goto wrapperJarFound

set LW_PROPERTIES=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties
for /f "tokens=2 delims==" %%i in ('findstr "wrapperUrl" "%LW_PROPERTIES%"') do set LW_URL=%%i

if "%LW_URL%" == "" (
  echo Error: Property 'wrapperUrl' not found in %LW_PROPERTIES%
  exit /b 1
)

echo Downloading Maven Wrapper...
echo From: %LW_URL%
echo To:   %LW_JAR%

@REM Create the wrapper directory if it doesn't exist
if not exist "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper" mkdir "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper"

@REM Use PowerShell to download the jar
powershell -Command "&{"^
  "$webclient = New-Object System.Net.WebClient;"^
  "if (test-path '%LW_JAR%') { rm '%LW_JAR%' };"^
  "$webclient.DownloadFile('%LW_URL%', '%LW_JAR%');"^
"}"
if not exist "%LW_JAR%" (
  echo Error: Failed to download maven-wrapper.jar
  exit /b 1
)

:wrapperJarFound

@REM Check for JAVA_HOME
if not "%JAVA_HOME%" == "" goto checkJava

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto run

echo.
echo Error: JAVA_HOME is set to an invalid directory.
echo JAVA_HOME = "%JAVA_HOME%"
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.
goto error

:checkJava
set "JAVA_HOME=%JAVA_HOME:"=%"
set JAVA_EXE=%JAVA_HOME%\bin\java.exe

if exist "%JAVA_EXE%" goto run

echo.
echo Error: JAVA_HOME is set to an invalid directory.
echo JAVA_HOME = "%JAVA_HOME%"
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.
goto error

:run
@REM Start the wrapper
"%JAVA_EXE%" %MAVEN_OPTS% -classpath "%LW_JAR%" "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" org.apache.maven.wrapper.MavenWrapperMain %*
if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
@endlocal & set ERROR_CODE=%ERROR_CODE%

if not "%MAVEN_SKIP_RC%" == "" goto skipArgsPost
if exists "%USERPROFILE%\mavenrc_post.bat" call "%USERPROFILE%\mavenrc_post.bat"
if exists "%LW_DIR%mavenrc_post.bat" call "%LW_DIR%mavenrc_post.bat"
:skipArgsPost

if "%MAVEN_BATCH_PAUSE%" == "on" pause

if "%MAVEN_TERMINATE_CMD%" == "on" exit %ERROR_CODE%

exit /b %ERROR_CODE%

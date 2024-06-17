@echo off

:: 需要配置环境变量，使得 mvn 可以在命令行中使用

set env=%~2
if "%env%"=="" (
  set env=dev
)

IF "%~1"=="package" (
  goto :package
) ELSE IF "%~1"=="install" (
  goto :install
) ELSE IF "%~1"=="deploy" (
    goto :deploy
) ELSE IF "%~1"=="set_version" (
    goto :set_version
) ELSE (
  echo "************************************************"
  echo "Usage: action.bat {package|install|clean|deploy|set_version}"
  echo "************************************************"
  exit /b -1
)

:package
echo "package %env%"
mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true -P%env%
exit

:install
echo "install %env%"
mvn clean install -U -DskipTests=true -Dmaven.javadoc.skip=true -P%env%
exit

:deploy
echo "deploy %env%"
mvn clean deploy -U -DskipTests=true -Dmaven.javadoc.skip=true -P%env%
exit

:set_version
set version=%~2
echo "set_version %version%"
mvn versions:set -DgenerateBackupPoms=false -DnewVersion="%version%"
exit

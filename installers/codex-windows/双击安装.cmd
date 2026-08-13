@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

echo 正在启动 Codex 一键安装工具...
echo.

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-Codex.ps1" %*
set "CODEX_INSTALL_EXIT=%ERRORLEVEL%"

echo.
if "%CODEX_INSTALL_EXIT%"=="0" (
    echo 安装流程已成功完成。
) else (
    echo 安装未完成，退出码：%CODEX_INSTALL_EXIT%
    echo 请查看 %%TEMP%%\codex-install.log
)
echo.
pause
exit /b %CODEX_INSTALL_EXIT%

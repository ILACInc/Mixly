@echo on
title Mixly Assistant
echo Mixly Upgrading,Please wait...
@echo off

echo.
set python_select=
set /p python_select=Add Python(y/n):
IF "%python_select%"=="n" (
	echo No
) ELSE (
	echo Yes
)
echo.
set esp32_select=
set /p esp32_select=Add ESP32(y/n):
IF "%esp32_select%"=="n" (
	echo No
) ELSE (
	echo Yes
)
echo.
set esp8266_select=
set /p esp8266_select=Add ESP8266(y/n):
IF "%esp8266_select%"=="n" (
	echo No
) ELSE (
	echo Yes
)
echo.
set stm32_select=
set /p stm32_select=Add STM32(y/n):
IF "%stm32_select%"=="n" (
	echo No
) ELSE (
	echo Yes
)

IF EXIST "%~dp0"\.git\index.lock ( 
	del /f /s /q "%~dp0"\.git\index.lock > nul
	rd /q /s "%~dp0"\.git\index.lock > nul
)

echo.
echo.
cd "%~dp0"\PortableGit\cmd\
rem 更新mixly基础仓库
git reset --hard origin/master
git pull origin master

git gc
git prune

rem rd/s/q "%~dp0"\.git\refs\original > nul
rem rd/s/q "%~dp0"\.git\logs\ > nul

IF EXIST "%~dp0"\arduino\portable\packages\esp8266\.git ( 
	IF EXIST "%~dp0"\arduino\portable\packages\.git (
		del /f /s /q "%~dp0"\arduino\portable\packages\.git > nul
		rd /q /s "%~dp0"\arduino\portable\packages\.git > nul
	)
)

rem 更新esp32 硬件仓库
IF "%esp32_select%"=="n" (
	IF EXIST "%~dp0"\arduino\portable\packages\esp32 (
		del /f /s /q "%~dp0"\arduino\portable\packages\esp32 > nul
		rd /q /s "%~dp0"\arduino\portable\packages\esp32 > nul
	)
	rem 删除ESP32系列板卡的界面
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_ESP32.html > nul
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_HandBit.html > nul
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_MixePi.html > nul
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_MixGo.html > nul
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_M5Stick-C.html > nul
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Sidan_ESP32.html > nul
) ELSE (
	IF EXIST "%~dp0"\arduino\portable\packages\esp32\.git (
		echo A|xcopy "%~dp0"\PortableGit "%~dp0"\arduino\portable\packages\esp32\PortableGit\ /s /c /h > nul
		echo.
		echo.
		cd "%~dp0"\arduino\portable\packages\esp32\PortableGit\cmd\
		git reset --hard origin/master
		git pull origin master
		cd "%~dp0"
		del /f /s /q "%~dp0"\arduino\portable\packages\esp32\PortableGit > nul
		rd /q /s "%~dp0"\arduino\portable\packages\esp32\PortableGit > nul
	) ELSE (
		IF EXIST "%~dp0"\arduino\portable\packages\esp32 (
			del /f /s /q "%~dp0"\arduino\portable\packages\esp32 > nul
			rd /q /s "%~dp0"\arduino\portable\packages\esp32 > nul
		)
		echo.
		echo.
		cd "%~dp0"\PortableGit\cmd\
		git clone https://gitee.com/mixlyplus/win_esp32.git "%~dp0arduino\portable\packages\esp32\
	)
)

rem 更新esp8266硬件仓库
IF "%esp8266_select%"=="n" (
	IF EXIST "%~dp0"\arduino\portable\packages\esp8266 (
		del /f /s /q "%~dp0"\arduino\portable\packages\esp8266 > nul
		rd /q /s "%~dp0"\arduino\portable\packages\esp8266 > nul
	)
	rem 删除ESP8266界面
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_ESP8266.html > nul
) ELSE (
	IF EXIST "%~dp0"\arduino\portable\packages\esp8266\.git (
		echo A|xcopy "%~dp0"\PortableGit "%~dp0"\arduino\portable\packages\esp8266\PortableGit\ /s /f /h > nul
		echo.
		echo.
		cd "%~dp0"\arduino\portable\packages\esp8266\PortableGit\cmd\
		git reset --hard origin/master
		git pull origin master
		cd "%~dp0"
		del /f /s /q "%~dp0"\arduino\portable\packages\esp8266\PortableGit > nul
		rd /q /s "%~dp0"\arduino\portable\packages\esp8266\PortableGit > nul
	) ELSE (
		IF EXIST "%~dp0"\arduino\portable\packages\esp8266 (
			del /f /s /q "%~dp0"\arduino\portable\packages\esp8266 > nul
			rd /q /s "%~dp0"\arduino\portable\packages\esp8266 > nul
		)
		echo.
		echo.
		cd "%~dp0"\PortableGit\cmd\
		git clone https://gitee.com/mixlyplus/win_esp8266.git "%~dp0arduino\portable\packages\esp8266\
	)
)

rem 更新stm32硬件仓库
IF "%stm32_select%"=="n" (
	IF EXIST "%~dp0"\arduino\portable\packages\stm32duino (
		del /f /s /q "%~dp0"\arduino\portable\packages\stm32duino > nul
		rd /q /s "%~dp0"\arduino\portable\packages\stm32duino > nul
	)
	IF EXIST "%~dp0"\arduino\portable\packages\arduino\tools\arm-none-eabi-gcc (
		del /f /s /q "%~dp0"\arduino\portable\packages\arduino\tools\arm-none-eabi-gcc > nul
		rd /q /s "%~dp0"\arduino\portable\packages\arduino\tools\arm-none-eabi-gcc > nul
	)
	rem 删除STM32界面
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_Arduino_STM32F103C8T6.html > nul
) ELSE (
	IF EXIST "%~dp0"\arduino\portable\packages\stm32duino\.git (
		echo A|xcopy "%~dp0"\PortableGit "%~dp0"\arduino\portable\packages\stm32duino\PortableGit\ /s /f /h > nul
		echo.
		echo.
		cd "%~dp0"\arduino\portable\packages\stm32duino\PortableGit\cmd\
		git reset --hard origin/master
		git pull origin master
		cd "%~dp0"
		del /f /s /q "%~dp0"\arduino\portable\packages\stm32duino\PortableGit > nul
		rd /q /s "%~dp0"\arduino\portable\packages\stm32duino\PortableGit > nul
		echo A|xcopy "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc "%~dp0"\arduino\portable\packages\arduino\tools\arm-none-eabi-gcc\ /s /f /h > nul
		del /f /s /q "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc > nul
		rd /q /s "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc > nul
	) ELSE (
		IF EXIST "%~dp0"\arduino\portable\packages\stm32duino (
			del /f /s /q "%~dp0"\arduino\portable\packages\stm32duino > nul
			rd /q /s "%~dp0"\arduino\portable\packages\stm32duino > nul
		)
		echo.
		echo.
		cd "%~dp0"\PortableGit\cmd\
		git clone https://gitee.com/mixlyplus/win_stm32.git "%~dp0arduino\portable\packages\stm32duino\
		echo A|xcopy "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc "%~dp0"\arduino\portable\packages\arduino\tools\arm-none-eabi-gcc\ /s /f /h > nul
		del /f /s /q "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc > nul
		rd /q /s "%~dp0"\arduino\portable\packages\stm32duino\arm-none-eabi-gcc > nul
	)
)

rem 更新win_python3仓库
IF "%python_select%"=="n" (
	IF EXIST "%~dp0"\mixpyBuild\win_python3 (
		del /f /s /q "%~dp0"\mixpyBuild\win_python3 > nul
		rd /q /s "%~dp0"\mixpyBuild\win_python3 > nul
	)
	rem 删除Python界面
	del /f /s /q "%~dp0"\blockly\apps\mixly\index_board_mixpy.html > nul
) ELSE (
	IF EXIST "%~dp0"\mixpyBuild\win_python3\.git (
		echo A|xcopy "%~dp0"\PortableGit "%~dp0"\mixpyBuild\win_python3\PortableGit\ /s /f /h > nul
		echo.
		echo.
		cd "%~dp0"\mixpyBuild\win_python3\PortableGit\cmd\ 
		git reset --hard origin/master
		git pull origin master
		cd "%~dp0"
		del /f /s /q "%~dp0"\mixpyBuild\win_python3\PortableGit > nul
		rd /q /s "%~dp0"\mixpyBuild\win_python3\PortableGit > nul
	) ELSE (
		IF EXIST "%~dp0"\mixpyBuild\win_python3 (
			del /f /s /q "%~dp0"\mixpyBuild\win_python3 > nul
			rd /q /s "%~dp0"\mixpyBuild\win_python3 > nul
		)
		echo.
		echo.
		cd "%~dp0"\PortableGit\cmd\
		git clone https://gitee.com/mixlyplus/win_python3.git "%~dp0mixpyBuild\win_python3\
	)
)
cd "%~dp0"\PortableGit\cmd\

@echo on
echo Mixly upgraded, Enjoy it!
@echo off
pause
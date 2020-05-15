@echo off
    setlocal enableextensions enabledelayedexpansion

    echo Processing

    set CMD_FLAG=0
    set CMD_STR="Job Type: CMD"
    set DESC_STR="description:"
    set NEW_LINE=n_retrys: 3
    set IN_FILE=myfile.txt
    set OUT_FILE=file.out
    echo > %OUT_FILE%

    > "%OUT_FILE%" (
        for /f "delims=" %%A in ('type "myfile.txt" ^| find /n /v ""') do (
            set "ln=%%A"
            set "ln=!ln:*]=!"
            echo(!ln!
            if !CMD_FLAG! EQU 0 (
                echo %%A | find /I %CMD_STR% > nul && ( set CMD_FLAG=1 )
            ) else (
                echo %%A | find /I %DESC_STR% > nul && (
                    echo %NEW_LINE%
                    set CMD_FLAG=0
                )
            )
        )
    )

    echo Done

    exit /b
    

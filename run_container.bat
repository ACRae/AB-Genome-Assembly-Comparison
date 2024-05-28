@echo off
setlocal

REM Get the current directory
for %%A in (.) do set "LOCAL_PATH=%%~fA"
set "DATA_PATH=%LOCAL_PATH%\sra"
set "TARGET_PATH=/home/assembly"

REM Get the current image ID (if it exists)
for /f "usebackq tokens=*" %%I in (`docker images -q assemblers_image`) do set "CURRENT_IMAGE_ID=%%I"

REM Build the Docker image
docker build -t assemblers_image .

REM Get the new image ID after build
for /f "usebackq tokens=*" %%J in (`docker images -q assemblers_image`) do set "NEW_IMAGE_ID=%%J"

cls

REM Check if the container exists
docker ps -aq -f name=assemblers_cont > nul 2>&1
if %errorlevel% equ 0 (
    if "%CURRENT_IMAGE_ID%" neq "%NEW_IMAGE_ID%" (
        echo Image has changed. Removing existing container...
        docker rm -f assemblers_cont
        echo Creating a new container...
        docker run -it --name assemblers_cont --mount type=bind,source="%DATA_PATH%",target=%TARGET_PATH% assemblers_image
    ) else (
        echo Image has not changed. Starting existing container...
        docker start -ai assemblers_cont
    )
) else (
    echo Container does not exist. Creating a new container...
    docker run -it --name assemblers_cont --mount type=bind,source="%DATA_PATH%",target=%TARGET_PATH% assemblers_image
)

endlocal

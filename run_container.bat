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

docker rm -f assemblers_cont
docker run -it --name assemblers_cont --mount type=bind,source="%DATA_PATH%",target=%TARGET_PATH% assemblers_image
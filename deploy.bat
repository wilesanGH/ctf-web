@echo off
rem Change to the project directory
cd C:\Users\wiles\Documents\ctf-web

rem Build MkDocs documentation
mkdocs build

rem Stage all changes
git add .

rem Prompt user to enter a commit message
set /p commit_msg=Enter your commit message: 

rem Check if the commit message is empty
if "%commit_msg%"=="" (
    echo Commit message cannot be empty. Aborting.
    pause
    exit /b
)

rem Commit with the user's input
git commit -m "%commit_msg%"

rem Push to the remote main branch
git push origin main

pause 
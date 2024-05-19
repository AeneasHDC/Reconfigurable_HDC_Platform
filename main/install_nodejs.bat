@echo off
echo Installing npm packages...

npm install open && (
    echo Installed open successfully.
    npm install express && (
        echo Installed express successfully.
        npm install body-parser && (
            echo Installed body-parser successfully.
            npm init -y && (
                echo Initialized npm successfully.
                echo Installation completed successfully.
                pause
            ) || (
                echo Failed to initialize npm
                exit /b %errorlevel%
            )
        ) || (
            echo Failed to install body-parser
            exit /b %errorlevel%
        )
    ) || (
        echo Failed to install express
        exit /b %errorlevel%
    )
) || (
    echo Failed to install open
    exit /b %errorlevel%
)

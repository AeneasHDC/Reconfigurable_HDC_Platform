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
                echo Installing Python packages...

                python -m pip install -r ./requirements.txt && (
                    echo Installed Python packages successfully.
                    echo Running the Jupyter Notebook server and Loading the GUI...
                    
                    python ./main/run_server.py && (
                        call ./main/run_server2.bat && (
                            echo Jupyter Notebook server and GUI loaded successfully.
                            pause
                        ) || (
                            echo Failed to load the GUI via run_server2.bat
                            pause
                            exit /b %errorlevel%
                        )
                    ) || (
                        echo Failed to run the Jupyter Notebook server
                        pause
                        exit /b %errorlevel%
                    )
                ) || (
                    echo Failed to install Python packages
                    pause
                    exit /b %errorlevel%
                )
            ) || (
                echo Failed to initialize npm
                pause
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

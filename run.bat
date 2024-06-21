:: This script installs the necessary npm and Python packages, initializes npm, runs the Jupyter Notebook server, and loads the GUI.
:: If any step fails, the script will display an error message and exit with the corresponding error code.
:: Authors: Marco Angioli, Saeid Jamili
:: Date: 05/2024
:: License:
::    Copyright 2024 Sapienza University of Rome
::
::    Licensed under the Apache License, Version 2.0 (the "License");
::    you may not use this file except in compliance with the License.
::    You may obtain a copy of the License at
::    
::        http://www.apache.org/licenses/LICENSE-2.0
::    
::    Unless required by applicable law or agreed to in writing, software
::    distributed under the License is distributed on an "AS IS" BASIS,
::    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
::    See the License for the specific language governing permissions and
::    limitations under the License.
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

/*
 @brief: This file is the server-side code for the AeneasHDC project. It is responsible for serving the static files, handling the API requests, and starting the server. The server listens on port 3000 and serves the static files from the current directory. It also listens for API requests to save, list, rename, delete, and copy projects. The server also listens for API requests to save the configuration data.
 @note: The server is started by running the command node server.js in the terminal. The server can be accessed at http://localhost:3000.
 @License:
    Copyright 2024 Sapienza University of Rome

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
  @Authors: Marco Angioli & Saeid Jamili
  @Version: 1.0
  @Date: May 2024
*/
const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const open = require('open');
const PORT = 3000;

// Serve static files from the current directory
app.use(express.static(__dirname));

// Parse JSON payloads
app.use(bodyParser.json());

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    console.log('Redirecting to main page');
    open(`http://localhost:${PORT}`);
});

app.get('/', (req, res) => {
    res.redirect('/main/html/main_page.html');
  });
  
// Route to handle new notebook creations
app.post('/save-project', (req, res) => {
    const { notebookPath } = req.body; // This should be the path to the notebook file relative to the server's directory.

    const timestamp = new Date().toISOString().replace(/[:.-]/g, '').replace('T', '_').slice(0, 15);
    const backupFolder = 'AeneasHDC-Projects';
    const newFilename = `AeneasHDC - New Project_${timestamp}.ipynb`;
    const newPath = path.join(__dirname, backupFolder, newFilename);

    // Ensure the backup directory exists
    if (!fs.existsSync(path.join(__dirname, backupFolder))) {
        fs.mkdirSync(path.join(__dirname, backupFolder), { recursive: true });
    }

    // Copy the file
    const command = `cp "${path.join(__dirname, notebookPath)}" "${newPath}"`;
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error('Error during the backup process:', stderr);
            res.status(500).send({ success: false, message: 'Backup failed' });
            return;
        }
        res.send({ success: true, newPath: newPath.replace(__dirname, '') });
    });
});

// Route to handle the config save request
app.post('/save-config', (req, res) => {
    const newConfigData = req.body;
    const configPath = path.join(__dirname, 'config.json');
  
    // Load existing config
    let configData;
    try {
      configData = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    } catch (err) {
      return res.status(500).json({ success: false, message: 'Failed to read config file.' });
    }
  
    // Merge new data with existing config
    configData = { ...configData, ...newConfigData };
  
    // Save updated config
    fs.writeFile(configPath, JSON.stringify(configData, null, 2), (err) => {
      if (err) {
        return res.status(500).json({ success: false, message: 'Failed to save config file.' });
      }
      res.json({ success: true });
    });
  });

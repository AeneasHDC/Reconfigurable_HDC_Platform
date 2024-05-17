const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();


const PORT = 3000;

// Serve static files from the current directory
app.use(express.static(path.join(__dirname, '..', )));

// Parse JSON payloads
app.use(bodyParser.json());

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    console.log('Redirecting to main page');
    console.log("Actual path: ", __dirname)
    require('child_process').exec(`start http://localhost:${PORT}/`);

});

app.get('/', (req, res) => {
    res.redirect('/main/html/main_page.html');
  });
  
// Route to handle new notebook creations
app.post('/save-project', (req, res) => {
    const { notebookPath } = req.body; // This should be the path to the notebook file relative to the server's directory.

    const timestamp = new Date().toISOString().replace(/[:.-]/g, '').replace('T', '_').slice(0, 15);
    const backupFolder = 'projects';
    const newFilename = `AeneasHDC-New_Project_${timestamp}.ipynb`;
    const newPath = path.join(__dirname, '..', backupFolder, newFilename);    

    // Ensure the backup directory exists
    if (!fs.existsSync(path.join(__dirname, backupFolder))) {
        fs.mkdirSync(path.join(__dirname, backupFolder), { recursive: true });
    }

    // Copy the file
    // Use fs.copyFile to copy the file
    fs.copyFile(notebookPath, newPath, (err) => {
      if (err) {
          console.error('Error during the backup process:', err);
          res.status(500).send({ success: false, message: 'Backup failed' });
          return;
      }
      res.send({ success: true, newPath: newPath.replace(__dirname, '') });
  });

  console.log('New path:', newPath);
  console.log('Opening Jupyter Notebook')
  open_file = path.join("http://localhost:8888/notebooks", backupFolder, newFilename); 
  console.log('Open file:', open_file)
  require('child_process').exec(`start ${open_file}`);

});

// Route to handle the list projects request
app.get('/list-projects', (req, res) => {
  const directoryPath = path.join(__dirname, '..', 'projects');

  fs.readdir(directoryPath, (err, files) => {
      if (err) {
          res.status(500).send({
              message: "Unable to scan files!",
              error: err
          });
          return;
      }

      const projects = files.filter(file => file.endsWith('.ipynb')).map(file => {
          const filePath = path.join(directoryPath, file);
          const stats = fs.statSync(filePath); // Synchronously get stats of the file
          return {
              name: file,
              lastModified: stats.mtime // 'mtime' is the last modified time
          };
      });

      res.send(projects);
  });
});


// Route to handle the rename project request
app.post('/rename-project', (req, res) => {
  const { oldPath, newPath } = req.body;
  fs.rename(path.join(__dirname, '..', oldPath), path.join(__dirname, '..', newPath), err => {
      if (err) {
          console.error('Error renaming file:', err);
          return res.status(500).send({ success: false, message: 'Failed to rename file' });
      }
      res.send({ success: true, message: 'File renamed successfully' });
  });
});

// Route to handle the delete project request
app.delete('/delete-project', (req, res) => {
  const { filePath } = req.body;
  fs.unlink(path.join(__dirname, '..', filePath), err => {
      if (err) {
          console.error('Error deleting file:', err);
          return res.status(500).send({ success: false, message: 'Failed to delete file' });
      }
      res.send({ success: true, message: 'File deleted successfully' });
  });
});


// Route to handle the copy project request
app.post('/copy-project', (req, res) => {
  const { sourcePath, destinationPath } = req.body;
  fs.copyFile(path.join(__dirname, '..', sourcePath), path.join(__dirname, '..', destinationPath), err => {
      if (err) {
          console.error('Error copying file:', err);
          return res.status(500).send({ success: false, message: 'Failed to copy file' });
      }
      res.send({ success: true, message: 'File copied successfully' });
  });
});


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
  
    // Deep merge function to update configData with newConfigData
    function deepMerge(target, source) {
      for (const key in source) {
        if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
          if (!target[key]) target[key] = {};
          deepMerge(target[key], source[key]);
        } else {
          target[key] = source[key];
        }
      }
      return target;
    }
  
    // Merge new data with existing config
    configData = deepMerge(configData, newConfigData);
  
    // Save updated config
    fs.writeFile(configPath, JSON.stringify(configData, null, 2), (err) => {
      if (err) {
        return res.status(500).json({ success: false, message: 'Failed to save config file.' });
      }
      res.json({ success: true });
    });
  });
  
const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

// Serve static files from the current directory
app.use(express.static(__dirname));

// Parse JSON payloads
app.use(bodyParser.json());

// Route to handle the config save request
app.post('/save-config', (req, res) => {
    const configData = req.body;
    try {
        fs.writeFileSync(path.join(__dirname, 'config.json'), JSON.stringify(configData, null, 2));
        res.send({ success: true });
    } catch (error) {
        console.error('Error saving config:', error);
        res.status(500).send({ success: false, message: 'Failed to save config' });
    }
});
// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

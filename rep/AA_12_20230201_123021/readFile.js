document.addEventListener('DOMContentLoaded', function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'config.txt', true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            processFileContent(xhr.responseText);
        }
    };
    xhr.send();
});

function processFileContent(content) {
    // Split the content into lines
    const lines = content.trim().split('\n');

    // Get the table body element to insert the new rows
    const tableBody = document.getElementById('config-table').getElementsByTagName('tbody')[0];

    // Process each line to extract parameters and values
    lines.forEach(line => {
        line = line.replace(/\s+/g, '');  // Removing spaces
        if (line.startsWith('local')) {
            const parts = line.split('=');
            const parameter = parts[0].split(' ')[1];  // Extract parameter name
            const value = parts[1].replace(';', '');   // Extract value

            // Create a new row and populate it
            const newRow = tableBody.insertRow();
            const cell1 = newRow.insertCell(0);
            const cell2 = newRow.insertCell(1);
            cell1.innerHTML = parameter;
            cell2.innerHTML = value;
        }
    });
}
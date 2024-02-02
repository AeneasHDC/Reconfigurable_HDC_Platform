function loadReport(filePath) {
        let reportSection = document.getElementById('reportSection');
        
        // Show the loading text
        document.getElementById('loadingText').style.display = 'block';

        // Remove previous iframe if it exists
        let existingIframe = reportSection.querySelector('iframe');
        if (existingIframe) {
            existingIframe.remove();
        }

        // Create a new iframe to load the report
        let iframe = document.createElement('iframe');
        iframe.src = filePath;
        iframe.style.width = '100%';
        iframe.style.height = '2000px'; // Set initial height to 0
        iframe.style.opacity = '0'; // Set initial opacity to 0 for fade effect
        iframe.style.transition = 'opacity 0.5s'; // Transition effect
        
        reportSection.appendChild(iframe);

        setTimeout(() => {
            document.getElementById('loadingText').style.display = 'none';
            iframe.style.opacity = '1'; // Fade in the iframe content
            iframe.onload = function() {
                iframe.style.height = iframe.contentWindow.document.body.scrollHeight + 'px';
            };
        }, 1000); 
    }


    function sortTable(n) {
        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        table = document.querySelector("table");
        switching = true;
        dir = "asc";
        while (switching) {
            switching = false;
            rows = table.rows;
            for (i = 1; i < (rows.length - 1); i++) {
                shouldSwitch = false;
                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];
                if (dir == "asc") {
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir == "desc") {
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                }
            }
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                switchcount++;
            } else {
                if (switchcount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
    }


    $(document).ready(function() {
        $('#configTable').DataTable({
            "pageLength": 25
        });
    });
    
    function toggleContent(element, contentId) {
        const content = document.getElementById(contentId);
        if (element.classList.contains('active')) {
            element.classList.remove('active');
            content.classList.remove('active');
        } else {
            element.classList.add('active');
            content.classList.add('active');
        }
    }
    

    function openHelp(section) {
        switch (section) {
            case 'generalInfo':
                window.open('help.html#generalInfo', '_blank');
                break;
            // Add more cases for other sections.
            default:
                window.open('help.html', '_blank');
        }
    }
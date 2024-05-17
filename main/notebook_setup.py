
from IPython.display import display, HTML
def setup_html_css():
    
    html_code = """
    <div id="particles-js-left"></div>
    <div id="particles-js-right"></div>
    <div id="logo-container">
        <img src="../doc/img/logo/AeneasHDC_white.png" alt="AeneasHDC Logo" id="aeneas-logo"/>
    </div>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script>
        particlesJS('particles-js-left', {
                particles: {
                    number: { value: 100, density: { enable: true, value_area: 800 } },
                    color: { value: "#a0a0a0" },
                    shape: { type: "circle", stroke: { width: 0, color: "#000000" } },
                    opacity: { value: 0.5, random: true },
                    size: { value: 4, random: true },
                    line_linked: { enable: true, distance: 100, color: "#a0a0a0", opacity: 0.2, width: 1.5 },
                    move: { enable: true, speed: 2, bounce: true }
                }
            });
        particlesJS('particles-js-right', {
                particles: {
                    number: { value: 100, density: { enable: true, value_area: 800 } },
                    color: { value: "#a0a0a0" },
                    shape: { type: "circle", stroke: { width: 0, color: "#000000" } },
                    opacity: { value: 0.5, random: true },
                    size: { value: 4, random: true },
                    line_linked: { enable: true, distance: 100, color: "#a0a0a0", opacity: 0.2, width: 1.5 },
                    move: { enable: true, speed: 2, bounce: true }
                }
            });
    </script>
    <style>
    /* Ensures the main background of the Jupyter interface matches the page style */
    #site {
        background: radial-gradient(circle at center, #0A1931, #161616) !important;
    }
    #particles-js-left {
      position: fixed;
      width: 20%;
      height: 100%;
      z-index: -10;
      top: 0;
      left: 0;
    }
    #particles-js-right {
      position: fixed;
      width: 20%;
      height: 100%;
      z-index: -10;
      top: 0;
      right: 0;
    }


    /* Ensure cell outputs are also above the particles */
    .notebook_app .cell .output {
        z-index: 10 !important;
        position: relative;
    }

    .cell .container {
        background-color: #ffffff !important; /* Change to any color you want for the cells */
    }

    .cell .input, .cell .output {
        background-color: #ffffff !important; /* Change to any color you want for the cells */
        opacity: 1 !important;
    }
    #logo-container {
      position: fixed;
      top: 15%; /* Adjust the value to place it where you want */
      left: 100px; /* Adjust the value to place it where you want */
      z-index: 20; /* Above the particles */
    }
    #aeneas-logo {
      width: 200px; /* Adjust the size as needed */
      height: auto;
    }
    </style>


    <head>
    <!-- Add Font Awesome CDN link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <style>
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(30px);}
            to {opacity: 1; transform: translateY(0);}
        }
        #myMenu {
            animation: fadeIn 0.5s ease-out;
            position: fixed;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            background-color: #fff; /* Set to white */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 100; /* Ensure it's above other elements */
        }
        #myMenu ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        #myMenu li {
            font-size: 36px;
            margin-bottom: 20px; /* Reduced space after h1 */
            color: #2D3748; /* Logo color */
            cursor: pointer;
            transition: transform 0.3s;
            text-align: center; /* Ensure text is centered */
        }
        #myMenu li:hover {
            transform: scale(1.3);
        }
    </style>
    <div id='myMenu'>
        <ul>
            <li onclick="window.location='./main/main.html';" title="Home">
                <i class="fas fa-home"></i> <!-- Font Awesome Home icon -->
            </li>
            <li onclick="window.open('./doc/reference_manual.pdf');" title="Help">
                <i class="fas fa-question-circle"></i> <!-- Font Awesome Help icon -->
            </li>
        </ul>
    </div>
    
    """
    display(HTML(html_code))
    

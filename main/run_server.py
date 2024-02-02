import os
import subprocess
import sys
import webbrowser

def find_anaconda_root():
    # Tries to find the Anaconda root directory from the system path.
    for path in os.environ['PATH'].split(os.pathsep):
        if 'anaconda' in path.lower() and 'Scripts' in path:
            return os.path.dirname(path)
    return None

def main():
    anaconda_root = "C:/Users/disa/anaconda3/"#find_anaconda_root()
    if not anaconda_root:
        print("Anaconda installation not found.")
        sys.exit(1)

    cwp_path = os.path.join(anaconda_root, 'cwp.py')
    python_path = os.path.join(anaconda_root, 'python.exe')
    jupyter_path = os.path.join(anaconda_root, 'Scripts', 'jupyter-notebook-script.py')
    
    # Set the notebook directory to the current directory where this script is running
    notebook_directory = os.getcwd()
    print(notebook_directory)

    # Run the cwp.py script to set up the Anaconda environment asynchronously
    subprocess.Popen([python_path, cwp_path, anaconda_root, python_path, jupyter_path, notebook_directory])
    
    

if __name__ == "__main__":
    main()

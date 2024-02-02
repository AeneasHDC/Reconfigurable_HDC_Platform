
import os
import sys
import subprocess


sys.path.append('src/config/')
import config_py as config


class Requirments:

    @staticmethod
    def install_requirments():
        """
        Installs packages from requirements.txt and provides a summarized report.
        """
        result = subprocess.check_output("pip install -r ./requirements.txt", stderr=subprocess.STDOUT, shell=True).decode('utf-8')
        lines = result.split("\n")
        installed = [line for line in lines if "Successfully installed" in line]
        already_satisfied = [line for line in lines if "Requirement already satisfied" in line]
        summary = {
            "Successfully Installed": len(installed),
            "Already Satisfied": len(already_satisfied),
            "Total Requirements": len(lines)
        }

        for key, value in summary.items():
            print(f"{key}: {value}")

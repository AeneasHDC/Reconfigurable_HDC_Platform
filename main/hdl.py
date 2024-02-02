import sys
import subprocess
import json
import matplotlib.pyplot as plt
import seaborn as sns
from typing import Optional
from pathlib import Path
from typing import Dict, Optional
import shutil
import subprocess
import time
import threading

sys.path.append('src/config/')
import config_py as config


class HDL:
    
    def extract_values( data: Dict, fields: list) -> Dict:
        extracted_values = {}
        for row in data["RptDoc"]["section"][0]["table"]["tablerow"]:
            if "tablecell" in row:
                name = row["tablecell"][0]["@contents"]
                if name in fields:
                    extracted_values[name] = int(row["tablecell"][1]["@contents"])
    
        return extracted_values
    
    def strip_whitespace_from_keys(data: Dict[str, str]) -> Dict[str, str]:
        for key, value in data.items():
            if isinstance(value, dict):
                HDL.strip_whitespace_from_keys(value)
            elif isinstance(value, list):
                for item in value:
                    if isinstance(item, dict):
                        HDL.strip_whitespace_from_keys(item)
            elif key == "@contents":
                data[key] = value.strip()
        return data


    @staticmethod
    def _run_external_script(script_path: str, arg: str):
        process = subprocess.Popen(['python', script_path, arg], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True); 
        process.communicate() 

    @staticmethod
    def run_script_with_timeout(script_path: str, arg: str, timeout: int):
        thread = threading.Thread(target=HDL._run_external_script, args=(script_path, arg))
        thread.start()

        #thread.join(timeout=timeout)
        thread.join()
        if thread.is_alive():
            print("The script took too long! Terminating...")

    @staticmethod
    def run_simulation():
        if config.HDL_LANG == config.HLS:
            HDL.run_script_with_timeout("./main/hls_xilinx.py", "vitis", 500)
            HDL.get_timing_report()
        
    @staticmethod
    def run_synthesis():
        HDL.run_script_with_timeout("./main/hls_xilinx.py", "synth_viv", 500)
        HDL.get_resource_usage_report()
        HDL.get_power_estimation_report()
        


    @staticmethod
    def _get_report_from_file( file_path: str):
        with open(file_path, 'r') as f:
            return json.load(f)
        
    @staticmethod
    def get_simulation_result(file: Optional[str] = "./out/hls/sim_result.json"):
        return HDL._get_report_from_file(file)

    @staticmethod
    def get_resource_usage_report(file: Optional[str] = "./out/hls/resource_util.json"):
        
        data = HDL._get_report_from_file(file)

        data = HDL.strip_whitespace_from_keys(data)
    
        desired_keys = ["LUT as Logic", "LUT as Memory", "LUT as Distributed RAM", "LUT as Shift Register", 
                        "CLB Registers", "Register as Flip Flop", "Register as Latch", "CARRY8", "DSPs"]
    
        results = {}
        total_LUTs = 0
        total_FF = 0
    
        sections = data["RptDoc"]["section"]
        for section in sections:
            table_rows = section.get("table", {}).get("tablerow", [])
            if isinstance(table_rows, list):
                for row in table_rows[1:]:
                    key = row["tablecell"][0]["@contents"]
                    
                    try:
                        value = int(row["tablecell"][1]["@contents"])
                    except ValueError: # Handling floats
                        value = round(float(row["tablecell"][1]["@contents"]))
                    
                    if key in desired_keys:
                        results[key] = value
                        if "LUT" in key:
                            total_LUTs += value
                        elif "Register" in key or "CLB Registers" == key:
                            total_FF += value
    
        results["Total LUTs"] = total_LUTs
        results["Total FF"] = total_FF

        json_path = "./out/hls/hdl_resource_report.json"
        with open(json_path, 'w') as f:
            json.dump(results, f, indent=4)
            
        return results

    @staticmethod
    def get_power_estimation_report( file: Optional[str] = "./out/hls/power_estimation.json") -> Dict[str, float]:
        with open(file, 'r') as f:
            data = json.load(f)
    
        data = HDL.strip_whitespace_from_keys(data)

        power_keys = ["Dynamic (W)", "Device Static (W)"]
    
        results = {}
        # Extract power values
        sections = data["RptDoc"]["section"]
        for section in sections:
            if section["@title"] == "Summary":
                for row in section["table"]["tablerow"]:
                    key = row["tablecell"][0]["@contents"].strip()
                    if key in power_keys:
                        value = row["tablecell"][1]["@contents"].strip().replace("<", "").replace(" ", "")
                        results[key] = float(value)


            power_data = {
                "powerConsumptionInfo": [
                    {
                        "category": "Static Power Consumption",
                        "value": results["Dynamic (W)"]
                    },
                    {
                        "category": "Dynamic Power Consumption",
                        "value": results["Device Static (W)"]
                    }
                ]
            }
            # Save power data to JSON file
            json_path = f"./out/hls/hdl_power_consumption.json"
            with open(json_path, "w") as json_file:
                json.dump(power_data, json_file, indent=4)

        return results

    @staticmethod
    def get_timing_report(file: Optional[str] = "./out/hls/lat.rpt"):
        report_dict = {}
        with open(file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                if "=" in line:
                    key, value = line.split('=')
                    key = key.strip().replace('$', '')
                    value = int(value.strip().replace('"', ''))
                    report_dict[key] = value
        report_dict["TOTAL_EXECUTE_TIME_ADJUSTED"] = (report_dict["TOTAL_EXECUTE_TIME"] * (1000/config.OP_FREQ))/3
        json_path = f"./out/hls/hdl_timming_report.json"
        with open(json_path, 'w') as f:
            json.dump(report_dict, f, indent=4)

        return report_dict["TOTAL_EXECUTE_TIME_ADJUSTED"]
    
    
    @staticmethod
    def get_eval(filep: Optional[str] = './out/hls/hls_report.json'):
        try:
            with open(filep, 'r') as file:
                data = json.load(file)
                return data
        except Exception as e:
            print(f"Error reading the JSON file: {e}")
            return None
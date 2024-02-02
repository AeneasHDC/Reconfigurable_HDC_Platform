import os
import pandas as pd
import json
from data_exceptions import DatasetNotFoundError, DataFileNotFoundError, InvalidDatasetError

class Dataset:
    
    def __init__(self, dataset_dir='./datasets/'):
        self.dataset_dir = dataset_dir

    def _dataset_exists(self, dataset_name):
        return dataset_name in self.list_datasets()

    def list_datasets(self):
        return [d for d in os.listdir(self.dataset_dir) if os.path.isdir(os.path.join(self.dataset_dir, d))]

    def info(self, dataset_name):
        if not self._dataset_exists(dataset_name):
            raise DatasetNotFoundError(f"{dataset_name} does not exist!")
        
        info_path = os.path.join(self.dataset_dir, dataset_name, 'dataset_info.json')
        with open(info_path, 'r') as f:
            dataset_info = json.load(f)
        return dataset_info

    def _get_data(self, dataset_name, data_type):
        if not self._dataset_exists(dataset_name):
            raise DatasetNotFoundError(f"{dataset_name} does not exist!")
        data_path = os.path.join(self.dataset_dir, dataset_name, f"{dataset_name}_{data_type}.csv")
        if not os.path.exists(data_path):
            raise DataFileNotFoundError(f"{data_type} data for {dataset_name} not found!")
        return pd.read_csv(data_path)

    def dataset_statistics(self, dataset_name, data_type):
        data = self._get_data(dataset_name, data_type)
        return data.describe()

    def import_data(self, source_path, dataset_name, data_type):
        destination_dir = os.path.join(self.dataset_dir, dataset_name)
        if not os.path.exists(destination_dir):
            os.makedirs(destination_dir)
        destination_path = os.path.join(destination_dir, f"{dataset_name}_{data_type}.csv")
        pd.read_csv(source_path).to_csv(destination_path, index=False)

    def export_data(self, dataset_name, data_type, export_path):
        data = self._get_data(dataset_name, data_type)
        data.to_csv(export_path, index=False)
class DatasetNotFoundError(Exception):
    """Raised when the dataset is not found."""
    pass

class DataFileNotFoundError(Exception):
    """Raised when the data file within a dataset is not found."""
    pass

class InvalidDatasetError(Exception):
    """Raised when the dataset is not valid or missing necessary files."""
    pass
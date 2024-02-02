import os

from dataset import Dataset
from visualizer import Visualizer
from configuration  import Configuration 
from model_class  import Model_class 
from vectorutils import VectorUtils
from visualizer import Visualizer
from hdl import HDL
from req import Requirments
from rep_gen import Report
from utils import Utils
from prj import PRJ

class Aeneas:

    dataset = Dataset()
    visualizer = Visualizer(dataset)
    configuration = Configuration()
    model = Model_class()
    vectorutils = VectorUtils()
    hdl = HDL()
    report = Report()
    requirments = Requirments()
    utils = Utils()
    prj = PRJ()
import sys
import json
from datetime import datetime
import numpy as np 
import matplotlib.pyplot as plt
from main import Aeneas
import os
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np



def change_config(aeneas, dim=None, hd_mode=None, sparsity_factorx10=None, parallel_features=None, parallel_classes=None, frame=None, 
                  hvtype=None, similarity=None, clip=None, lv_mode_model=None, lv_len = None, bv_mode=None, 
                  lv_mode=None, cv_mode=None, hw_train=None, retrain_in_hw=None,
                  encoding_technique=None, n_gram=None, n_gram_size=None, lr=None, lr_decay=None, 
                  dataset_name=None, dataset_size=None, dataset_train_size=None, dataset_test_size=None, dataset_validation_size=None,
                  dataset_feature_size=None,dataset_data_type=None, dataset_data_range_min=None, dataset_data_range_max=None, 
                  dataset_classes_size=None, epoch=None, problem_type=None):

    aeneas.configuration.read()

    # --------------------------------HYPERSPACE PROPERTY-------------------------------------------
    # HV dimension
    if dim is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_DIM'] = dim
    
    # HV mode
    if hd_mode is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_MODE']['selected'] = hd_mode

    # HV sparsity
    if sparsity_factorx10 is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['SPARSITY_FACTOR_X10'] = sparsity_factorx10

    # HV type
    if hvtype is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_DATA_TYPE']['selected'] = hvtype

    # Similarity Measure
    if similarity is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_SIMI_METHOD']['selected'] = similarity

    # Level Vector Length
    if lv_len is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_LV_LEN'] = lv_len

    # Clipping
    if clip is not None:
        aeneas.configuration.config_data['CLIPPING']['CLIPPING_CLASS']['selected'] = clip
        if clip=="CLIPPING_BINARY":
            aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_DATA_W_BITS'] = 1
        elif clip=="CLIPPING_TERNARY":
            aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_DATA_W_BITS'] = 3 
        elif clip =="CLIPPING_QUANTIZED" or clip == "CLIPPING_QUANTIZED_POWERTWO":
            aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_DATA_W_BITS'] = 6 #int(np.ceil(np.log2(aeneas.configuration.config_data['CLIPPING']['QUANT_MAX'])))
        else:
            aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_DATA_W_BITS'] = int(np.ceil(np.log2(epoch*aeneas.configuration.config_data['dataset']['DS_INFO']['DS_TRAIN_SIZE'])))
    # ------------------------------------------------------------------------------------    

    # --------------------------------HARDWARE PARALLELISM-------------------------------------------
    # Partial processing: Element Parallelism
    if frame is not None:
        aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['DI_PARALLEL_W_BITS'] = frame
        aeneas.configuration.config_data['hw_interface']['LV_MODES']['LV_IN_DATA_W_BITS']        = frame
        aeneas.configuration.config_data['hw_interface']['BV_MODES']['BV_IN_DATA_W_BITS']        = frame
        aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_IN_DATA_W_BITS']        = frame
        aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['FRAME_SIZE_MIN']     = frame

    # Partial processing: Feature Parallelism
    if parallel_features is not None:
        aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['PARALLELISM_FEATURES'] = parallel_features
        if parallel_features!=1:
            aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['IN_DATA_MODE']['selected'] = "DI_M_PARALLEL"
        else:
            aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['IN_DATA_MODE']['selected'] = "DI_M_STREAM"

    # Partial processing: Class Parallelism
    if parallel_classes is not None:
        aeneas.configuration.config_data['hw_interface']['DATA_INTERFACE']['PARALLELISM_CLASS'] = parallel_classes
    # ------------------------------------------------------------------------------------

    # --------------------------------HV generation-------------------------------------------
    # Level method technique on model
    if lv_mode_model is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['HD_LV_TYPE']['selected'] = lv_mode_model

    # BaseVector Generation Mode:
    if bv_mode is not None:
        aeneas.configuration.config_data['hw_interface']['BV_MODES']['BV_MODE']['selected'] = bv_mode

    # LevelVector Generation Mode:
    if lv_mode is not None:
        aeneas.configuration.config_data['hw_interface']['LV_MODES']['LV_MODE']['selected'] = lv_mode

    # ClassHVs Generation Mode:
    if cv_mode is not None:
        aeneas.configuration.config_data['hw_interface']['CV_MODES']['CV_MODE']['selected'] = cv_mode
    # ------------------------------------------------------------------------------------

    # --------------------------------ENCODING-------------------------------------------
    # Encoding technique
    if encoding_technique is not None:
        aeneas.configuration.config_data['HD_ENCODING']['ENCODING_TECHNIQUE']['selected'] = encoding_technique

    # Temporal encoding, N-grams
    if n_gram is not None:
        aeneas.configuration.config_data['HD_ENCODING']['N_GRAM'] = n_gram

    # Temporal encoding, N-gram size
    if n_gram_size is not None:
        aeneas.configuration.config_data['HD_ENCODING']['N_GRAM_SIZE'] = n_gram_size
    # ------------------------------------------------------------------------------------
        
    # --------------------------------TRAINING & RETRAINING-------------------------------------------
    # Train in Hardware
    if hw_train is not None:
        aeneas.configuration.config_data['train']['TRAINING_INFO']['TRAIN_ON_HW'] = hw_train
    # not sure if something else is needed here

    # Retrain in hw
    if retrain_in_hw is not None:
        aeneas.configuration.config_data['train']['TRAINING_INFO']['TRAIN_ON_HW'] = retrain_in_hw
    
    # Learning rate
    if lr is not None:
        aeneas.configuration.config_data['LEARNING_RATE']['MAX_LEARNING_RATE'] = lr
    
    # Learning rate decay:
    if lr_decay is not None:
        aeneas.configuration.config_data['LEARNING_RATE']['LR_DECAY']['selected']  = lr_decay    
    # ------------------------------------------------------------------------------------
    
    # --------------------------------- DATASET -------------------------------------------
    # Dataset name
    if dataset_name is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_NAME'] = dataset_name

    # Dataset size
    if dataset_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_SIZE'] = dataset_size
    
    if dataset_train_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_TRAIN_SIZE'] = dataset_train_size

    if dataset_test_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_TEST_SIZE'] = dataset_test_size

    if dataset_validation_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_VALIDATION_SIZE'] = dataset_validation_size

    # Dataset feature size
    if dataset_feature_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_FEATURE_SIZE'] = dataset_feature_size

    # Dataset data type
    if dataset_data_type is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_DATA_TYPE'] = dataset_data_type

    # Dataset data range min and max
    if dataset_data_range_min is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_DATA_RANGE_MIN'] = dataset_data_range_min
    
    if dataset_data_range_max is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_DATA_RANGE_MAX'] = dataset_data_range_max

    # Dataset classes size
    if dataset_classes_size is not None:
        aeneas.configuration.config_data['dataset']['DS_INFO']['DS_CLASSES_SIZE'] = dataset_classes_size

    # Problem Type
    if problem_type is not None:
        aeneas.configuration.config_data['HDC']['HD_INFO']['PROBLEM_TYPE']['selected']=problem_type
    # ------------------------------------------------------------------------------------

    #---------------------------------SAVE AND COMPILE-------------------------------------------
    aeneas.configuration.save()
    aeneas.configuration.compile()

    # Print the configuration
    aeneas.configuration.print()
    # ------------------------------------------------------------------------------------

# -------------------------------- TESTS HEADER ------------------------------------------
# Common functions
def setup_test(aeneas, test_id, test_name, summary):
    aeneas.prj.set_name(test_name)
    aeneas.prj.set_id(test_id)
    aeneas.prj.set_test_summary(summary)
    aeneas.prj.date = datetime.now()
    aeneas.prj.time = datetime.now()

def collect_data(aeneas, run_sw_model):
    report = {}
    if (run_sw_model==1):
        print("Running sw model...")
        report['ModelResults'] = aeneas.model.run()
        report['ModelEval'] = aeneas.model.get_eval()
    
    print("Running HW model...")
    aeneas.hdl.run_simulation()
    print("Simulation finished...running synthesis")
    aeneas.hdl.run_synthesis()
    report['HD_Eval'] = aeneas.hdl.get_eval()
    report['ResourceUtility'] = aeneas.hdl.get_resource_usage_report()
    report['PowerReport'] = aeneas.hdl.get_power_estimation_report()
    report['TimingReport'] = aeneas.hdl.get_timing_report()
    report['Speed'] = 1e9 / report['TimingReport']
    return report

def save_test_results(aeneas, test_name, all_reports):
    if not os.path.exists(f"./rep/tmp/{test_name}"):
        os.mkdir(f"./rep/tmp/{test_name}")
    np.save(f"./rep/tmp/{test_name}/{test_name}.npy", all_reports)
# ------------------------------------------------------------------------------------

'''
Test 1: HV Dimension (HD_DIM)
Tests the impact of different Hyperdimensional Vector (HDV) sizes.
'''
def test_hd_dim(aeneas, hd_dim_range):
    setup_test(aeneas, 1, 'Test_HD_DIM', 'Testing different HV dimensions.')
    all_reports = []
    for dim in hd_dim_range:
        change_config(aeneas, dim=dim)
        report = collect_data(aeneas,1)
        report['HD_DIM'] = dim
        all_reports.append(report)
    save_test_results(aeneas, 'Test_HD_DIM', all_reports)
    return all_reports

'''
Test 2: HV Sparsity (sparsity_factorx10)
Evaluates the effect of different sparsity levels on the HDV.
'''
def test_hd_sparsity(aeneas, sparsity_range):
    setup_test(aeneas, 2, 'Test_Sparsity', 'Testing different sparsity factors.')
    all_reports = []
    for sparsity in sparsity_range:
        change_config(aeneas, hd_mode="SPARSE", sparsity_factorx10=sparsity)
        report = collect_data(aeneas,1)
        report['Sparsity'] = sparsity
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Sparsity', all_reports)
    change_config(aeneas, hd_mode="DENSE")
    return all_reports

'''
Test 3: HV Type (HD_DATA_TYPE)
Analyzes the performance with different HV types.
'''
def test_hd_type(aeneas, hd_type_options):
    setup_test(aeneas, 3, 'Test_HD_Type', 'Testing different HV types.')
    all_reports = []
    for hv_type in hd_type_options:
        change_config(aeneas, hvtype=hv_type)
        report = collect_data(aeneas,1)
        report['HV_Type'] = hv_type
        all_reports.append(report)
    save_test_results(aeneas, 'Test_HD_Type', all_reports)
    return all_reports

'''
Test 4: Learning Rate (LR)
Investigates how different learning rates affect model performance.
'''
def test_learning_rate(aeneas, lr_values):
    setup_test(aeneas, 4, 'Test_LR', 'Testing different learning rates.')
    all_reports = []
    for lr in lr_values:
        change_config(aeneas, lr=lr)
        report = collect_data(aeneas,1)
        report['Learning_Rate'] = lr
        all_reports.append(report)
    save_test_results(aeneas, 'Test_LR', all_reports)
    return all_reports

'''
Test 5: Frame Parallelism (FRAME)
Tests the impact of processing different numbers of HV elements in parallel.
'''
def test_frame_parallelism(aeneas, frame_range, dim):
    setup_test(aeneas, 5, 'Test_FRAME', f'Testing different FRAME sizes with fixed HD_DIM = {dim}.')
    all_reports = []
    idx = 0
    for frame in frame_range:
        change_config(aeneas, frame=frame, dim=dim)
        if (idx==0):
            report = collect_data(aeneas, 1)
            idx=1
        else:
            report = collect_data(aeneas, 0)
        
        report['Frame'] = frame
        all_reports.append(report)
    save_test_results(aeneas, 'Test_FRAME', all_reports)
    return all_reports

'''
Test 6: Feature Parallelism (PARALLELISM_FEATURES)
Assesses how parallel processing of features influences resource utilization and performance.
'''
def test_feature_parallelism(aeneas, parallel_features_range):
    setup_test(aeneas, 6, 'Test_Feature_Parallelism', 'Testing different levels of feature parallelism.')
    all_reports = []
    idx=0
    for parallel_features in parallel_features_range:
        change_config(aeneas, parallel_features=parallel_features)
        if (idx==0):
            report = collect_data(aeneas, 1)
            idx=1
        else:
            report = collect_data(aeneas, 0)
        report['Feature_Parallelism'] = parallel_features
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Feature_Parallelism', all_reports)
    return all_reports

'''
Test 7: Class Parallelism (PARALLELISM_CLASS)
Evaluates the effects of parallel processing of classes on the system.
'''
def test_class_parallelism(aeneas, parallel_classes_range):
    setup_test(aeneas, 7, 'Test_Class_Parallelism', 'Testing different levels of class parallelism.')
    all_reports = []
    idx=0
    for parallel_classes in parallel_classes_range:
        change_config(aeneas, parallel_classes=parallel_classes)
        if (idx==0):
            report = collect_data(aeneas, 1)
            idx=1
        else:
            report = collect_data(aeneas, 0)
        report['Class_Parallelism'] = parallel_classes
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Class_Parallelism', all_reports)
    return all_reports

'''
Test 8: Level Vector Mode on Model (LV_MODE_MODEL)
Tests different modes of generating Level Vectors on the model.
'''
def test_lv_mode_model(aeneas, lv_mode_model_options):
    setup_test(aeneas, 8, 'Test_LV_Mode_Model', 'Testing different Level Vector modes on model.')
    all_reports = []
    for lv_mode_model in lv_mode_model_options:
        change_config(aeneas, lv_mode_model=lv_mode_model)
        report = collect_data(aeneas,1)
        report['LV_Mode_Model'] = lv_mode_model
        all_reports.append(report)
    save_test_results(aeneas, 'Test_LV_Mode_Model', all_reports)
    return all_reports

'''
Test 9: Base Vector Generation Mode (BV_MODE)
Investigates the impact of different methods of Base Vector generation.
'''
def test_bv_mode(aeneas, bv_mode_options):
    setup_test(aeneas, 9, 'Test_BV_Mode', 'Testing different Base Vector generation modes.')
    all_reports = []
    for bv_mode in bv_mode_options:
        change_config(aeneas, bv_mode=bv_mode)
        report = collect_data(aeneas,1)
        report['BV_Mode'] = bv_mode
        all_reports.append(report)
    save_test_results(aeneas, 'Test_BV_Mode', all_reports)
    return all_reports

'''
Test 10: Class Vector Generation Mode (CV_MODE)
Analyzes the performance impact of different Class Vector generation modes.
'''
def test_cv_mode(aeneas, cv_mode_options):
    setup_test(aeneas, 10, 'Test_CV_Mode', 'Testing different Class Vector generation modes.')
    all_reports = []
    for cv_mode in cv_mode_options:
        change_config(aeneas, cv_mode=cv_mode)
        report = collect_data(aeneas,1)
        report['CV_Mode'] = cv_mode
        all_reports.append(report)
    save_test_results(aeneas, 'Test_CV_Mode', all_reports)
    return all_reports

'''
Test 11: Training on Hardware (TRAIN_ON_HW)
Assesses the effect of enabling or disabling hardware training on model performance.
'''
def test_hw_train(aeneas, hw_train_options):
    setup_test(aeneas, 11, 'Test_HW_Train', 'Testing hardware training enabled/disabled.')
    all_reports = []
    for hw_train in hw_train_options:
        change_config(aeneas, hw_train=hw_train)
        if (hw_train==0):
            report = collect_data(aeneas, 1)
        else:
            report = collect_data(aeneas, 0)
        report['HW_Train'] = hw_train
        all_reports.append(report)
    save_test_results(aeneas, 'Test_HW_Train', all_reports)
    return all_reports

'''
Test 12: Retraining on Hardware (RETRAIN_ON_HW)
Tests the impact of retraining the model on hardware.
'''
def test_retrain_in_hw(aeneas, retrain_in_hw_options):
    setup_test(aeneas, 12, 'Test_Retrain_HW', 'Testing retraining on hardware.')
    all_reports = []
    for retrain_in_hw in retrain_in_hw_options:
        change_config(aeneas, retrain_in_hw=retrain_in_hw)
        report = collect_data(aeneas, 1)
        report['Retrain_HW'] = retrain_in_hw
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Retrain_HW', all_reports)
    return all_reports

'''
Test 13: Spatial Encoding (ENCODING_TECHNIQUE)
Evaluates the performance with different spatial encoding techniques.
'''
def test_spatial_encoding(aeneas, encoding_technique_options):
    setup_test(aeneas, 13, 'Test_Spatial_Encoding', 'Testing different spatial encoding techniques.')
    all_reports = []
    for encoding_technique in encoding_technique_options:
        change_config(aeneas, encoding_technique=encoding_technique)
        report = collect_data(aeneas,1)
        report['Spatial_Encoding'] = encoding_technique
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Spatial_Encoding', all_reports)
    return all_reports

'''
Test 14: Temporal Encoding (N_GRAM_SIZE)
Investigates how different n-gram sizes for temporal encoding affect model performance.
'''
def test_temporal_encoding(aeneas, n_gram_size_options):
    setup_test(aeneas, 14, 'Test_Temporal_Encoding', 'Testing different temporal encoding n-gram sizes.')
    all_reports = []
    for n_gram_size in n_gram_size_options:
        change_config(aeneas, n_gram=1, n_gram_size=n_gram_size)
        report = collect_data(aeneas,1)
        report['Temporal_Encoding_N_Gram'] = n_gram_size
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Temporal_Encoding', all_reports)
    return all_reports

'''
Test 15: Clipping Techniques (CLIPPING_CLASS)
Analyzes the effects of different clipping techniques on the system's performance.
'''
def test_clipping_techniques(aeneas, clipping_options):
    setup_test(aeneas, 15, 'Test_Clipping_Techniques', 'Testing different clipping techniques.')
    all_reports = []
    for clipping in clipping_options:
        change_config(aeneas, clip=clipping)
        report = collect_data(aeneas,1)
        report['Clipping_Technique'] = clipping
        all_reports.append(report)
    save_test_results(aeneas, 'Test_Clipping_Techniques', all_reports)
    return all_reports


# -------------------------------- COMBINED TESTS ------------------------------------------


'''
Test 16: Verifying the combined effect of the supported paralelism degrees.
We test how the hardware resources vary changing:
- the number of classes compared in parallel (during the similarity phase) (PARALLELISM_CLASS);
- the number of features processed in parallel (during encoding phase) (PARALLELISM_FEATURES);
- the number of HV elements concurrently processed (FRAME).
The test is performed using a fixed dimensione for the HV (HD_DIM) and the FRAME. 
The function takes as input the grid of PARALLELISM_CLASS values and the other HDC model parameters, and returns the results of the test.
'''
def test_comb_parallelism(aeneas, parallel_features_range, parallel_classes_range, frame_range):
    setup_test(aeneas, 16, 'Test_COMB_PARALLELISM', 
               f'Testing combined effect of class, feature, and element parallelism with fixed HD_DIM.')
    all_reports = []
    count = 1
    idx=0
    for frame in frame_range:
        for parallel_features in parallel_features_range:
            for parallel_classes in parallel_classes_range:
                change_config(aeneas, parallel_features=parallel_features, 
                              parallel_classes=parallel_classes, frame=frame)
                if (idx==0):
                    report = collect_data(aeneas, 1)
                    idx=1
                else:
                    report = collect_data(aeneas, 0)

                report.update({'ID': count, 'Frame': frame, 'Parallel_features': parallel_features,
                               'Parallel_classes': parallel_classes})
                all_reports.append(report)
                count += 1
    save_test_results(aeneas, 'Test_COMB_PARALLELISM', all_reports)
    return all_reports

'''
Test 17: Verifying the effect of different generation techniques on the HDC model, varying the HD_DIM.
This test explores the impact of various Base Vector (BV_MODE), Level Vector (LV_MODE), and 
Class Vector (CV_MODE) generation modes while varying the HD_DIM.
'''
def test_generation(aeneas, dim_range, bv_mode_range, lv_mode_range, cv_mode_range):
    setup_test(aeneas, 17, 'Test_generation', 
               'Testing different generation techniques varying HD_DIM.')
    all_reports = []
    count = 1
    for dim in dim_range:
        for bv_mode in bv_mode_range:
            for lv_mode in lv_mode_range:
                for cv_mode in cv_mode_range:
                    change_config(aeneas, dim=dim, bv_mode=bv_mode, lv_mode=lv_mode, cv_mode=cv_mode)
                    report = collect_data(aeneas, 1)
                    report.update({'ID': count, 'Dimension': dim, 'BV_mode': bv_mode, 
                                   'LV_mode': lv_mode, 'CV_mode': cv_mode})
                    all_reports.append(report)
                    count += 1
    save_test_results(aeneas, 'Test_generation', all_reports)
    return all_reports


'''
Test 18: Verifying the effect of different clipping and similarity measures on the HDC model.
This test evaluates the performance implications of various combinations of clipping techniques
and similarity measures.
'''
def test_clipping_similarity(aeneas, clip_range, sim_range):
    setup_test(aeneas, 18, 'Test_CLIPPING', 
               'Testing different clipping and similarity measures.')
    all_reports = []
    count = 1
    for clip in clip_range:
        for sim in sim_range:
            if not (clip != "CLIPPING_BINARY" and sim == "SIMI_HAM"):
                change_config(aeneas, clip=clip, similarity=sim)
                report = collect_data(aeneas, 1)
                report.update({'ID': count, 'Clipping': clip, 'Similarity': sim})
                all_reports.append(report)
                count += 1
    save_test_results(aeneas, 'Test_CLIPPING', all_reports)
    return all_reports

'''
Test 19: Verifying the effect of different HV types, clipping, and similarity measures on the HDC model.
This test assesses the combined influence of Hyperdimensional Vector types, clipping techniques,
and similarity measures, providing insights into their interaction and overall impact on model performance.
'''
def test_type_clipping_similarity(aeneas, hvtype_range, clip_range, sim_range):
    setup_test(aeneas, 19, 'Test_type_clipping_similarity', 
               'Testing different HV types, clipping, and similarity measures.')
    all_reports = []
    count = 1
    for hvtype in hvtype_range:
        for clip in clip_range:
            for sim in sim_range:
                if not ((clip == "CLIPPING_DISABLE" and sim == "SIMI_HAM") or 
                        (clip == "CLIPPING_BINARY" and hvtype == "BIPOLAR" and sim == "SIMI_HAM")):
                    change_config(aeneas, hvtype=hvtype, clip=clip, similarity=sim)
                    report = collect_data(aeneas, 1)
                    report.update({'ID': count, 'HV_type': hvtype, 'Clipping': clip, 'Similarity': sim})
                    all_reports.append(report)
                    count += 1
    save_test_results(aeneas, 'Test_type_clipping_similarity', all_reports)
    return all_reports




# -------------------------------- Dataset TESTS ------------------------------------------
# -----------------------------
# Classification problems:
# -----------------------------
## - Test 1: CARDIO dataset, spatial encoding, 3 classes, 21 features
def test_dataset_cardio(aeneas,sw_train):
    setup_test(aeneas, 1, 'Test_dataset_cardio', 'Testing CARDIO dataset.')
    all_reports = []
    change_config(aeneas, dataset_name="CARDIO", dataset_size=2126, dataset_train_size=1594, dataset_test_size=532, dataset_validation_size=1594,
                  dataset_feature_size=21, dataset_data_type="FP", dataset_data_range_min=0, dataset_data_range_max=1, dataset_classes_size=3,
                  dim=512, hd_mode ="DENSE", hvtype="BINARY", clip="CLIPPING_DISABLE", similarity="SIMI_COS", encoding_technique="ENCODING_NGRAM",
                  lv_mode_model="LINEAR", lv_len=10, n_gram=0, bv_mode="BV_M_INT_MEM", lv_mode="LV_M_INT_MEM", cv_mode="CV_M_INT_MEM",
                  hw_train=0, retrain_in_hw=0, parallel_features=1, parallel_classes=1, frame=64, sparsity_factorx10=0,
                  lr=100, lr_decay="LR_ITER", epoch=50, problem_type = "PROBLEM_TYPE_CLASSIFICATION")
    report = collect_data(aeneas,sw_train)
    all_reports.append(report)
    save_test_results(aeneas, 'Test_dataset_cardio', all_reports)
    return all_reports


## - Example 2: EMG dataset, Temporal encoding, 5 classes, 4 features
def test_dataset_emg(aeneas,sw_train):
    setup_test(aeneas, 2, 'Test_dataset_emg', 'Testing EMG dataset.')
    all_reports = []
    change_config(aeneas, dataset_name="EMG", dataset_size=186036, dataset_train_size=372106, dataset_test_size=148830, dataset_validation_size=372106,
                  dataset_feature_size=4, dataset_data_type="FP", dataset_data_range_min=0, dataset_data_range_max=21, dataset_classes_size=5,
                  dim=256, hd_mode ="DENSE",  hvtype="BINARY", clip="CLIPPING_BINARY", similarity="SIMI_HAM", encoding_technique="ENCODING_RECORD",
                  lv_mode_model="APPROX", lv_len=21, n_gram=1, n_gram_size=4, bv_mode="BV_M_INT_MEM", lv_mode="LV_M_INT_MEM", cv_mode="CV_M_INT_MEM",
                  hw_train=0, retrain_in_hw=0, parallel_features=1, parallel_classes=1, frame=64, sparsity_factorx10=0,
                  lr=50, lr_decay="LR_CONSTANT", epoch=50, problem_type = "PROBLEM_TYPE_CLASSIFICATION")
    report = collect_data(aeneas,sw_train)
    all_reports.append(report)
    save_test_results(aeneas, 'Test_dataset_emg', all_reports)
    return all_reports


## - Example 3: Hepta dataset, Clustering, record based encoding, 7 clusters, 3 features
def test_dataset_hepta(aeneas,sw_train):
    setup_test(aeneas, 3, 'Test_dataset_emg', 'Testing HEPTA dataset.')
    all_reports = []
    change_config(aeneas, dataset_name="Hepta", dataset_size=212, dataset_train_size=212, dataset_test_size=212, dataset_validation_size=212,
                  dataset_feature_size=3, dataset_data_type="FP", dataset_data_range_min=-4, dataset_data_range_max=4, dataset_classes_size=7,
                  dim=1024, hd_mode ="DENSE",  hvtype="BIPOLAR", clip="CLIPPING_QUANTIZED", similarity="SIMI_COS", encoding_technique="ENCODING_RECORD",
                  lv_mode_model="THERMOMETER", lv_len=20, n_gram=0, n_gram_size=5, bv_mode="BV_M_INT_MEM", lv_mode="LV_M_INT_MEM", cv_mode="CV_M_INT_MEM",
                  hw_train=0, retrain_in_hw=0, parallel_features=1, parallel_classes=1, frame=64, sparsity_factorx10=0,
                  lr=50, lr_decay="LR_CONSTANT", epoch=50, problem_type = "PROBLEM_TYPE_CLUSTERING")
    report = collect_data(aeneas,sw_train)
    all_reports.append(report)
    save_test_results(aeneas, 'Test_dataset_hepta', all_reports)
    return all_reports


## - Example 4: boston dataset, regression, record based encoding, 1 class, 12 features
def test_dataset_boston(aeneas,sw_train):
    setup_test(aeneas, 4, 'Test_dataset_boston', 'Testing BOSTON dataset.')
    all_reports = []
    change_config(aeneas, dataset_name="boston", dataset_size=504, dataset_train_size=403, dataset_test_size=101, dataset_validation_size=403,
                  dataset_feature_size=12, dataset_data_type="FP", dataset_data_range_min=-3.907193304981041, dataset_data_range_max=9.99895848284027, dataset_classes_size=1,
                  dim=512, hd_mode ="DENSE", hvtype="BINARY", clip="CLIPPING_DISABLE", similarity="SIMI_DPROD", encoding_technique="ENCODING_RECORD",
                  lv_mode_model="LINEAR", lv_len=20, n_gram=0, bv_mode="BV_M_INT_MEM", lv_mode="LV_M_INT_MEM", cv_mode="CV_M_INT_MEM",
                  hw_train=0, retrain_in_hw=0, parallel_features=1, parallel_classes=1, frame=64, sparsity_factorx10=0,
                  lr=50, lr_decay="LR_CONSTANT", epoch=50, problem_type = "PROBLEM_TYPE_REGRESSION")
    report = collect_data(aeneas,sw_train)
    all_reports.append(report)
    save_test_results(aeneas, 'Test_dataset_boston', all_reports)
    return all_reports

# -------------------------------- PLOTTING ------------------------------------------
def single_range_plot(loaded_array, data_to_plot, classification=1):

    # Define the metrics
    if classification==1:
        metrics = {
            r'ModelEval Accuracy': [item['ModelEval']['accuracy'] for item in loaded_array],
            r'HD_Eval Accuracy': [item['HD_Eval']['accuracy'] for item in loaded_array],
            r'Total LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
            r'Total FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
            r'CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
            r'DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
            r'Power (Dynamic W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
            r'Power Device Static (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
            r'Execution Time': [item['TimingReport'] for item in loaded_array],
            r'Speed': [item['Speed'] for item in loaded_array]
        }
    else:
        metrics = {
            r'ModelEval Accuracy': [item['ModelEval']['accuracy'] for item in loaded_array],
            r'HD_Eval Accuracy': [item['HD_Eval']['MSE'] for item in loaded_array],
            r'Total LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
            r'Total FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
            r'CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
            r'DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
            r'Power (Dynamic W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
            r'Power Device Static (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
            r'Execution Time': [item['TimingReport'] for item in loaded_array],
            r'Speed': [item['Speed'] for item in loaded_array]
        }
    # Extract unique 'Frame' values
    frame_values = (set(item[data_to_plot] for item in loaded_array))

    # Create a colormap
    if classification==1:
        cmap = plt.cm.viridis
    colors = [cmap(i / len(frame_values)) for i in range(len(frame_values))]

    # Create the bar plot
    num_metrics = len(metrics)
    fig, axes = plt.subplots(nrows=num_metrics, ncols=1, figsize=(8, 3 * num_metrics))

    for ax, metric_name in zip(axes, metrics):
        x = np.arange(len(frame_values))
        bar_width = 0.5
        legends = [f'{frame}' for frame in frame_values]

        ax.bar(x, metrics[metric_name], bar_width, label=legends, color=colors)
        ax.set_xlabel(data_to_plot)
        ax.set_ylabel(metric_name)
        ax.set_title(f'{metric_name} vs. {data_to_plot}')
        ax.set_xticks(x)
        ax.set_xticklabels(frame_values)  # Set the 'Frame' values as x-axis labels
        ax.legend()
        
        ax.grid(True)

    plt.tight_layout()
    plt.show()

def plot_test_generation(loaded_array):
    # Define the metrics
    metrics = {
        r'ModelEval Accuracy (%)': [item['ModelEval']['accuracy'] for item in loaded_array],
        r'HD_Eval Accuracy (%)': [item['HD_Eval']['accuracy'] for item in loaded_array],
        r'Total #LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
        r'Total #FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
        r'Total #CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
        r'Total #DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
        r'Memory Requirements (Byte)': [item['Memory Requirements'] for item in loaded_array],
        r'Dynamic Power (W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
        r'Static Power (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
        r'Execution Time (ns)': [item['TimingReport'] for item in loaded_array],
        r'Speed (Classifications/s)': [item['Speed'] for item in loaded_array]
    }

    # Extract unique HD_DIM values
    hd_dim_values = sorted(set(item['Dimension'] for item in loaded_array))

    # Extract unique combinations of BV_mode, LV_mode and CV_mode
    bv_modes = sorted(set(item['BV_mode'] for item in loaded_array))
    lv_modes = sorted(set(item['LV_mode'] for item in loaded_array), reverse=True)
    cv_modes = sorted(set(item['CV_mode'] for item in loaded_array))

    # Create a colormap for unique combinations of BV_mode, LV_mode and CV_mode
    cmap = plt.cm.viridis
    colors = [cmap(i) for i in range(len(bv_modes) * len(lv_modes)*len(cv_modes))]
    for index in range(len(bv_modes) * len(lv_modes) *len(cv_modes)):
        colors[index] = plt.cm.viridis(index / (len(bv_modes) * len(lv_modes) *len(cv_modes)))

    # Create grouped bar plots for each metric
    num_metrics = len(metrics)
    fig, axes = plt.subplots(nrows=num_metrics, ncols=1, figsize=(15, 3 * num_metrics))
    for ax, (metric_name, metric_data) in zip(axes, metrics.items()):
        x = np.arange(len(hd_dim_values))
        num_combinations = len(bv_modes) * len(lv_modes) * len(cv_modes)
        total_width = 0.8                           # Total width for each group of bars
        bar_width = total_width / num_combinations  # Width of each individual bar in a group
        offset = -total_width / 2

        for i, bv_mode in enumerate(bv_modes):
            for j, lv_mode in enumerate(lv_modes):
                for k, cv_mode in enumerate(cv_modes):
                    key = f'{bv_mode} - {lv_mode} - {cv_mode}'
                    values = [metric_data[idx] for idx, item in enumerate(loaded_array) if item['BV_mode'] == bv_mode and item['LV_mode'] == lv_mode and item['CV_mode'] == cv_mode]
                    
                    # Calculate the x-positions for each group of bars to center them around x-ticks
                    x_positions = x + offset + (i * len(lv_modes) * len(cv_modes) + j * len(cv_modes) + k) * bar_width
                    ax.bar(x_positions, values, bar_width, label=f'{bv_mode} - {lv_mode} - {cv_mode}', color=colors[i * len(lv_modes) * len(cv_modes) + j * len(cv_modes) + k])

        ax.set_xlabel(r'HD_DIM',fontsize=14)
        ax.set_ylabel(metric_name, fontsize=14)
        ax.set_title(metric_name + ' vs. HD_DIM', fontsize=14)
        ax.set_xticks(x)
        ax.set_xticklabels(hd_dim_values)
        ax.tick_params(axis='both', which='major', labelsize=12)
        ax.legend(loc='upper left', bbox_to_anchor=(1, 1), prop={'size':11})
        ax.grid(True)

    plt.tight_layout()
    plt.show()

def plot_test_type_clipping_similarity(loaded_array):
    # Define the metrics
    metrics = {
        'ModelEval Accuracy': [item['ModelEval']['accuracy'] for item in loaded_array],
        'HD_Eval Accuracy': [item['HD_Eval']['accuracy'] for item in loaded_array],
        'Total LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
        'Total FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
        'CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
        'DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
        'Power (Dynamic W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
        'Power Device Static (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
        'Execution Time': [item['TimingReport'] for item in loaded_array],
        'Speed': [item['Speed'] for item in loaded_array]
    }

    # Extract unique HD_DIM values
    hd_dim_values = sorted(set(item['Dimension'] for item in loaded_array))

    # Extract unique combinations of BV_mode and LV_mode
    clip_modes = ["CLIPPING_BINARY", "CLIPPING_POWERTWO", "CLIPPING_QUANTIZED_POWERTWO","CLIPPING_QUANTIZED", "CLIPPING_DISABLE"]
    print(clip_modes)
    

    # Create a colormap for unique combinations of BV_mode and LV_mode
    cmap = plt.cm.viridis
    colors = [cmap(i) for i in range(len(clip_modes))]
    for index in range(len(clip_modes)):
        colors[index] = plt.cm.viridis(index / (len(clip_modes)))

    # Create grouped bar plots for each metric
    num_metrics = len(metrics)

    fig, axes = plt.subplots(nrows=num_metrics, ncols=1, figsize=(15, 3 * num_metrics))
    emptyvalues=0
    for ax, (metric_name, metric_data) in zip(axes, metrics.items()):
        x = np.arange(len(hd_dim_values))
        num_combinations = len(clip_modes) 
        total_width = 0.8  # Total width for each group of bars
        bar_width = total_width / num_combinations  # Width of each individual bar in a group
        offset = -total_width / 2

        # Precompute positions and labels for non-empty combinations
        x_positions = []
        x_labels = []
        x_data = []  # Store data for each label in the same order
        for i, clip_mode in enumerate(clip_modes):
            key = f'{clip_mode}'
            values = [metric_data[idx] for idx, item in enumerate(loaded_array) if item['Clipping'] == clip_mode ]

            # Store data and labels in the same order
            if values:
                x_data.append(values)
                x_labels.append(f'{clip_mode}')
                # Adjust x_pos to center the bars
                x_positions.append(x + offset + i * bar_width + bar_width / 2)
            else: 
                emptyvalues += 1

        # Plot bars for non-empty combinations
        for x_pos, values, label, color in zip(x_positions, x_data, x_labels, colors):
            ax.bar(x_pos, values, bar_width, label=label, color=color)

        ax.set_xlabel('HD_DIM')
        ax.set_ylabel(metric_name)
        ax.set_title(f'{metric_name} vs. HD_DIM (Grouped by BV_mode, LV_mode, and CV_mode)')
        ax.set_xticks(x + (total_width-emptyvalues) / 2)  # Move ticks to the center of the bars
        ax.set_xticklabels(hd_dim_values)
        ax.legend(loc='upper left', bbox_to_anchor=(1, 1))
        ax.grid(True)
    plt.tight_layout()
    plt.show()

def plot_test_type_clipping_similarity(loaded_array):
    # Define the metrics
    metrics = {
        'ModelEval Accuracy': [item['ModelEval']['accuracy'] for item in loaded_array],
        'HD_Eval Accuracy': [item['HD_Eval']['accuracy'] for item in loaded_array],
        'Total LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
        'Total FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
        'CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
        'DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
        'Power (Dynamic W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
        'Power Device Static (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
        'Execution Time': [item['TimingReport'] for item in loaded_array],
        'Speed': [item['Speed'] for item in loaded_array]
    }

    # Extract unique HD_DIM values
    hd_dim_values = sorted(set(item['Dimension'] for item in loaded_array))

    # Extract unique combinations of BV_mode and LV_mode
    bv_modes = (set(item['HV_type'] for item in loaded_array))
    lv_modes = (set(item['Clipping'] for item in loaded_array))
    cv_modes = (set(item['Similarity'] for item in loaded_array))

    # Create a colormap for unique combinations of BV_mode and LV_mode
    cmap = plt.cm.viridis
    colors = [cmap(i) for i in range(len(bv_modes) * len(lv_modes)*len(cv_modes))]
    for index in range(len(bv_modes) * len(lv_modes) *len(cv_modes)):
        colors[index] = plt.cm.viridis(index / (len(bv_modes) * len(lv_modes) *len(cv_modes)))

    # Create grouped bar plots for each metric
    num_metrics = len(metrics)

    fig, axes = plt.subplots(nrows=num_metrics, ncols=1, figsize=(15, 3 * num_metrics))
    emptyvalues=0
    for ax, (metric_name, metric_data) in zip(axes, metrics.items()):
        x = np.arange(len(hd_dim_values))
        num_combinations = len(bv_modes) * len(lv_modes) * len(cv_modes)
        total_width = 0.8  # Total width for each group of bars
        bar_width = total_width / num_combinations  # Width of each individual bar in a group
        offset = -total_width / 2

        # Precompute positions and labels for non-empty combinations
        x_positions = []
        x_labels = []
        x_data = []  # Store data for each label in the same order
        for i, bv_mode in enumerate(bv_modes):
            for j, lv_mode in enumerate(lv_modes):
                for k, cv_mode in enumerate(cv_modes):
                    key = f'{bv_mode} - {lv_mode} - {cv_mode}'
                    values = [metric_data[idx] for idx, item in enumerate(loaded_array) if item['HV_type'] == bv_mode and item['Clipping'] == lv_mode and item['Similarity'] == cv_mode]

                    # Store data and labels in the same order
                    if values:
                        x_data.append(values)
                        x_labels.append(f'{bv_mode} - {lv_mode} - {cv_mode}')
                        # Adjust x_pos to center the bars
                        x_positions.append(x + offset + (i * len(lv_modes) * len(cv_modes) + j * len(cv_modes) + k - emptyvalues) * bar_width + bar_width / 2)
                    else: 
                        emptyvalues += 1

        # Plot bars for non-empty combinations
        for x_pos, values, label, color in zip(x_positions, x_data, x_labels, colors):
            ax.bar(x_pos, values, bar_width, label=label, color=color)

        ax.set_xlabel('HD_DIM')
        ax.set_ylabel(metric_name)
        ax.set_title(f'{metric_name} vs. HD_DIM (Grouped by BV_mode, LV_mode, and CV_mode)')
        ax.set_xticks(x + (total_width-emptyvalues) / 2)  # Move ticks to the center of the bars
        ax.set_xticklabels(hd_dim_values)
        ax.legend(loc='upper left', bbox_to_anchor=(1, 1))
        ax.grid(True)
    plt.tight_layout()
    plt.show()



def plot_test_comb_parallelism(loaded_array):
    # Define the metrics
    metrics = {
        'ModelEval Accuracy': [item['ModelEval']['accuracy'] for item in loaded_array],
        'HD_Eval Accuracy': [item['HD_Eval']['accuracy'] for item in loaded_array],
        'Total LUTs': [item['ResourceUtility']['Total LUTs'] for item in loaded_array],
        'Total FFs': [item['ResourceUtility']['Total FF'] for item in loaded_array],
        'CARRY8': [item['ResourceUtility']['CARRY8'] for item in loaded_array],
        'DSPs': [item['ResourceUtility']['DSPs'] for item in loaded_array],
        'Power (Dynamic W)': [item['PowerReport']['Dynamic (W)'] for item in loaded_array],
        'Power Device Static (W)': [item['PowerReport']['Device Static (W)'] for item in loaded_array],
        'Execution Time': [item['TimingReport'] for item in loaded_array],
        'Speed': [item['Speed'] for item in loaded_array]
    }

    # Extract unique combinations of BV_mode and LV_mode
    frame_modes = sorted(set(item['Frame'] for item in loaded_array))
    features_modes = (set(item['Parallel_features'] for item in loaded_array))
    class_modes = (set(item['Parallel_classes'] for item in loaded_array))

    # Create a colormap for unique combinations of BV_mode and LV_mode
    cmap = plt.cm.viridis
    colors = [cmap(i) for i in range(len(features_modes)*len(class_modes))]
    for index in range(len(features_modes) *len(class_modes)):
        colors[index] = plt.cm.viridis(index / (len(features_modes) *len(class_modes)))

    # Create grouped bar plots for each metric
    num_metrics = len(metrics)

    fig, axes = plt.subplots(nrows=num_metrics, ncols=1, figsize=(14, 3 * num_metrics))

    for ax, (metric_name, metric_data) in zip(axes, metrics.items()):
        x = np.arange(len(frame_modes))
        num_combinations = len(features_modes) * len(class_modes)
        total_width = 0.8  # Total width for each group of bars
        bar_width = total_width / num_combinations  # Width of each individual bar in a group
        offset = -total_width / 2

        # Precompute positions and labels for non-empty combinations
        x_positions = []
        x_labels = []
        x_data = []  # Store data for each label in the same order
        
        for j, feature_mode in enumerate(features_modes):
            for k, class_mode in enumerate(class_modes):
                key = f'{feature_mode} - {class_mode}'
                values = [metric_data[idx] for idx, item in enumerate(loaded_array) if item['Parallel_features'] == feature_mode and item['Parallel_classes'] == class_mode]

                # Store data and labels in the same order
                if values:
                    x_data.append(values)
                    x_labels.append(f'Parallel_features: {feature_mode} - Parallel_classes: {class_mode}')
                    # Adjust x_pos to center the bars
                    x_positions.append(x + offset + (j * len(class_modes) + k) * bar_width)

        # Plot bars for non-empty combinations
        for x_pos, values, label, color in zip(x_positions, x_data, x_labels, colors):
            ax.bar(x_pos, values, bar_width, label=label, color=color)

        ax.set_xlabel('Element Parallelism (FRAME)')
        ax.set_ylabel(metric_name)
        ax.set_title(f'{metric_name} vs. Parallelism (Frame, Feature, Classes)')
        ax.set_xticks(x)  # This will automatically center the ticks to the middle of the grouped bars
        ax.set_xticklabels(frame_modes)
        ax.legend(loc='upper left', bbox_to_anchor=(1, 1))
        ax.grid(True)
    plt.tight_layout()
    plt.show()



def dataset_test_plot(data, classification=1):

    # Extracting data for plots
    resource_utility_selected = {k: data[0]['ResourceUtility'][k] for k in ['Total LUTs', 'Total FF', 'CARRY8', 'DSPs']}
    if classification==1:
        confusion_matrix = data[0]['HD_Eval']['confusion_matrix']
        performance_metrics = [data[0]['HD_Eval']['accuracy'], data[0]['HD_Eval']['precision'], data[0]['HD_Eval']['recall'], data[0]['HD_Eval']['f1_score']]
    else:
        performance_metrics = [data[0]['HD_Eval']['MSE']]
    timing_report = data[0]['TimingReport']

    # Pastel colors
    colors_pastel = sns.color_palette("pastel")

    # Plotting
    fig, axs = plt.subplots(1, 3, figsize=(18, 4))

    # Resource Utility Bar Plot
    axs[0].bar(resource_utility_selected.keys(), resource_utility_selected.values(), color=colors_pastel[:4])
    axs[0].set_title('Hardware Resources')
    axs[0].set_ylabel('Value')
    axs[0].tick_params(axis='x', rotation=45)
    axs[0].grid('True')

    # Performance Metrics Bar Plot
    axs[1].bar(['Accuracy', 'Precision', 'Recall', 'F1 Score'], performance_metrics, color=colors_pastel[4:8])
    axs[1].set_title('Model Performance Metrics')
    axs[1].set_ylabel('Value')
    axs[1].tick_params(axis='x', rotation=45)
    axs[1].grid('True')

    # Confusion Matrix Heatmap
    if classification==1:
        sns.heatmap(confusion_matrix, annot=True, fmt='d',cmap='Blues', ax=axs[2])
        axs[2].set_title('Confusion Matrix')

    # Standalone Plot for Execution Time
    # plt.figure(figsize=(6, 4))
    # plt.bar('Execution Time', timing_report, color=colors_pastel[8])
    # plt.title('Execution Time')
    # plt.ylabel('Time (ns)')
    # plt.show()

import matplotlib.pyplot as plt
import seaborn as sns
from dataset import Dataset
import warnings

class Visualizer:
    def __init__(self, data_analyzer):
        self.data_analyzer = data_analyzer

    def plot_statistics(self, dataset_name, data_type, file_path = None, just_save=False):
        with warnings.catch_warnings():
            warnings.simplefilter("ignore")
            data = self.data_analyzer._get_data(dataset_name, data_type)
            plt.figure(figsize=(7, 5))
            sns.boxplot(data=data)
            plt.title(f"Box plot for {dataset_name} ({data_type})")
            plt.xticks(rotation=90)
        if not just_save:
            plt.show()

        if file_path is not None:
            plt.savefig(file_path, format='png', dpi=300)
            

    @staticmethod
    def plot_similarity_matrix(matrix, file_path=None, just_save=False):
        plt.imshow(matrix, cmap='hot', interpolation='nearest')
        plt.colorbar(label='Cosine Similarity')
        plt.title('Similarity Matrix')
        
        if not just_save:
            plt.show()
        
        if file_path is not None:
            plt.savefig(file_path, format='png', dpi=300)
            
    @staticmethod 
    def plot_confusion_matrix(matrix, file_path=None):
        
        plt.figure(figsize=(7, 5))
        sns.heatmap(matrix, annot=True, fmt='d')
        plt.title("Confusion matrix")
        plt.ylabel('True label')
        plt.xlabel('Predicted label')
        plt.show()



    def single_range_plot(loaded_array, data_to_plot):
        # Define the metrics
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
        # Extract unique 'Frame' values
        frame_values = (set(item[data_to_plot] for item in loaded_array))

        # Create a colormap
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



    def dataset_test_plot(data):

        # Extracting data for plots
        resource_utility_selected = {k: data[0]['ResourceUtility'][k] for k in ['Total LUTs', 'Total FF', 'CARRY8', 'DSPs']}
        confusion_matrix = data[0]['HD_Eval']['confusion_matrix']
        performance_metrics = [data[0]['HD_Eval']['accuracy'], data[0]['HD_Eval']['precision'], data[0]['HD_Eval']['recall'], data[0]['HD_Eval']['f1_score']]
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
        sns.heatmap(confusion_matrix, annot=True, fmt='d',cmap='Blues', ax=axs[2])
        axs[2].set_title('Confusion Matrix')

        # Standalone Plot for Execution Time
        # plt.figure(figsize=(6, 4))
        # plt.bar('Execution Time', timing_report, color=colors_pastel[8])
        # plt.title('Execution Time')
        # plt.ylabel('Time (ns)')
        # plt.show()


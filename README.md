
---

<p align="center">
  <img src="./doc/.img/logo/AeneasHDC.png" alt="Aeneas HyperCompute Platform Logo" width="200">
</p>

<h1 align="center">Aeneas HyperCompute Platform</h1>

<p align="center">
AeneasHDC is a cutting-edge, universal, automatic, open-source environment for simple and fast deployment of HDC models in software and hardware.  
</p>

<p align="left">

<p align="center" style="font-size: 18px;">
    <a href="#-getting-started" style="font-weight: bold;">🗺️ Model Description </a> &nbsp;·&nbsp;
    <a href="#-getting-started" style="font-weight: bold;">🚀 Getting Started </a> &nbsp;·&nbsp;
    <a href="#-project-structure">📂 Project Structure</a> &nbsp;·&nbsp;
    <a href="#-documentation">📚 Documentation</a> &nbsp;·&nbsp;
    <a href="#-publications">📜 Publications</a> &nbsp;·&nbsp;
    <a href="#-license">⚖️ License</a> &nbsp;·&nbsp;
    <a href="#-contribution">🤝 Contribution</a> &nbsp;·&nbsp; </br>;
    <a href="#-acknowledgements">🌟 Acknowledgements</a> &nbsp;·&nbsp;
    <a href="#-contact">📞 Contact</a>
</p>

---

## 🗺️ Model Description
AeneasHDC is extremely customizable, supporting a wide range of the most common techniques adopted in the literature for classification models, enabling users to easily assess the impact of different design choices on model accuracy, memory usage, execution time, energy consumption, and area requirements.
    
The following Figure illustrates the AeneasHDC's workflow. An intuitive Graphic User Interface (GUI) allows to specify the problem characteristics, including dataset details, the number of features and classes, the desired programming language, and the target FPGA. An interactive mechanism lets the user decide how to distribute the workload between the software and the hardware implementations. The hardware can be generated to accelerate the entire classification process (train, inference, retrain) or just some tasks, deciding, for example, to execute the train and retrain in software and instantiate only the hardware for the inference, as commonly done for embedded applications.
<p align="center">
  <img src="./doc/.img/theory/Aeneas_model.png" width="600">
</p>
    
The system automatically generates all the configuration files required by the following entities and instantiates the model in software and hardware. 
From the software side, the model can be produced in Python, Matlab or C++, thanks to the versatile AeneasHDC library. The model is executed, and the results in terms of accuracy and confusion matrix are collected. Additionally, the data required for inference are extracted and passed to the hardware model.
    
The hardware architecture is generated using the Xilinx High-Level Synthesis (HLS) tool, Vitis and it is then synthesized, simulated and tested using the Vivado 2023. The data about energy consumption, execution time and resource allocation are collected from the design.
    
All the results accumulated from the software and the hardware implementations are finally relayed to a dedicated report-generation module that compiles a comprehensive HTML-based summary, encapsulating all the information from the run simulations. The summary includes details of the model configuration, dataset specifications, chosen programming language, target hardware platform, and key performance metrics such as execution time, memory usage, energy consumption, and resource utilization.
This report is stored locally and can be readily accessible through the user-friendly GUI, which organizes all conducted tests and allows to review and compare different runs. 

The entire described process is engineered to be fully automated, abstracting complex or time-consuming tasks associated with coding models or designing custom hardware architectures. The GUI is an efficient singular point of control that enables users to manage the model at every stage. However, AeneasHDC is completely open-source, and makes accessible all its libraries and scripts. Extensive documentation is provided, covering the basic usage of the model, the theoretical concepts behind parameter selections, and detailed insights into the underlying code and library functions.
    
AeneasHDC is in constant evolution, aiming to catch up all the innovations in the literature and provide a model always updated to the user. Feel free to collaborate with us!!

</p>


## 🚀 Getting Started

### Prerequisites:

#### Programming Languages
- **Python**: Mandatory 
- **C++** (Optional)
- **Matlab** (Optional)

#### FPGA Development Tools
- **Xilinx Vivado Suite 2023**
- **Xilinx High-Level Synthesis (HLS) tool, Vitis 2023**

### Installation:
```bash
$ git clone https://github.com/AeneasHDC/Reconfigurable_HDC_Platform.git
$ cd Reconfigurable_HDC_Platform
$ python run.py
$ ...
```

---


## 📂 Project Structure

<details>
  <summary><strong>Click to expand the structure!</strong></summary>
  
```
Aeneas HyperCompute Platform/
│
├── LICENSE.txt
│
├── datasets/                # Diverse dataset collections.
│
├── doc/                     # Comprehensive documentation resources.
│
├── main/                    # Core functionalities and configurations.
│
├── out/                     # Resultant data and insights.
│
├── src/                     # Source code of the platform.
│
├── tools/                   # Auxiliary tools.
│
├── tests/                   # contain getting started and examples.
│
└── usr_config/              # Users Configuration.
```
</details>

---

## 📜 Publications

---

![QR Code for 2023 Publication](./qrcodes/2023_AeneasHyperCompute.png)

### 📘 **2023 - AeneasHDC: an automatic framework for streamlining Hyperdimensional computing models in FPGAs**

🔗 [**Abstract**](#abstract) • 🔗 [**Citation**](#citation) • 🔗 [**Download Paper**](./publications/2023_AeneasHyperCompute.pdf)

<details id="abstract">
  <summary><strong>Abstract</strong></summary>

  Hyperdimensional Computing (HDC) is an emerging bio-inspired computing paradigm, that models neural pattern activities using high-dimensional distributed representations. Unlike traditional AI models, HDC leverages extremely parallel, simple vector arithmetic operations. This computational efficiency and parallelism make HDC particularly suited for hardware implementations, especially as a lightweight energy-efficient solution for performing classification tasks on resource-constrained edge devices.
The HDC classification pipeline, including encoding, training, and comparison stages, has been extensively explored with various approaches in the literature. However, while these techniques are mainly oriented to improve the model accuracy, their influence on hardware parameters remains largely unexplored. This work presents AeneasHDC, the first universal, automatic, and open-source platform for the streamlined deployment of HDC models in both software and hardware with diverse configurable options. AeneasHDC supports an extensive range of techniques commonly adopted in literature, automates the design of hardware accelerators for HDC, and empowers users to easily assess the impact of different design choices on model accuracy, memory usage, execution time, energy consumption, and area requirements.
</details>

<details id="citation">
  <summary><strong>Citation</strong></summary>

  **Highlight and manually copy the citation format of your choice.**

  - **BibTeX**: 
    ```
    @article{, 
    author = "", 
    title = "", 
    journal = "", 
    year = "", 
    volume = "", 
    pages = ""
    }
    ```

  - **APA**: 
    ```
    ......
    ```

  - **MLA**: 
    ```
    ......
    ```

  - **Chicago**: 
    ```
    ......
    ```
</details>
## ⚖️ License

This project is fortified with the apache license. For more details, please refer to [LICENSE.txt](./LICENSE.txt).


## 📞 Contact

For inquiries or collaboration, get in touch with our lead developers:

- **Marco Angioli** - 📧 [Email](mailto:marco.angioli@uniroma1.it)
- **Saeid Jamili** - 📧 [Email](mailto:saeid.jamili@uniroma1.it)

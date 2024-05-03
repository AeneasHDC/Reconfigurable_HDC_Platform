
---

<p align="center">
  <img src="./doc/img/logo/AeneasHDC_white.png" alt="Aeneas HyperCompute Platform Logo" width="200">
</p>
<h1 align="center">Aeneas HyperCompute Platform</h1>

<p align="center">
    <em>An automatic open-source environment for simple and fast deployment of flexible Hyperdimensional Computing (HDC) learning models in software and hardware.</em>
</p>

<p align="center" style="font-size: 18px;">
    <a href="#-model-overview"  style="font-weight: bold;">🗺️ Model Overview</a> &nbsp;·&nbsp;
    <a href="#-getting-started" style="font-weight: bold;">⚙️ Getting Started</a> &nbsp;·&nbsp;
    <a href="#-project-structure">📂 Project Structure</a> &nbsp;·&nbsp;
    <a href="#-gui" style="font-weight: bold;">⚙💻 Graphic User Interface (GUI)</a> &nbsp;·&nbsp;
    <a href="#-usage">🖥 Usage</a> &nbsp;·&nbsp;
    <a href="#-documentation">📚 Documentation</a> &nbsp;·&nbsp;
    <a href="#-publications">📜 Publications</a> &nbsp;·&nbsp;
    <a href="#-license">⚖️ License</a> &nbsp;·&nbsp;
    <a href="#-usage">🖥 Frequently Asked Questions (FAQ)</a> &nbsp;·&nbsp;
    <a href="#-contribution">🤝 Contribution</a> &nbsp;·&nbsp; </br>;
    <a href="#-acknowledgements">🌟 Acknowledgements</a> &nbsp;·&nbsp;
    <a href="#-contact">📞 Contact</a>
</p>


## 🗺️ Model Overview
AeneasHDC is the first automatic open-source framework in the literature to facilitate the generation of flexible hardware accelerators for hyperdimensional computing (HDC) learning problems.
The environment is extremely customizable, supporting a wide range of the most common techniques adopted in the literature for learning models, enabling users to easily assess the impact of
different design choices on model accuracy, memory usage, execution time, energy consumption, and area requirements.
    
The Figure below illustrates the AeneasHDC's workflow. The intuitive <a href="#-gui" style="font-weight: bold;">Graphic User Interface (GUI)</a> allows the user to specify the problem characteristics, including dataset details, the number of features and classes, the desired programming language, and the target FPGA. An interactive mechanism lets the user decide how to distribute the workload between the software and the hardware implementations. The hardware can be generated to accelerate the entire classification process (train, inference, retrain) or just some tasks, deciding, for example, to execute the train and retrain in software and instantiate only the hardware for the inference, as commonly done for embedded applications.
<center>
![#](./doc/img/theory/aeneas_model_nobg.png#gh-light-mode-only)
![#](./doc/img/theory/aeneas_model_nobg_dark.png#gh-dark-mode-only)
</center>
The system automatically generates all the configuration files required by the following entities and instantiates the model in software and hardware. 
Thanks to the versatile AeneasHDC library, the software model can be produced in Python, Matlab, or C++. The model is executed, and the results in terms of accuracy and other performance metrics are collected. The data required for inference are extracted and passed to the hardware model.
    
The hardware architecture is generated using the Xilinx Vitis High-Level Synthesis (HLS) tool and then synthesized, simulated and tested using Vivado 2023. The data about energy consumption, execution time and resource allocation are collected from the design.
    
All the results obtained from the software and the hardware implementations are finally relayed to a dedicated report-generation module that compiles a comprehensive HTML-based summary, encapsulating all the information from the run simulations. The summary includes details of the model configuration, dataset specifications, chosen programming language, target hardware platform, and key performance metrics such as execution time, memory usage, energy consumption, and resource utilization.
This report is stored locally and can be readily accessible through the user-friendly GUI, which organizes all conducted tests and allows to review and compare different runs. 

The entire process is engineered to be fully automated, abstracting complex or time-consuming tasks associated with coding models or designing custom hardware architectures. The GUI is an efficient singular point of control that enables users to manage the model at every stage. However, AeneasHDC is completely open-source and makes all its libraries and scripts accessible. <a href="#-documentation">Extensive documentation</a> is provided, covering the basic usage of the model, the theoretical concepts behind parameter selections, and detailed insights into the underlying code and library functions.
    
The AeneasHDC environment is always in evolution and we are constantly adding new models and techniques, aiming to keep up with all the innovations in the literature
However, the model is completely open-source, and the user can easily extend the software and hardware libraries to include new desired models. The detailed how-to-use manual is on GitHub.
We always encourage community <a href="#-contribution">collaboration</a> to enhance and evolve the framework over time. If you have any questions or need help, please <a href="#-contact">contact</a> the support team.
</p>

---

## 🚀 Getting Started

**Prerequisites**:
- **Python**: Mandatory 
- **C++** (Optional)
- **Matlab** (Optional)

#### FPGA Development Tools
- **Xilinx Vivado Suite 2023**
- **Xilinx High-Level Synthesis (HLS) tool, Vitis 2023**
**Installation**:
```bash
$ git clone https://github.com/AeneasHDC/Reconfigurable_HDC_Platform.git
$ cd Reconfigurable_HDC_Platform
$ run run.bat
$ you can find "Getting Started" guides and examples in the ./tests directory.
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
├── tests/                   # getting started and examples.
│
└── usr_config/              # Users Configuration.
```
</details>

---

## 🖥 Usage

---

## 📜 Publications

---

![QR Code for 2023 Publication](./qrcodes/2023_AeneasHyperCompute.png)

### 📘 **2023 - Aeneas HyperCompute: Revolutionizing Vector Operations**

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

---


---

## ⚖️ License

This project is fortified with the Apache license. For more details, please refer to [LICENSE.txt](./LICENSE.txt).

---

---

## 🌟 Acknowledgements

We owe our gratitude to:
- **Prof. Mauro Oliveri** - Work supervisor 📧 [Email](mailto: mauro.olivieri@uniroma1.it)
- **Dr. Antonello Rosato** - Professor of the HDC course at Sapienza

---

## 📞 Contact

For any collaboration, get in touch with our lead developers:

- **Marco Angioli** - 📧 [Email](mailto:marco.angioli@uniroma1.it)
- **Saeid Jamili** - 📧 [Email](mailto:saeid.jamili@uniroma1.it)

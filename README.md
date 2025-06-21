# EEG Alpha Power Analysis (NEMAR ds004148)  
MATLAB script to compare eyes-open vs. eyes-closed alpha power using EEGLAB. 

### Tools Used
- Dataset: https://nemar.org/dataexplorer/detail?dataset_id=ds004148
- MATLAB
- EEGLAB

### Brief Procedure
1. Downloaded datasets from NEMAR and loaded into MATLAB.
2. Using basic MATLAB code and EEGLAB functions, calculated spectral power difference between Eyes Closed and Eyes Open datasets with 7-13 Hz as the (relaxed) alpha band.
3. Plotted scalp topography of the results.

### Repository Structure
eeg-spectral-topoplot/ \
├── data/                                                # Datasets for Subject 01 \
│   ├── sub-01_ses-session1_task-eyesopen_eeg.set        # Eyes-open \
│   └── sub-01_ses-session1_task-eyesclosed_eeg.set      # Eyes-closed \
├── figures/                                              # Output visualizations \
│   └── Topoplot.png                                      # topoplot \
├── scripts/                                              # MATLAB scripts \
│   └── psd_diff_assessment.m                             # Main Code \
└── README.md                                            # Project documentation 

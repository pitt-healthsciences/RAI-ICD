# RAI-ICD
This repository contains code to calculate the RAI-ICD as described in the following paper:

Adaptation, Recalibration, and Validation of the Risk Analysis Index for Frailty Assessment Using International Classification of Diseases Codes
Khamzina et. al.

Contact:
Reitzkm2@upmc.edu
Khamzinay2@upmc.edu

Calculating RAI-ICD requires dataset of interest with diagnoses based on International Classification of Diseases, Tenth Revision, Clinical Modification (ICD-10-CM) codes and basic demographic information (age, sex). Then running the attached ‘NIS_RAI-ICD_main_model.do’ file using Stata.

Depending on the number of available ICD-10-CM codes in the dataset the lines ‘foreach num of numlist 1/40’ should be adjusted accordingly where number 40 is replaces by the maximum number of available ICD-10-CM codes in the new dataset.

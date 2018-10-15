# About CalPred

## Overview
 
CalPred is a "tool for EF-hand calcium binding protein prediction and calcium binding region identification" using machine learning techniques. It is a free web based software package and is accessible via world wide web from various platforms. It integrates a range of currently available open source and / or free software packages such as SNNS, EMBOSS and SVM<sup>light</sup>, Cygwin and Microweb server for the purpose of anlysing the protein nature and identification of the calcium binding regions in the given protein. CalPred Server is available for free download as a portable server to promote open source spirit and to reduce the load on our servers.


## CalPred key features: Usability of program.

The key features of CalPred include:

- It gives output of protein statistics from PEPSTATS program of EMBOSS package that has been used to train the "first level" filter of the CalPred program. 
- It detects sequences which belong to the calcium binding protein family, but have not been picked up by the "EF-hand calcium-binding domain" pattern sited as PS00018 entry of Prosite database. 
- It predicts specific calcium-binding regions in the query protein, i.e. the prediction is done for every amino acid residue present in the protein. 
- It is free of charge. 
- It is downloadable as a open source project in form of standalone portable server for in-house use.

## What are the different applications and how are they organised?

Currently there are ten applications incorporated in CalPred. These different applications are: 

- ANN<sub>pepstats</sub> : It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a neural network model of architecture (51-4-1) to predict the nature of protein i.e. whether its calcium binding or not.
- ANN<sub>binary</sub> : It takes a protein sequence as input and encodes it in binary format (for more info. see user docs) and queries a neural network model of architecture (260-20-1) to predict the nature of a particular amino acid residue.
- ANN<sub>pssm</sub> : It takes a protein sequence as input and creates its PSSM matrix using PSI-BLAST (for more info. see user docs) and queries a neural network model of architecture (260-20-1) to predict the nature of a particular amino acid residue.
- Prosite Scan : It takes a protein sequence as input as performs simple pattern mathching using "EF-hand calcium-binding domain" pattern i.e. PS00018 entry of Prosite database.
 - SVM<sub>pepstats_linear</sub> : It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a "linear" kernel type to predict the nature of protein.
 - SVM<sub>pepstats_polynomial</sub> : It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a polynomial kernel type to predict the nature of protein.
 - SVM<sub>pepstats_radial_bais</sub> : It also takes protein properties from PEPSTATS module of EMBOSS package as input to query a support vector machine (SVM) model with a "radial bais" kernel type and predicts the nature of protein.
 - SVM<sub>pepstats_sigmoidal_tanh</sub> : It also takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a "sigmoidal tanh" kernel type and predicts the nature of protein i.e. whether its calcium binding or not.
 - SVM<sub>binary</sub> : It takes a protein sequence as input and encodes it in binary format (for more info. see user docs) and queries a support vector machine (SVM) model with a "linear" type kernal to predict the nature of a particular amino acid residue.
 - SVM<sub>pssm</sub> : It takes a protein sequence as input and creates its PSSM matrix using PSI-BLAST (for more info. see user docs) and queries a support vector machine (SVM) model with a "linear" type kernal to predict the nature of a particular amino acid residue.

These different applications are organised to form a workflow as depicted in the figure below. To know more about the workflow and the validity of the models see the User documentation. 


## CalPred citation

"CalPred: A tool for EF-hand calcium binding protein prediction and calcium binding region identification." Jaiswal, K.; Kumar, C.; and Naik, P. K. Department of Bioinformatics and Biotechnology. Jaypee University of Information Technology, India. 

## Disclaimer

This software is free only for non-commercial use. It must not be distributed as whole without prior permission of the author but some parts of the software can be redistributed and / or modified as stated in the License. The author is not responsible for implications from the use of this software.

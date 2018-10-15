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

![Calpred workflow](/images/model.JPG)

## CalPred citation

"CalPred: A tool for EF-hand calcium binding protein prediction and calcium binding region identification." Jaiswal, K.; Kumar, C.; and Naik, P. K. Department of Bioinformatics and Biotechnology. Jaypee University of Information Technology, India. 

## Installation

Installation of server (Windows).

CalPred will be installed in-place but it requires some external software to be installed in your system. These are listed below:

- The redistributable microweb server ([link] (http://www.indigostar.com/download/microweb-1.31.zip)).
- The NCBI BLAST-GP program. ([link] (ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/blast-2.2.15-ia32-win32.exe)).
- PEPSTATS program of EMBOSSWIN ( [download link] (http://www.interactive-biosoftware.com/embosswin/embosswin-0.8-setup.exe) ) package.
- And svm_classify program of SVMlight ( [link] (http://svmlight.joachims.org/) ).

These must be installed prior to installation of CalPred server and the users must conform to licenses of these softwares before using them.

Installation Steps:

- Step 1: Uncompress the downloaded CalPred server by using any of the freely avaliable programs such as Winrar / Winzip into "yourfolder"

- Step 2: Download the microweb server that comes under non-redistributable license and unzip it.

- Step 3 : Now in the CalPred server folder there will be two sub - folders "cgi-bin" and "htdocs", copy the contents of these folders into the same respective folder in microweb server.

- Step 4 : BLAST-GP is enhanced BLAST, which supports gaps, developed by the NCBI software group. There is an executable which is necessary for CalPred i.e. blastgp.exe. Please copy "ncbi.ini" file, "data" folder and "blastgp.exe" file into "yourfolder\microweb-1.31\cgi-bin\". Make sure that "ncbi.ini" points to "data" folder's location i.e. edit second line as Data="data".

- Step 5: Download EMBOSSWIN and install it on you computer. The EMBOSSWIN is installed by default, in C:/ drive of your computer. If it does'nt, then change the path of installation to "C:\EMBOSSwin". If due to any reasons you are unable to do so, then change these enviornmental variable in "prog.cgi" (in 'yourfolder\microweb-1.31\cgi-bin\') script:

$ENV{'EMBOSSWIN'}="C:/EMBOSSwin"; to $ENV{'EMBOSSWIN'}="your_path ";
$ENV{'EMBOSS_DATA'}="C:/EMBOSSwin/data"; to $ENV{'EMBOSS_DATA'}="your_path/data";
$ENV{'Path'}="C:/EMBOSSwin"; to $ENV{'Path'}="your_path";

Copy "pepstats.exe" from "your_path " to "yourfolder\microweb-1.31\cgi-bin\".

- Step 6 : Download SVMlight from its home page (freely available for non-commercial use) and place "svm_classify.exe" into "yourfolder\microweb-1.31\cgi-bin\" directory. If everything goes well, your server should be ready for use now. Start the server using the microweb icon.

Note:

At the start of server, there might be a security warning in the iexplorer's (if you using it) information bar just right click that bar, and check the "Allow this page to access my computer" option. This will redirect you to server homepage.

## Disclaimer

This software is free only for non-commercial use. It must not be distributed as whole without prior permission of the author but some parts of the software can be redistributed and / or modified as stated in the License. The author is not responsible for implications from the use of this software.

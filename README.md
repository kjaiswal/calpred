<div align="center">[![](BiO-logo3.gif)](http://www.bioinformatics.org/)                              ![](calpred.jpg)

<table width="100%">

<tbody>

<tr>

<td height="17" background="header.JPG">

<div align="center"><font color="#FFFFFF" size="2">[<span style="COLOR: #ffffff">About CalPred</span>](index.html)           |           [ <span style="COLOR: #ffffff">Application</span>](http://www.juit.ac.in/calpred/application.html)               |             [ <span style="COLOR: #ffffff">Downloads</span>](download.html)              |             [<span style="COLOR: #ffffff">License</span> ](license.html)             |              [<span style="COLOR: #ffffff">User docs</span>](user_docs.html)               |             [<span style="COLOR: #ffffff">Get Involved</span>](volunteer.html)              |                [ <span style="COLOR: #ffffff">Credits</span>](credit.html)</font></div>

</td>

</tr>

</tbody>

</table>

<font color="#000000" size="6">About CalPred</font> <font color="#000000" size="5">Contents</font><font size="4">

<div align="left">

<div align="left">* <font color="#000000" size="4">[<span style="COLOR: black">Overveiw.</span>](index.html#Overveiw)</font> * <font size="4">[<span style="COLOR: black">CalPred key features: Usability of program.</span>](index.html#features)</font> * <font size="4">[<span style="COLOR: black">What are the different applications and how are they organised?</span>](index.html#organisation)</font> * <font size="4">[<span style="COLOR: black">CalPred citation.</span>](index.html#citation)</font> * <font size="4">[<span style="COLOR: black">Disclaimer.</span>](index.html#disclaimer)</font></div>

</div>

* * * <font color="#000000" size="4"><a id="Overview" name="Overview"></a><font size="5">Overveiw</font></font> CalPred is a "tool for EF-hand calcium binding protein prediction and calcium binding region identification" using machine learning techniques. It is a free web based software package and is accessible via world wide web from various platforms. It integrates a range of currently available open source and / or free software packages such as SNNS, EMBOSS and SVM<sup>light</sup>, Cygwin and Microweb server for the purpose of anlysing the protein nature and identification of the calcium binding regions in the given protein. CalPred Server is available for free download as a portable server to promote open source spirit and to reduce the load on our servers. * * *

<div align="left"><font color="#000000" size="5"><a id="features" name="features"></a>CalPred key features: Usability of program.</font></div>

The key features of CalPred include:

<div align="left">* It gives output of protein statistics from PEPSTATS program of EMBOSS package that has been used to train the "first level" filter of the CalPred program. * It detects sequences which belong to the calcium binding protein family, but have not been picked up by the "EF-hand calcium-binding domain" pattern sited as PS00018 entry of Prosite database. * It predicts specific calcium-binding regions in the query protein, i.e. the prediction is done for every amino acid residue present in the protein. * It is free of charge. * It is downloadable as a open source project in form of standalone portable server for in-house use.</div>

* * * <font color="#000000" size="5"><a id="organisation" name="organisation"></a>What are the different applications and how are they organised?</font> Currenty there are ten applications incooperated in CalPred. These different applications are: *

<div align="left">**_ANN<sub>pepstats</sub> :_** It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a neural network model of architecture (51-4-1) to predict the nature of protein i.e. whether its calcium binding or not.</div>

*

<div align="left">**_ANN<sub>binary</sub> :_** It takes a protein sequence as input and encodes it in binary format (for more info. see user docs) and queries a neural network model of architecture (260-20-1) to predict the nature of a particular amino acid residue.</div>

*

<div align="left">**_ANN<sub>pssm</sub> :_** It takes a protein sequence as input and creates its PSSM matrix using PSI-BLAST (for more info. see user docs) and queries a neural network model of architecture (260-20-1) to predict the nature of a particular amino acid residue.</div>

*

<div align="left">**_Prosite Scan_** : It takes a protein sequence as input as performs simple pattern mathching using "EF-hand calcium-binding domain" pattern i.e. PS00018 entry of Prosite database.</div>

*

<div align="left">**_SVM<sub>pepstats_linear</sub> :_ **It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a "linear" kernel type to predict the nature of protein.</div>

*

<div align="left">

<div align="left">**_SVM<sub>pepstats_polynomial</sub> :_ **It takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a polynomial kernel type to predict the nature of protein.</div>

</div>

*

<div align="left">**_SVM<sub>pepstats_radial_bais</sub> :_ **It also takes protein properties from PEPSTATS module of EMBOSS package as input to query a support vector machine (SVM) model with a "radial bais" kernel type and predicts the nature of protein.</div>

*

<div align="left">**_SVM<sub>pepstats_sigmoidal_tanh</sub> :_ **It also takes protein properties from PEPSTATS module of EMBOSS package as input and queries a support vector machine (SVM) model with a "sigmoidal tanh" kernel type and predicts the nature of protein i.e. whether its calcium binding or not.</div>

*

<div align="left">

<div align="left">**_SVM<sub>binary</sub> :_ **It takes a protein sequence as input and encodes it in binary format (for more info. see user docs) and queries a support vector machine (SVM) model with a "linear" type kernal to predict the nature of a particular amino acid residue.</div>

</div>

*

<div align="left">**_SVM<sub>pssm</sub> :_ **It takes a protein sequence as input and creates its PSSM matrix using PSI-BLAST (for more info. see user docs) and queries a support vector machine (SVM) model with a "linear" type kernal to predict the nature of a particular amino acid residue.</div>

These different applications are organised to form a workflow as depicted in the figure below. To know more about the workflow and the validity of the models see the User documentation. ![](model.JPG) * * * <font color="#000000" size="5"><a id="citation" name="citation"></a>CalPred citation.</font> "CalPred: A tool for EF-hand calcium binding protein prediction and calcium binding region identification." Jaiswal, K.; Kumar, C.; and Naik, P. K. Department of Bioinformatics and Biotechnology. Jaypee University of Information Technology, India. * * * <font color="#000000" size="5"><a id="disclaimer" name="disclaimer"></a>Disclaimer</font><font size="5">.</font> This software is free only for non-commercial use. It must not be distributed as whole without prior permission of the author but some parts of the software can be redistributed and / or modified as stated in the License. The author is not responsible for implications from the use of this software. * * *

<table width="100%">

<tbody>

<tr>

<td height="17" background="header.JPG">

<div align="center"><font color="#FFFFFF" size="2">[<span style="COLOR: #ffffff">About CalPred</span>](index.html)           |           [ <span style="COLOR: #ffffff">Application</span>](http://www.juit.ac.in/calpred/application.html)               |             [ <span style="COLOR: #ffffff">Downloads</span>](download.html)              |             [<span style="COLOR: #ffffff">License</span> ](license.html)             |              [<span style="COLOR: #ffffff">User docs</span>](user_docs.html)               |             [<span style="COLOR: #ffffff">Get Involved</span>](volunteer.html)              |                [ <span style="COLOR: #ffffff">Credits</span>](credit.html)</font></div>

</td>

</tr>

</tbody>

</table>

<div align="left">[<font color="#000000" size="3">Click here to provide us your feedback</font>](http://www.juit.ac.in/calprerd/feedback.html)</div>

<table border="0" cellspacing="0" cellpadding="0" align="center">

<tbody>

<tr>

<td width="15" valign="top">[![BioBanner - free advertising for BioScience web sites.](http://bioinformatics.org/biobanner/biobannerl.gif)](http://bioinformatics.org/biobanner)</td>

<td width="468" valign="top"><iframe width="468" height="60" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" src="http://bioinformatics.org/biobanner/banner.php?no=f604666311af1e062009802c37a3a709&amp;type=iframe"><script type="text/javascript"> document.write("<scr"+"ipt type='text/javascript'"); document.write("src='http://bioinformatics.org/biobanner/banner.php?no=f604666311af1e062009802c37a3a709&type=js'>"); document.write("</scr"+"ipt>"); </script> <noscript> <center> <b>Please, enable JavaScript to see BioBanner.</b> </center> </noscript></iframe></td>

<td width="15" valign="top">[![BioBanner - free advertising for BioScience web sites.](http://bioinformatics.org/biobanner/biobannerr.gif)](http://bioinformatics.org/biobanner)</td>

</tr>

</tbody>

</table>

</font></div>
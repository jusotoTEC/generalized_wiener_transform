# MATLAB Code from Numerical Experiments in Paper *"Fast transforms of random vectors within Wiener filtering paradigm"*

## Author

* Pablo Soto-Quiros (https://www.tec.ac.cr/juan-pablo-soto-quiros) - Email: jusoto@tec.ac.cr
* Anatoli Torokhti (https://people.unisa.edu.au/anatoli.torokhti) - Email: anatoli.torokhti@unisa.edu.au

Pablo Soto-Quiros is an Associate Professor from the *Instituto Tecnológico de Costa Rica* (https://www.tec.ac.cr/) in Cartago, Costa Rica

Anatoli Torokhti is an Associate Professor from the *University of South Australia* (https://www.unisa.edu.au/) in Mawson Lakes, SA, Australia

## Description

* This repository contains the MATLAB code for numerical experiments presented in the paper "*Fast transforms of random vectors within Wiener filtering paradigm*". 
* This paper has been submitted for publication in a scientific journal. 
* We propose and study two techniques for the fast numerical implementation of a  random vector transform within Wiener filtering paradigm. In signal processing terminology, the transform is interpreted as an optimal filter. The proposed transform aims to minimize the sum of distances between a reference random vector ${\bf x}_i$ and its transformed counterpart  ${\bf y}_i$, for all $i=1,...,p$. In contrast to known techniques where the transform consists of $p$ matrices that minimize a difference between a single reference random vector and $p$ observed random vectors, the proposed transform uses a single optimal matrix to transform $p$ random vectors. This device is more economical since implies computation of only one optimal matrix.  It requires less computational work for the associated numerical realization. Nevertheless, a direct numerical realization  of the transform involves computation of the covariance matrix pseudo-inverse and the matrix square root which might be large, and then are computationally expensive. Proposed fast versions of the transform  allow us to avoid that computation and, as a result, accelerate the associated numerical realization. While the fast proposed techniques  are approximate versions of the original transform, it is shown that their accuracies are very close to the accuracy of the original transform. A thorough  analysis of the associated errors is provided. The effectiveness of the proposed transform is illustrated by  numerical experiments in four real-world scenarios.


<p align="center"><img width="1200" src="https://github.com/jusotoTEC/multifiltering_transform/blob/main/img/img1.png"></p>

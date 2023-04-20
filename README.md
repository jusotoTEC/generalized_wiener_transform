# MATLAB Code from Numerical Experiments in Paper *"Optimal transform of random vectors: minimising the distance between an unknown set of random vectors and transformed observations"*

## Author

Pablo Soto-Quiros (https://www.tec.ac.cr/juan-pablo-soto-quiros) - Email: jusoto@tec.ac.cr
Anatoli Torokhti (https://people.unisa.edu.au/anatoli.torokhti) - Email: anatoli.torokhti@unisa.edu.au

Pablo Soto-Quiros is an Associate Professor from the *Instituto Tecnológico de Costa Rica* (https://www.tec.ac.cr/) in Cartago, Costa Rica
Anatoli Torokhti is an Associate Professor from the *Univeristy of South Australia* (https://www.unisa.edu.au/) in Mawson Lakes, SA, Australia

## Description

* This repository contains the MATLAB code for numerical experiments presented in the paper "*Optimal transform of random vectors: minimising the distance between an unknown set of random vectors and transformed observations*". 
* This paper has been submitted for publication in a scientific journal. 
* In this paper We propose and study a novel approach to the transformation of the sets of random vectors.  The proposed transform aims to minimize the sum of distances between a reference random vector $\bfx_i$ and its transformed counterpart  $\bfy_i$, for all $i=1,...,p$. In contrast to known techniques where the transform consists of $p$ matrices that minimize a difference between a single reference random vector and $p$ observed random vectors, the developed transform uses a single optimal matrix to transform $p$ random vectors. This device is more economical since implies computation of only one optimal matrix.  It requires less computational work for the associated numerical realization. Two particular fast versions of the transform are provided that allow us to avoid computation of the covariance matrix pseudo-inverse and the matrix square root which are computationally expensive. It accelerates the associated numerical realization. While the fast proposed techniques  are approximate versions of the original transform, it is shown that their accuracies are very close to the accuracy of the original transform. A thorough  analysis of the associated errors is provided. The effectiveness of the proposed transform is illustrated by numerical experiments. In particular, one of the experiments demonstrates the efficiency of the developed techniques in the practical application  to denoising images.

<p align="center"><img width="1200" src="https://github.com/jusotoTEC/multifiltering_transform/blob/main/img/img1.png"></p>

This is the implementation of Bundle Adjustment.

the sample output is below:

![BundleAdjustment](https://github.com/WD4715/SlamPortfolio/assets/117700793/7e7cc238-2fe6-4073-8295-03e739ddd6fd)

**1. Linear System and Kalman Filter**
  - We know that every measurement is affected by nois, so the pose *x* and landmark *y* here are regarded as **Random Variable that obey certain probability distriubtion instead of a single number.**
    Therefore, the question becomes: when I have some motion data *u* and observation data *z*, how to determine the state *x* and larmarks *y*'s distribution?

  - Let be :

    $$
    x_k = \set{x_1, y_1, y_2, ..., y_m}
    $$

    At the same time, all observations at time *k* are denoted as *z<sub>k</sub>.*

  - We hope to use the data from 0 to k to estimate the current state distribution:

$$
P(x_k|x_0, u_{1:k}, z_{1:k}) 
\propto
P(z_k|x_k) P(x_k|x_0, u_{1:k}, z_{1:k-1})
$$

  - *P(z<sub>k</sub>|x<sub>k</sub>)* will be the *likelihood* and *P(x<sub>k</sub>|x<sub>0</sub>, u<sub>1:k</sub>, z<sub>1:k-1</sub>)* will be the prior.
  **The observation equation** gives the likelihood. And **the prior** can transform below:
  
$$
P(x_k|x_0, u_{1:k}, z_{1:k-1})
= \int{P(x_k|x_{k-1}, x_0, u_{1:k}, z_{1:k-1}) P(x_{k_1}|x_0, u_{1:k}, z_{1:k-1})dx_{k-1}}
$$

If we assume **Markov Chain** the above prior can be written below:

$$
\int{P(x_k|x_{k-1}, x_0, u_{1:k}, z_{1:k-1}) P(x_{k_1}|x_0, u_{1:k}, z_{1:k-1})dx_{k-1}}
=\int{P(x_k|x_{k-1}, x_0, u_{k}) P(x_{k_1}|x_0, u_{1:k-1}, z_{1:k-1})dx_{k-1}}
$$

  - This equation is actually the state distribution at time k-1. Then ***"How to derive the state distribution from time k-1 to time k?"***
  Answer : We only need to maintain the current state estimation and update it incrementally. Futhermore, if it is assumed that the state quantity obes a ***Gaussian Distribution***, we only need to consider the state variable's mean and covariance.

  - Tip :
    Let's denote Posterior state estimation at time k-1 :


$$
\begin{equation}
	Posterior State Distribution Mean : \hat{x}_{k-1} 
\end{equation}
$$

$$
\begin{equation}
	Prior State Distribution Mean : \check{x}_{k-1}
\end{equation}
$$

$$
\begin{equation}
	Posterior State Distribution Covariance : \hat{P}_{k-1} 
\end{equation}
$$

$$
\begin{equation}
	Prior State Distribution Covariance : \check{P}_{k-1}
\end{equation}
$$

  And Let's set the Linear Gaussian system like below :

$$
\begin{equation}
	x_k = A_k x_{k-1} + u_k + w_k  
\end{equation}
$$

$$
\begin{equation}
	z_k = C_K x_k +v_k 
\end{equation}
$$

  We assume that ***state*** and ***noise*** all ***Gaussian*** :


$$
\begin{equation}
	\mathcal{w_k} \sim \mathcal{N}(0, R))
\end{equation}
$$

$$
\begin{equation}
\mathcal{v_k} \sim \mathcal{N}(0, Q))
\end{equation} 
$$

  - If we use the Guassian Linear System and transform this equation we will get the result below:

1. Predict
   
$\check{x}_{k}=A_k\hat{x}$ *<sub>k-1</sub> + u<sub>k</sub>*  and $\check{P}_k=A_k\hat{P}$ *<sub>k-1</sub> A<sub>k</sub><sup>T</sup> + R*

2. Update (Kalman gain)

 K = $\check{P}_k$ *C<sub>k</sub><sup>T</sup> (C<sub>k</sub>* $\check{P}_k$ *C<sub>k</sub><sup>T</sup>+Q<sub>k</sub>)<sup>-1</sup>*   
   
3. Posterior 

 $\hat{x}_k=\check{x}_k+K(z_k-C_kx_k)$ and $\hat{P}_k=(I-KC_k)\check{P}_k$

**2. Non-Linear System and Kalman Filter**
	- The motion equation and observation equation in SLAM are usally nonlinear functions, especially the camera model in visual slam, which requires the camera projection model and the pose represented by SE(3).
 	***A Gaussian distribution, after a nonlinear transformation, is often no longer Gaussian.*** 
  	***Therefore,in a nonlinear system, we will get Extended Kalman Filter. The usual approach is to consider the first-order Taylor expansion of the motion equation and the observation equation near a certain point.***
	
- Pose Estimation
  
<div align="center">
	
***x<sub>k</sub>*** $\approx{\hat{f}(x}$ *<sub>k</sub>, u<sub>k</sub>) +* $\partial{f} \over \partial{x}$ *<sub>k-1</sub>* | <sub> $\hat{x}_{k-1}$ </sub> *(x<sub>k-1</sub> -* $\hat{x}$ *<sub>k-1</sub>) + w<sub>k</sub>* 

</div>

- Observation Model

<div align="center">

***z<sub>k</sub>*** $\approx{h(x}$ *<sub>k</sub>) +* $\partial{h} \over \partial{x}$ *<sub>k</sub>* | <sub> $\hat{x}_{k}$ </sub> *(x<sub>k</sub> -* $\hat{x}$ *<sub>k</sub>) + n<sub>k</sub>* 

</div>

1. Predict

<div align="center">

$\check{x}_{k}=f(\hat{x}$ *<sub>k-1</sub>, u <sub>k</sub>)* , and $\check{P}_k$ ***=F*** $\hat{P}$ ***<sub>k-1</sub>F<sup>T</sup>+R<sub>k</sub>***

</div>


2. Update (Kalman gain)

<div align="center">

 K = ***P<sub>k</sub>H<sup>T</sub>(HP<sub>k</sub>H<sup>T</sup>)<sup>-1<sup>***

</div>

 where 

<div align="center">

 ***F=*** $\partial{f}\over \partial{x}$ *<sub>k-1</sub>* | *x<sub><sub>k-1</sub></sub>*

 ***H=*** $\partial{h}\over \partial{x}$ *<sub>k</sub>* | *x<sub><sub>k</sub></sub>*

</div>
 
3. Posterior

<div align="center">

$\hat{x}_k = \check{x_k} + K_k(z_k - h(\check{x_k}))$

</div>

<div align="center">

$\hat{P}_k = (I-K_hH)\check{P}_k$

</div>

 

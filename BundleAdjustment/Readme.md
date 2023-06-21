This is the implementation of Bundle Adjustment.

the sample output is below:

![BundleAdjustment](https://github.com/WD4715/SlamPortfolio/assets/117700793/7e7cc238-2fe6-4073-8295-03e739ddd6fd)


## 1. Linear System and Kalman Filter
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

### 1. Predict
   
$\check{x}_{k}=A_k\hat{x}$ *<sub>k-1</sub> + u<sub>k</sub>*  and $\check{P}_k=A_k\hat{P}$ *<sub>k-1</sub> A<sub>k</sub><sup>T</sup> + R*

### 2. Update (Kalman gain)

 K = $\check{P}_k$ *C<sub>k</sub><sup>T</sup> (C<sub>k</sub>* $\check{P}_k$ *C<sub>k</sub><sup>T</sup>+Q<sub>k</sub>)<sup>-1</sup>*   
   
### 3. Posterior 

 $\hat{x}_k=\check{x}_k+K(z_k-C_kx_k)$ and $\hat{P}_k=(I-KC_k)\check{P}_k$

## 2. Non-Linear System and Kalman Filter
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

### 1. Predict

<div align="center">

$\check{x}_{k}=f(\hat{x}$ *<sub>k-1</sub>, u <sub>k</sub>)* , and $\check{P}_k$ ***=F*** $\hat{P}$ ***<sub>k-1</sub>F<sup>T</sup>+R<sub>k</sub>***

</div>


### 2. Update (Kalman gain)

<div align="center">

 K = ***P<sub>k</sub>H<sup>T</sub>(HP<sub>k</sub>H<sup>T</sup>)<sup>-1<sup>***

</div>

 where 

<div align="center">

 ***F=*** $\partial{f}\over \partial{x}$ *<sub>k-1</sub>* | *x<sub><sub>k-1</sub></sub>*

 ***H=*** $\partial{h}\over \partial{x}$ *<sub>k</sub>* | *x<sub><sub>k</sub></sub>*

</div>
 
### 3. Posterior

<div align="center">

$\hat{x}_k = \check{x_k} + K_k(z_k - h(\check{x_k}))$

</div>

<div align="center">

$\hat{P}_k = (I-K_hH)\check{P}_k$

</div>

## 3. Bundle Adjustment and Graph Optimization
	
### 1. The Projection Model and Cost Function
Let's denote that the observation model h():

$$
\mathcal{z}=\mathcal{h}(\mathcal{x}, \mathcal{y})
$$

Specially the ***x*** here refers to the pose of the camera. ->***x*** = ***R & T***(***T***) and y is the three-dimensional landmark ***p<sub>j</sub>***
and look at the ***z***. ***z*** is the observation data which is the pixel coordinate at normalized plane. 
and from the above information, we can write out the error of observation:

$$
\mathcal{e}=\mathcal{z} - \mathcal{h}(\mathcal{x}, \mathcal{y})
$$

Solving the least squares is equivalent to adjusting the pose and road signs at the same time, which is the so-called ***Bundle Adjustment***.

### 2. Solving Bundle Adjustment

- Although a single error term is only for one pose and one landmark, the overall BA is about optimizing all variables together.

$$
||\mathcal{f}(x+ \Delta x)||^2 \approx{} {{1} \over {2}} \Sigma_{i=1}^{m} \Sigma_{j=1}^{n} ||e_{ij}+\mathcal{F_{ij}}\Delta \epsilon +\mathcal{E_{ij}} \Delta \mathcal{p_j}||
$$

where F<sub>ij</sub> is the partial derivative of the entire cost function to the i-th pose, and E<sub>ij</sub> is the partial derivative of the function to the j-th landamrk.

-> Then whether we use the Gauss Newton method or the Levenberg-Marguardt method, we will finallly face the incremental linear equation:

$$
\mathcal{H} \Delta \mathcal{x} = \mathcal{g}
$$

If we use the Gauss Newton : $\mathcal{H} = \mathcal{J}^T \mathcal{J}$ and Levenberg-Marguardt method : $\mathcal{H} = \mathcal{J}^T \mathcal{J} + \lambda I$ 

### 3. Sparsity

An important development of visual slam in the 21st century is to recognize the sparse structure of the matrix ***H***. The sparsity of the ***H*** matrix is caused by the Jacobian matrix ***J(x)***.
Note that this error term only describes the residual about ***p<sub>j</sub> in T<sub>i</sub>***, and only involves the i-th camera pose and the j-th landmark. The derivatives of the remaining variables are all 0. Therefor, the Jacobian matrix corresponding to the error term has the following form:

$$
\mathcal{J_{ij}}(x) = (0_{2x6}, 0_{2x6}, 0_{2x6}, ..., {\partial{\mathcal{e_{ij}}} \over \partial{\mathcal{T_i}}}, ..., 0_{2x3}, 0_{2x3}, 0_{2x3}, ..., {\partial{\mathcal{e_{ij}}} \over \partial{\mathcal{p_i}}}, ... ,0_{2x3}) 
$$

![KakaoTalk_20230620_175212938](https://github.com/WD4715/SlamPortfolio/assets/117700793/b8607244-169e-4206-8dcf-83c5aff74794)

Let's denote the H like below:

$$
\begin{equation}
   \mathcal{H} = \begin{matrix} 
   H_{11} & H_{12}   \\
   H_{21} & H_{22}  \\
   \end{matrix} 
\end{equation}
$$

Where ***H<sub>11</sub>*** is only related to camera poses and ***H_{22}*** is only to landmarks.


For example Jacobian and Hessian will be like below:

![KakaoTalk_20230620_181549964](https://github.com/WD4715/SlamPortfolio/assets/117700793/20784f2f-abdd-440d-92f9-9ec27b6b1130)

 ![KakaoTalk_20230620_181603053](https://github.com/WD4715/SlamPortfolio/assets/117700793/176534a8-76f3-4cf5-978d-4b6de6afae2d)

Therefore, the non-zero matrix block in the non-diagonal part of the ***H*** matrix can be understood as a connection between its corresponding two variables, or it can be called a constraint. Therefore, we found that the graph optimization structure is obviously related to the sparsity of the incremental equation.

### 4. Schur Trick

Schur Trick is known as the marginalization in SLAM research. The Linear Equation ***Hx=g*** can be rewritten as :

$$
\begin{equation}
   \begin{bmatrix} 
   B & E  \\
   E^{T} & C  \\
   \end{bmatrix}
   \begin{bmatrix} 
   \Delta x_{c} \\ 
   \Delta x_{p}  \\
   \end{bmatrix}=
   \begin{bmatrix} 
   v \\ 
   w \\
   \end{bmatrix}
\end{equation}
$$

the above equation can be written like below(Gaussian Elimination on the linear equation): 

$$
\begin{equation}
   \begin{bmatrix} 
   I & -EC^{-1}  \\
   0 & I  \\
   \end{bmatrix}
   \begin{bmatrix} 
   B & E  \\
   E^{T} & C  \\
   \end{bmatrix}
   \begin{bmatrix} 
   \Delta x_{c} \\ 
   \Delta x_{p}  \\
   \end{bmatrix}=
   \begin{bmatrix} 
   I & -EC^{-1}  \\
   0 & I  \\
   \end{bmatrix}
   \begin{bmatrix} 
   v \\ 
   w \\
   \end{bmatrix}
\end{equation}
$$

After the elimination, the first line of the equations becomes a term that has nothing to do with $\Delta x_p$. Take it out separately and get the incremental equation about the pose part:
The Schur trick is to solve this equation first, then substitute the solved $\Delta x_c$ into the original equation, and then solve $\Delta x_p$. This process is called *marginalization or Schur elimination(Schur Trick)*

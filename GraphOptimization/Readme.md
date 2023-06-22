# Graph Optimization

The Optimization process will be viewd below:
![Optimization_process](https://github.com/WD4715/SlamPortfolio/assets/117700793/18bc9c9f-ab2b-4ae2-9fb7-e9975668a95e)


## 1. Definition of Pose Graph

- We are inclined to fix the feature points after a few iterations and only regard them as ***constraints*** of pose estimation instead of actually optimizing their position.

- Then, ***Can we ignore the landmarks at all and only focus on their position?***  ***We can constuct a graph optimizationn with only pose variables.*** The edge between the pose vertices can be set with measurement by ego-motion estimation obtained from feature matching. The difference is that once the initial estimation is completed,  ***we no longer optimize the positions of those landmark points but only care about connetions beteween all camera pose.***

![PoseGraph](https://github.com/WD4715/SlamPortfolio/assets/117700793/eb590e79-1240-4ab6-95b0-376f92f2f1d1)

## 2. Residuals and Jacobians

- The node here represents the camera pose, expressed in ***T<sub>1</sub> T<sub>2</sub>, ..., T<sub>n</sub>***. The edge is the estimation of the relative motion between the two pose nodes. The estimation of the relative motion between two pose nodes. The estimation may come from the feature point method or the direct method, but no matter what, we estimate it, for example, a movement between ***T<sub>i</sub>*** and ***T<sub>j</sub>*** is $\Delta T_{ij}$ .

We can express the movement in SE(3)'s manner

$$
T_{ij}=T_{i}^{-1}T_{j}
$$

-> We can think that the "Inverse" is calcuation to make Identity. ***So the about equation means that Rational Camera Pose Movement between Camera pose i and Camera pose j.***

Using above ***Relative Camera Movement***, we can make ***the error e<sub>ij</sub>***.  

$$
e_{ij}=log{\(T_{ij}^{-1}T_{i}^{-1}T_j\)}^{\vee}
$$

-> ***T<sub>ij</sub><sup>-1</sup>*** is the real Camera pose movement. and ***T<sub>i</sub><sup>-1</sup> T<sub>j</sub>*** is the relative Camera pose movement.

According to the derivation method of Lie algebra, give $\mathcal{\varepsilon_i}$ and $\mathcal{\varepsilon_j}$ a left disturbance $\mathcal{\delta \varepsilon_i}$ and $\delta \mathcal{\varepsilon_j}$ . Then the error becomes:
In other words, The meaning of giving distarance , $\mathcal{\delta \varepsilon_i}$ and $\delta \mathcal{\varepsilon_j}$, is multiplication of " $log(exp(\mathcal{( - \delta \varepsilon_i)^{\wedge}})exp((\delta \mathcal{\varepsilon_j}))^{\wedge})$"

$$
\hat{e_{ij}}=log{\(T_{ij}^{-1}T_{i}^{-1} exp((-\delta \epsilon_{i})^{\wedge}) exp(\delta \epsilon_{j})^{\wedge} T_j\)}^{\vee}
$$

And we will modify this function using "Adjoint Property of Special Euclidean Group(3)" 
Adjoint Property of SE(3) will be the same below:

$$
exp(\epsilon^{\wedge} )T=Texp((Ad(T^{-1}) \epsilon)^{\wedge} )
$$

and We know that Adjoint Matrix of T is like below:

$$
Ad(T)=
\begin{bmatrix} 
	R & t^{\wedge}R \\
	0 & R \\
\end{bmatrix}
$$

So we can modify $e_{ij}$ into $\hat{e}_{ij}$ using ***"left disturbance."***

Let's modify this equation uing ***Talyor Expensing***

$$
\hat{e_{ij}}=log(T_{ij}^{-1} T_i^{-1} exp((- \delta \epsilon)^{\wedge} ) exp(\delta \epsilon)^{\wedge} T_{j})^{\vee}  
$$

$$
=log(T_{ij}^{-1}T_i^{-1}T_{j}exp((-Ad(T_{j}^{-1}) \delta \epsilon)^{\wedge}) exp((Ad(T_{j}^{-1} \delta \epsilon))^{\wedge}))^{\vee} 
$$

$$
\approx log(T_{ij}^{-1}T_{i}^{-1}T_{j}[I - (Ad(T_{j}^{-1}) \delta \epsilon_{i})^{\wedge} + (Ad(T_{j}^{-1}) \delta \epsilon_{j})^{\wedge}])^{\vee}
$$

$$
\approx e_{ij} + {\partial{e_{ij}} \over \partial{\delta \epsilon_{i}}} \delta \epsilon_{i} + {\partial{e_{ij}} \over \partial{\delta \epsilon_{i}}} \delta \epsilon_{j}
$$

where the two Jacobians are:

$$
{\partial{e_{ij}} \over \partial{\delta \epsilon_{i}}} = - \mathcal{J_r^{-1}(e_{ij})Ad(T_{i}^{-1})}
$$

and

$$
{\partial{e_{ij}} \over \partial{\delta \epsilon_{j}}} = - \mathcal{J_r^{-1}(e_{ij})Ad(T_{j}^{-1})}
$$

So Our object is to mimizie the above error. That means that We can estimate the ***Camera pose using Keypoints constraints.***

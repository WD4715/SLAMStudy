# Visual Odometry using ORB

##  1. Feature Method
- VO estimates the rough camera movement based on the consecutive image's information and ***provides a good initial value for the backend.***
- Step is simple like below :

  1. Select some representative features from the images.
  2. Then, based on theses points, we can investigate the problem of camera pose estimation and the 3D points of these points.

### 1. ORB Feature
- ORB is composed of the two : FAST / BRIEF
  FAST : find the corner point in the image
  BRIEF : decrebe the surrounding image area where the feature points were extracted.

  ***Fast***
  step1. Select ***pixel p*** and its bright is ***I<sub>p</sub>***
  step2. Set a Threshold ***T***
  step3. Take the pixel ***p*** as the center, and select the 16 pixels on a circle with a radius of 3.
  step4. IF there are consecutive N points on the selected circle whose brightness is greater than ***I<sub>p</sub> + T*** or less than ***I<sub>p</sub>-T***, the current pixel may potentially be a corner point.

<div align="center">
[Fast step3&step4 Example]
</div>

![Fast](https://github.com/WD4715/SlamPortfolio/assets/117700793/230e2ec4-d26f-402a-a6f8-4ed052a4e782)

***Consideration for Fast***
Because ***Fast*** fixed the radius of the circle as 3, there is also a scaling problem : a place that looks like a corner from a distance may not be a corner when it comes close. To solve those, ***ORB adds the description of scale and rotation***. The scale invariance is achieved by the ***image pyraid*** and detect corner points on each layer. The rotation of features is realized by the ***intensity centroid method***

<div align="center>
  [Fast Scale Invariance : Image Pyraid]
</div>

![Fast_scaleInvariance](https://github.com/WD4715/SlamPortfolio/assets/117700793/ad64cf48-3590-43e5-9158-81b3fc80af30)

<div align="center>
  [Fast Rotation Invariance : Intensity Centroid Method]
</div>
  
In terms of rotation, we calculate ***the gray centroid*** of the image near the feature point. 
step 1. In a small image block B, define ***Moment*** :

$$
\mathcal{m_{pq}} = \Sigma_{x,y \in{B}}(x^{p},y^{q}), p, q= \\{ 0, 1 \\}
$$

step2. Calculate the ***centroid*** of the image block by the moment:

$$
\mathcal{C}=({{m_{10}} \over {m_{00}}}, {{m_{01}} \over {m_{00}}})
$$

step3. Connect the geometric center ***O*** and the centroid ***C*** of the image block to get a direction vector $\vec{OC}$ , so the direction of the feature point can be defined as : 

$$
\theta = \mathcal{arctan} \\{ \mathcal{m_{01}} / \mathcal{m_{10}} \\}
$$


  ***BRIEF***

BRIEF is a binary descriptor. Its description vector consists of many zeros and ones, which encode the size relationship between two random pixels near the key point

### 2. Feature Matching

Assume features ***x<sub>t</sub><sup>m</sup>***, m=1, 2, 3, ..., M are extracted in the image ***I<sub>t</sub>*** and  ***x<sub>t+1</sub><sup>n</sup>***, n=1, 2, 3, ..., N in ***I<sub>t+1</sub>***. The simplest feature matching method is ***the Brute-Force Matcher***, which meatures the distance between each pair of the features ***x<sub>t</sub><sup>m</sup>*** and all ***x<sub>t+1</sub><sup>n</sup>*** descriptors.


##  2. 2D - 2D Epipolar Geometry

This is the relationship bewtween images and Point in the wowrld.

![EipolarGeometry](https://github.com/WD4715/SlamStudy/assets/117700793/76a038c4-0ad8-4720-871c-e20aaa814aa1)

**prerequisites**
  1. epipole : the point which intersects between Two Camera orientation and Two image plane.
  2. epipolar line : The line connecting "projected point(p and p')" with "epipole(e and e')".
  3. epipolar plane : The plane connecting "Two Camera Orientation" and "Point in the world".

We know that :
  1. Essential Matrix is **E**=[t]<sub>x</sub>R
  2. Fundamental Matrix is **F** K<sup>-T</sup>E K<sup>-1</sup>
  
Think about the Essential Matrix's meaning step by step:  
  1. p = KP (K : Camera Calibration Matrix)  
  2. p' = K(RP+t)  
    [definition]
    --> x<sub>1</sub> = K<sup>-1</sup>p  
    --> x<sub>2</sbu> = K<sup>-1</sup>p'  
  3. x<sup>2</sup> 	$\simeq$ Rx<sub>1</sub>+t  
    --> We can multiply left side **t**. Then t[t]<sub>x</sub>=0  
    [t] <sub>x</sub> x<sub>2</sub> $\simeq$ [t]<sub>x</sub>Rx<sub>1</sub>  
    --> We can multiply lef side **x<sub>2</sub><sup>T</sup>**  
    x<sub>2</sub><sup>T</sup> [t] <sub>x</sub> x<sub>2</sub> $\simeq$ x<sub>2</sub><sup>T</sup> [t]<sub>x</sub>Rx<sub>1</sub>  
    We know that [t]<sub>x</sub>x<sub>2</sub> is prependicular to t and x<sub>2</sub>. Thus the left of Equation will be 0.  
    x<sub>2</sub><sup>T</sup> [t]<sub>x</sub>Rx<sub>1</sub> = 0  
    and the middle of this equation([t]<sub>x</sub>R is the Essential Matrix. And we know that x<sub>1</sub> and x<sub>2</sub> is meter unit, not the pixel unit. So We can express this equation as pixel unit.  
    p<sub>2</sub><sup>T</sup>K<sup>-T</sup>[t]<sub>x</sub>RKK<sup>-1</sup><p<sub>1</sub> = 0. And F(Fundamental Matrix) is K<sup>-T</sup>[t]<sub>x</sub>RK<sup>-1</sup>.
    
  4. Singular Value Decomposition
    E = U $\sum_{}$ V<sup>T</sup>.
    and We know the Essential Matrix's property is
    
$$\sum_{}=
\begin{bmatrix}
1&0&0\\
0&1&0\\
0&0&0
\end{bmatrix}$$

  -> So We Can modify this equation into 
  
$$
E = U\sum_{}V^{T} 
= U 
\begin{bmatrix}1&0&0\\ 
0&1&0\\ 
0&0&0 
\end{bmatrix}V^{}
= U 
\begin{bmatrix}0&1&0\\
-1&0&0\\
0&0&0
\end{bmatrix}U^{T} UYV^{T}
$$

Look at this equation. Then We will get the below realtionship.


$$
[t]_{x} =
U 
\begin{bmatrix}0&1&0\\
-1&0&0\\
0&0&0
\end{bmatrix}U^{T}  and R = UYV^{T}
$$

Then the Y will be either 

$$
\begin{bmatrix}0&-1&0\\
1&0&0\\
0&0&1
\end{bmatrix}
or 
\begin{bmatrix}0&-1&0\\
1&0&0\\
0&0&1
\end{bmatrix}^{T}
$$

Thus if we can get the Essential matrix, then we also get the Rotation Matrix and translation from essential matrix.

[tip]
If we use keypoints and descriptors from ORB, then We will get the Essential Matrix.

Because we know the pixel coordinate from the ORB and K(Camera Calibration Matrix). Then if we get the Essential matrix solving by SVD, Then we can get Rotation Matrix and Translation from Keypoint & Descriptors using ORB.

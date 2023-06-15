We have estimated "Camera Position" using ORB(Fast keypoint detector and BRIEF descroptor) -> Essential Matrix -> Rotation matrix & Transition vector.
In other words, we calculated "Camera Pose". Then the next step is to get **the Spatial Position of the FEATURE POINT** using the camera pose.

The first thing to get the spatial position of feature point is **to estimate the depths of the map points**.

--> How to? **"Triangulation"**
Triangulation refers to observing **the same landmark point at different locations** and **determining the distance of the landmark point** from the observed locations.

Let's define x<sub>1</sub> and x<sub>2</sub> be the normalized coordinates of two feature points


$$
s_{2}x_{2}=s_{1}Rx_{1}+t
$$

s<sub>1</sub> and s<sub>2</sub> denote the depth of two feature points. And R is Rotation matrix and t is transition vector.
Let's multiply [x<sub>2</sub>]<sub>x</sub> at the left side. 

Then We can get the following equations:

[x_{2}]_{x}x_{2}=s_{1}[x_{2}]_{x}Rx_{1}+[x_{2}]_{x}t

$$
s_2 [x_2]_{x} x_2 = s_1 [x_2]_x Rx_1 + [x_2]_x t
$$

Look at the above equation. Then we know that the left side of equation will be zero because of the outer product with x<sub>2</sub> itself will be zero.
Then above equation will be below :


$$
0 = s_1 [x_2]_x Rx_1 + [x_2]_x t
$$


--> The right side of can be regarded as an equation of s<sub>1</sub>, and s<sub>1</sub> can be obtained directly from it.
And **Meaning of calculating of the depth of keypoint is the same as the Spatial position of the feature point.**

This is the relationship bewtween images and Point in the wowrld.

![EipolarGeometry](https://github.com/WD4715/SlamStudy/assets/117700793/76a038c4-0ad8-4720-871c-e20aaa814aa1)

**prerequisites**
  1. epipole : the point which intersects between Two Camera orientation and Two image plane.
  2. epipolar line : The line connecting "projected point(p and p')" with "epipole(e and e')".
  3. epipolar plane : The plane connecting "Two Camera Orientation" and "Point in the world".

We know that :
  1. Essential Matrix is **E**=[t]<sub>x</sub>R
  2. Fundamental Matrix is **F**K<sup>-T</sup>E<sup>-1</sup>
  
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
E = U\sum_{}V<sup>T</sup> = U\sum_{}V<sup>T</sup>
$$

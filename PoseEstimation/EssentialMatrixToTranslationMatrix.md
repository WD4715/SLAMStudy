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
    --> x<sub>1</sub> = K<sup>-1</sup>p
    --> x<sub>2</sbu> = K<sup>-1</sup>p'
  3. x<sup>2</sup> 	$$\simeq$$ Rx<sub>1</sub>+t
    --> We can multiply left side **t**. Then t[t]<sub>x</sub>=0
    [t]<sub>x</sbu>x<sub>2</sub> $$\simeq$$
    
  

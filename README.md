A matlab code for 2-dimensional finite elemnt method.

You can run main.m directly

Inp files:
1. NLIST.DAT
2. ELIST.DAT
3. FixNode.dat
4. NodeForce.dat (if have node force)
5. press.dat (if have pressure)

<div align="center">
    <img src="https://github.com/Qinxiaoye/FEM2D/blob/main/figure/ux.png">
</div>
<div align="center">
    <img src="https://github.com/Qinxiaoye/FEM2D/blob/main/figure/uy.png">
</div>
<div align="center">
    <img src="https://github.com/Qinxiaoye/FEM2D/blob/main/figure/mises.png">
</div>

You can generate the inp files by ANSYS or Abaqus.

-------- for inp files------------

If you select Ansys, you can use the *.mac files to generate all the *.dat files automatically.

Provide all ANSYS secondary development files:
1. uget.mac
2. umesp.mac
3. ugetfix.mac
4. ugetforce.mac
5. uexportPress.mac
6. transPress.py (necessary to translate the press.txt)

You need to follow these steps to automatically generate the input file:
1. Establish a FEM model in ansys and apply boundary conditions
2. Place all *.mac files into the current folder
3. Enter: uget,3 in the ANSYS command window
4. Run transPress.py (you need to install python3.5+ in advance)

<div align="center">
    <img src="https://github.com/Qinxiaoye/FEM2D/blob/main/figure/ansys.png">
</div>

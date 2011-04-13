#!/usr/bin/env python
"""
See pcolor_demo2 for a much faster way of generating pcolor plots
"""
from __future__ import division
from matplotlib import cm
import matplotlib.pyplot as plt
import numpy as np

def func3(x,y):
    return (1- x/2 + x**5 + y**3)*np.exp(-x**2-y**2)


# make these smaller to increase the resolution
dx, dy = 0.01, 0.01

x = np.arange(-3.0, 3.0, dx)
y = np.arange(-3.0, 3.0, dy)
X,Y = np.meshgrid(x, y)

Z = func3(X, Y)


ax = plt.subplot(111)
im = plt.imshow(Z, cmap=cm.jet)
im.set_interpolation('bilinear')
plt.colorbar()

plt.savefig("color.pdf")


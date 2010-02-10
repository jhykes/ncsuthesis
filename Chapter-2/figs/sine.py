"""
Plot of sine.

"""
import numpy as np
import matplotlib.pyplot as plt

xx = np.linspace(0., 2*np.pi, 100)

# make a square figure and axes
plt.figure(1, figsize=(8,6))

# x-axis
plt.plot([0,2*np.pi], [0, 0],color='black')

# Sine plots
plt.plot(xx, np.sin(xx), label='$\sin(x)$', color='blue')
plt.plot(xx, np.exp(-xx/3.)*np.sin(xx), label='$e^{-x/3}\sin(x)$', color='green')
plt.xlabel('$x$')
plt.ylabel('$y$')
plt.axis(xmax=2*np.pi)
plt.legend()

plt.savefig("sine.pdf")


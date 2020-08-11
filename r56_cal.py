"""
Created on Wed Nov 27 20:00:55 2019

@author: pascal
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy import special

def b(A1,A2):
    B1 =7.96293
    B2 =0.2795
    n = -1
    m = 31
    return np.abs(special.jn(m,-(m+n)*A2*B2)*special.jn(n,-A1*(n*B1+(m+n)*B2))*np.exp(-0.5*(n*B1+(m+n)*B2)**2))

A1 = np.linspace(1,20,1000)
A2 = np.linspace(1,10,1000)
A1,A2 = np.meshgrid(A1,A2)
b = b(A1,A2)
bn = max(map(max,b))
#fig = plt.figure()
#ax = plt.axes(projection = '3d')
#ax.plot_surface(B1,B2,b)
#ax.set_xlabel('B1')
#ax.set_ylabel('B2')
#ax.set_zlabel('b')
#plt.show()
print(bn)
plt.figure()
plt.contourf(A1,A2,b,8,cmap='jet')
plt.xlabel('$A_{1}$')
plt.ylabel('$A_{2}$')
plt.show()
# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 14:03:50 2020

@author: pascal
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy import special

'''
physics parameters
'''
c = 299792458
alfven = 17045
e0 = 1.602176487e-19

'''
paticle parameters and undulator parameters
'''
E0 = 1600   #unit = MeV
gamma = E0/0.511
sigmaE = 0.3131    #unit = MeV
emitx = 1e-6/gamma      #unit = m
emity = 1e-6/gamma
curpeak = 800      #unit = A
nparticle = 150000
xlamda = 4e-2    #unit = m
K = 2.6122
beta = 6.6713
kw=2*np.pi/xlamda
sigmax = np.sqrt(beta*emitx)
p=gamma**2*kw*sigmax/(1+K**2/2)
JJ = special.j0(K**2/4+2*K**2) - special.j1(K**2/4+2*K**2)
K_JJ = K * JJ
gK=K**2*K_JJ/(1+K**2/2)
'''
csr cal
'''
ec=0.219*curpeak*K**2/alfven/sigmax/gamma**2*np.sqrt((np.log(p)+gK)**2+0.933*(np.log(p)+gK)-0.786)
t=np.linspace(-1e-12,1e-12,10000)
sigmagamma=ec*t*c
plt.plot(t,sigmagamma)
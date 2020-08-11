# -*- coding: utf-8 -*-
"""
Created on Mon Feb 10 11:23:33 2020

@author: pascal
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import special

'''
物理学常数
'''
c = 299792458
alfven = 17045
e0 = 1.602176487e-19
m = 9.10938356e-31

'''
paticle parameters and undulator parameters
'''
E0 = 1650   #unit = MeV
gamma = E0/0.511
sigmaE = 0.1603   #unit = MeV
emitx = 0.6e-6/gamma      #unit = m
emity = 0.6e-6/gamma
curpeak = 1600      #unit = A
nparticle = 2e12
# B = 0.497   #unit = T
xlamda = 4e-2    #unit = m
# K = 0.934*B*xlamda*100

'''
pierce parameter
'''

aw0 = 1.78728
K = np.sqrt(2)*aw0

JJ = special.j0(K**2/4+2*K**2) - special.j1(K**2/4+2*K**2)
K_JJ = K * JJ
xlamdas = xlamda*(1+aw0**2)/(2*gamma**2)    #unit = m
print(aw0)

sigmax = 40e-6
beta = 10
pierce = (curpeak*gamma*(xlamdas)**2*(K_JJ/(1+(K**2)/2))**2/(8*np.pi*alfven*2*np.pi*sigmax**2))**(1/3)
print(pierce)


'''
Xie Model
'''
L1d = xlamda/(4*np.pi*np.sqrt(3)*pierce)
Lr = 4*np.pi*sigmax**2/xlamdas
etad = L1d/Lr
etaemit = L1d*4*np.pi*emitx/(beta*xlamdas)
etagam = 4*np.pi*L1d*sigmaE/(xlamda*E0)

'''
fitting parameters
'''
a1 = 0.45;a2 = 0.57;a3 = 0.55;a4 = 1.6;a5 = 3;a6 = 2;a7 = 0.35;a8 = 2.9;a9 = 2.4
a10 = 51;a11 = 0.95;a12 = 3;a13 = 5.4;a14 = 0.7;a15 = 1.9;a16 = 1140;a17 = 2.2;a18 = 2.9;a19 = 3.2

eta = a1*etad**a2 + a3*etaemit**a4 + a5*etagam**a6 + a7*etaemit**a8*etagam**a9 + \
    a10*etad**a11*etagam**a12 + a13*etad**a14*etaemit**a15 + a16*etad**a17*etaemit**a18*etagam**a19


xie = 1/(1 + eta)
Lg = L1d/xie
pierce3d = xlamda/(4*np.pi*np.sqrt(3)*Lg)
Pbeam = curpeak * E0    # unit = MW
Psat = 1.6*pierce3d/xie**2*Pbeam      #unit = MW
Ps = 6*np.sqrt(np.pi)*pierce**2*Pbeam*1e6/(nparticle*np.sqrt(np.log(nparticle/pierce)))
Ncoh=curpeak*xlamdas/e0/c/pierce
Pin=pierce*Pbeam/Ncoh*1e6
psase=51.0526*np.exp(14.88/L1d)
P0 = pierce**2*gamma*m*c**3/9e-9
print('三维pierce参数为 '+ str(pierce3d))
print('三维增益长度为 '+ str(Lg) + ' m')
print('饱和功率为 '+ str(Psat) + ' MW')
print('噪声功率 '+ str(Ps) + ' W')

# The code calculates the reflection coefficients for unpolarized light at normal and 45-degree incidence
# from a multilayer system with a non-absorbing layer. It uses the transfer matrix method (TMM) to compute the reflection coefficients
# for different wavelengths and plots the results. The reflection coefficients are calculated for a range of wavelengths, and the results are plotted
# as a function of wavenumber (k) in cm-1. 
# The plot shows the fraction of light reflected at normal and 45-degree incidence for the given multilayer system.
# The results show that the reflection coefficient is higher at normal incidence compared to 45-degree incidence, which is expected due to the Fresnel equations.
# The code uses the numpy library for numerical calculations and the matplotlib library for plotting. 
# This example its based on the example from the book "Optical waves in layered media" by Pochi and Pochi Yeh, 1983, Wiley.
# This example is the copy of the examples of the repository https://github.com/sbyrnes321/tmm


# Import necessary libraries
from numpy import inf, linspace, pi
from tmm import coh_tmm, unpolarized_RT
import matplotlib.pyplot as plt

# Define the parameters
degrees = pi /180

# list of layer thicknesses in nm
d_list = [inf, 100, 300, inf]

# list of refractive indices
n_list = [1.0, 2.2, 3.3+0.3j, 1]

# list of wavelengths in nm
ks = linspace(0.0001, .01, num=400)

# initialize list of y-values to plot
Rnorm = []
R45 = []
for k in ks:
    # calculate the reflection coefficients
    Rnorm.append(coh_tmm('s', n_list, d_list, 0, 1/k)['R'])
    R45.append(unpolarized_RT(n_list, d_list, 45*degrees, 1/k)['R'])
    kcm = ks * 1e7 # ks in cm-1 rather than nm-1
    # print the results
plt.figure()
plt.plot(kcm, Rnorm, 'blue', kcm, R45, 'purple')
plt.xlabel('k (cm$^-1')
plt.ylabel('Fraction reflected')
plt.title('from at 0° incidence (blue) and 45° incidence (purple)')
plt.suptitle('Reflection of unpolarized light')
plt.legend(['Normal incidence', '45° incidence'])
plt.grid()
plt.show()
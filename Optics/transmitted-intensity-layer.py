# The code above simulates the transmission of light through a thin film using the transfer matrix method (TMM).
# The code uses the `tmm` library to perform the calculations and `matplotlib` for plotting.
# It calculates the transmitted intensity for a range of wavelengths and plots the results.
# The code uses the refractive index data of a material, interpolates it, and computes the transmission for each wavelength.
# The results are then plotted, showing the fraction of power transmitted as a function of wavelength.
# The code is a good example of how to use the TMM for thin film optics and how to visualize the results using Python.
# This code simulates the transmission of light through a thin film using the transfer matrix method (TMM).
# This example its based on the example from the book "Optical waves in layered media" by Pochi and Pochi Yeh, 1983, Wiley.
# This example is the copy of the examples of the repository https://github.com/sbyrnes321/tmm

# Import necessary libraries
from numpy import array, linspace, inf
from scipy.interpolate import interp1d
from tmm import coh_tmm
import matplotlib.pyplot as plt

material_nk_data = array([[200, 2.1+0.1j],
                         [300, 2.4+0.3j],
                         [400, 2.3+0.4j],
                         [500, 2.2+0.4j],
                         [750, 2.2+0.5j]])
material_nk_fn = interp1d(material_nk_data[:, 0].real,
                          material_nk_data[:, 1], kind='quadratic')
d_list = [inf,300,inf] #in nm
lambda_list = linspace(200, 750, 400) #in nm
T_list = []
for lambda_vac in lambda_list:
    n_list = [1, material_nk_fn(lambda_vac), 1]
    T_list.append(coh_tmm('s', n_list, d_list, 0, lambda_vac)['T'])

plt.figure()
plt.plot(lambda_list, T_list)
plt.xlabel('Wavelength (nm)')
plt.ylabel('Fraction of power transmitted')
plt.title('Transmission at normal incidence')
plt.grid()
plt.show()  

# The code calculates the ellipsometric angles Psi and Delta for a system with air, SiO2, and Si, varying the thickness of the SiO2 layer.
# It uses the TMM (Transfer Matrix Method) to compute the angles based on the refractive indices of the materials and the wavelength of light.
# The results are plotted, showing how Psi and Delta change with the thickness of the SiO2 layer.
# The plot shows that as the thickness of the SiO2 layer increases, both Psi and Delta angles change, indicating the influence of the layer on the ellipsometric measurements.
# The code uses the TMM (Transfer Matrix Method) to compute the ellipsometric angles Psi and Delta for a system with air, SiO2, and Si, varying the thickness of the SiO2 layer.    
# This example its based on the example from the book "Optical waves in layered media" by Pochi and Pochi Yeh, 1983, Wiley.
# This example is the copy of the examples of the repository https://github.com/sbyrnes321/tmm
# Should agree with Handbook of Ellipsometry by Paul H. Holloway, 2009, SPIE Press.


# import necessary libraries 
from tmm import ellips
from numpy import linspace, pi, inf
import matplotlib.pyplot as plt

# define parameters
degree = pi/180

n_list = [1.0, 1.46, 3.87+0.02j]
ds = linspace(0, 1000, num = 100)
psis = []
Deltas = []

for d in ds:
    e_data = ellips(n_list,[inf, d, inf], 70*degree, 633) #in nm
    psis.append(e_data['psi']/degree) #angle in degrees
    Deltas.append(e_data['Delta']/degree) #angle in degrees
plt.figure()
plt.plot(ds, psis, ds, Deltas)
plt.xlabel('SiO2 thickness (nm)')
plt.ylabel('Ellipsometric angles (degrees)')
plt.title('Ellipsometric parameters for air/Si02/Si, varying SiO2 thickness')
plt.legend(['Psi', 'Delta'])
plt.grid()
plt.show()

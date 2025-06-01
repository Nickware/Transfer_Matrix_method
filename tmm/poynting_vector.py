# The code calculates the Poynting vector and local absorption in a multilayer structure using the transfer matrix method (TMM).
# It defines a structure with layers of different refractive indices and thicknesses, and computes the Poynting vector and absorption at various depths within the structure.
# The results are then plotted to visualize the local absorption and Poynting vector as a function of depth in the structure.
# Note: Ensure that the 'tmm' module is correctly implemented and available in your Python environment for this code to run successfully.
# This example its based on the example from the book "Optical waves in layered media" by Pochi and Pochi Yeh, 1983, Wiley.
# This example is the copy of the examples of the repository https://github.com/sbyrnes321/tmm

# Import necessary libraries
from numpy import array, inf, pi, linspace
# Import functions from the tmm module
from tmm import coh_tmm, find_in_structure_with_inf, position_resolved
import matplotlib.pyplot as plt

d_list = [inf, 100, 300, inf] # in nm
n_list = [1, 2.2+0.2j, 3.3+0.3j, 1] 
th_0 = pi/4
lam_vac = 400
pol = 'p'
coh_tmm_data = coh_tmm(pol, n_list, d_list, th_0, lam_vac)

ds = linspace(-50, 400, num=1000)  # position in structure
poyn = []
absor = []
for d in ds:
    layer, d_in_layer = find_in_structure_with_inf(d_list,d)
    data = position_resolved(layer,d_in_layer, coh_tmm_data)
    poyn.append(data['poyn'])
    absor.append(data['absor'])

# convert data to numpy arrays for easy scaling in the plot
poyn = array(poyn)
absor = array(absor)
plt.figure()
plt.plot(ds, poyn, 'blue', ds, 200* absor, 'purple')
plt.xlabel('depth (nm)')
plt.ylabel('AU')
plt.title('Local absorption (purple), Poynting vector (blue)')
plt.legend(['Poynting vector', 'Absorption'])
plt.grid()
plt.show()

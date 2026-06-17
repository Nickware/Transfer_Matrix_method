%url_yaml =urlwrite('https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/yamlmatlab/YAMLMatlab_0.4.3.zip', 'yamlmatlab.zip');
delete("database.zip")
delete("master.zip")
PyTMM = urlwrite('https://github.com/kitchenknif/PyTMM/archive/master.zip','master.zip');
descomprimir_PyTMM = unzip(PyTMM)
delete('master.zip')
database = urlwrite ('https://refractiveindex.info/download/database/rii-database-2017-03-25.zip', 'database.zip');
descomprimir_database = unzip(database);
delete('database.zip')
movefile('database', 'Refractivelndex');
movefile('Refractivelndex','PyTMM-master/PyTMM');
addpath PyTMM-master/PyTMM/
getRefractiveIndex

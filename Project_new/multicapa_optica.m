url_database = urlwrite("http://refractiveindex.info/download/database/rii-database-2016-12-03", "rii-database-2016-12-03.zip");
descomprimir_database = unzip(url_database)
url_yaml =urlwrite('https://github.com/ewiger/yamlmatlab/archive/','master.zip');
descomprimir_yaml = unzip(url_yaml)
cd yamlmatlab
data = ReadYaml('../database/library.xml')
exit 
funcion parametros
lambda=0.1879E-6:1.9370E-6; % la longitud de onda aqui esta dada en 
%micrometros de acuerdo a la tabla de datos, tome ese intervalo porque es el del metal Au, 
%los rangos de los intrvalos para el aire y el bk7 se salen de este, por
%ejemplo el BK7 arranca desde 0.300 micrometros y va hasta 2.500 nanometros
%hay algun problema con eso?

capas={'BK7Lambda,n','AuLambda,n','AuLambda,k','AirLambda,n'}; %nose si deba colocar esas comillas y el ; al final
espesor={'100000','0,04E-6','0,04E-6','100000'}; % el espesor de las capas inicial y final se considera como infinito y el espesor de la capa de Au
%lo tome como 40 nanometros o 0,04micrometros

%aqui coloco las funciones que muestra refractive index 
%Funcion (n) para el vidrio BK7: x=lamnda
%n=sqrt(1+1.03961212./(1-0.00600069867./x.^2)+0.231792344./(1-0.0200179144./x.^2)+1.01046945./(1-103.560653./x.^2))
%Funcion (n) para el aire: x=lambda
%n=1+0.05792105./(238.0185-x.^-2)+0.00167917./(57.362-x.^-2)

funcion constantes
theta=30/360*2*pi;

funcion ObtencionFuncion= CargarDatabase(material,longitud)
[IndRef,IndRef_nombre]=xlsread('multicapa_optica.xls');
archivo_longitud=IndRef(:,strmatch('longitud',IndRef_nombre));
n=IndRef(:,strmatch(( strcat(material,'_n')),IndRef_nombre));
k=IndRef(:,strmatch(( strcat(material,'_k')),IndRef_nombre));
n_interpolacion=interp1(archivo_longitud,n,longitud,'linear','extrap');
k_interpolacion=interp1(archivo_longitud,k,longitud,'linear','extrap');
ObtencionFuncion=n_interpolacion+1i*k_interpolacion

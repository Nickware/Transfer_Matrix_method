close all
clear all
% POLARIZACION TIPO (S) (TE Transversal electrico) (No hay resonancia plasmonica) (El campo electrico es perpendicular al plano de incidencia) 

lambda_0=633E-9;   %longitud de onda (incidente) (1) %% Aqui definimos la longitud de onda fija, en este caso son 633 nanometros 

%Numero de capas e indice (n) de las mismas (Son constantes, ya que lambda es un valor fijo)
n1=1.5151;
n2=0.18344-3.4332i; 
n3=1.0002765; 
n4=1.0002765;
n5=1.0002765;
n6=1.0002765;
n7=1.0002765;
n8=1.0002765;
n9=1.0002765;

%ancho de capaz
d_capa2=41.5E-9;   
d_capa3=7.14E-9;
d_capa4=7.14E-9;
d_capa5=7.14E-9;
d_capa6=7.14E-9;
d_capa7=7.14E-9;
d_capa8=7.14E-9;

% Parametros del angulo  %% el angulo inicial y el final (y el numero de pasos)
theta_inicial=0;
theta_final=90;
thetasteps=1000;



eps1=n1^2; % aqui defino epsilon = n^2
eps2=n2^2;
eps3=n3^2;
eps4=n4^2;
eps5=n5^2;
eps6=n6^2;
eps7=n7^2;
eps8=n8^2;
eps9=n9^2;

k=2*pi/lambda_0; % aqui defino el numero de onda o (como lo dejamos el k subzero) 

theta_inicial=theta_inicial/360*2*pi; % Dejarlo expresado en pi radianes
theta_final=theta_final/360*2*pi;
deltatheta=(theta_final-theta_inicial)/(thetasteps-1); %delta de cada paso

%numeros de onda
for t=1:1:thetasteps
theta=theta_inicial+deltatheta*(t-1); %Pongo a correr theta 

kx=k*n1*sin(theta); % AQUI DEFINO EL VECTOR DE PROPAGACION  en la direccion x 

kz1=sqrt(-(kx^2)+k^2*eps1); %Aqui se empieza a definir el vector de propagacion en cada medio, es decir a lo largo del eje z (KZ1,KZ2,...,KZN)
if imag(kz1)>0,
    kz1=-kz1;
end

kz2=sqrt(-(kx^2)+k^2*eps2);
if imag(kz2)>0,
    kz2=-kz2;
end

kz3=sqrt(-(kx^2)+k^2*eps3);
if imag(kz3)>0,
    kz3=-kz3;
end

kz4=sqrt(-(kx^2)+k^2*eps4);
if imag(kz4)>0,
    kz4=-kz4;
end

kz5=sqrt(-(kx^2)+k^2*eps5);
if imag(kz5)>0,
    kz5=-kz5;
end

kz6=sqrt(-(kx^2)+k^2*eps6);
if imag(kz6)>0,
    kz6=-kz6;
end

kz7=sqrt(-(kx^2)+k^2*eps7);
if imag(kz7)>0,
    kz7=-kz7;
end

kz8=sqrt(-(kx^2)+k^2*eps8);
if imag(kz8)>0,
    kz8=-kz8;
end    

kz9=sqrt(-(kx^2)+k^2*eps9);
if imag(kz9)>0,
    kz9=-kz9;
end  

%(MATRICES DE PROPAGACION)(Lj)

beta_capa2=kz2*d_capa2; % se define el beta de cada matiz de propagacion (el argumento del exponencial)
beta_capa3=kz3*d_capa3;
beta_capa4=kz4*d_capa4;
beta_capa5=kz5*d_capa5;
beta_capa6=kz6*d_capa6;
beta_capa7=kz7*d_capa7;
beta_capa8=kz8*d_capa8;

L_capa2=zeros(2);                   % Aqui empiezo a definir cada matriz de propagacion en cada medio  (es una matriz diagonal) 
L_capa2(1,1)=exp(-1i*beta_capa2);
L_capa2(2,2)=exp(1i*beta_capa2);

L_capa3=zeros(2);
L_capa3(1,1)=exp(-1i*beta_capa3);
L_capa3(2,2)=exp(1i*beta_capa3);

L_capa4=zeros(2);
L_capa4(1,1)=exp(-1i*beta_capa4);
L_capa4(2,2)=exp(1i*beta_capa4);

L_capa5=zeros(2);
L_capa5(1,1)=exp(-1i*beta_capa5);
L_capa5(2,2)=exp(1i*beta_capa5);

L_capa6=zeros(2);
L_capa6(1,1)=exp(-1i*beta_capa6);
L_capa6(2,2)=exp(1i*beta_capa6);

L_capa7=zeros(2);
L_capa7(1,1)=exp(-1i*beta_capa7);
L_capa7(2,2)=exp(1i*beta_capa7);

L_capa8=zeros(2);
L_capa8(1,1)=exp(-1i*beta_capa8);
L_capa8(2,2)=exp(1i*beta_capa8);


% Defino el termino (a); 
%(recuerdese que para el otro tipo de polarizacion es (b) Y eso es lo unico diferente en el programa para una u otra polarizacion polarizaciones)
a1=(kz2/kz1);
a2=(kz3/kz2);
a3=(kz4/kz3);
a4=(kz5/kz4);
a5=(kz6/kz5);
a6=(kz7/kz6);
a7=(kz8/kz7);
a8=(kz9/kz8);

%COEFICIENTES DE TRANSMISION (en muchos textos es (r)) como combinacion del
%termino (a)
rho_capa1_capa2=(1-a1)/(1+a1);
rho_capa2_capa3=(1-a2)/(1+a2);
rho_capa3_capa4=(1-a3)/(1+a3);
rho_capa4_capa5=(1-a4)/(1+a4);
rho_capa5_capa6=(1-a5)/(1+a5);
rho_capa6_capa7=(1-a6)/(1+a6);
rho_capa7_capa8=(1-a7)/(1+a7);
rho_capa8_capa9=(1-a8)/(1+a8);



%COEFICIENTES DE REFLEXION (en muchos textos es (t)) como combinacion del
%termino (a)
tau_capa1_capa2= 2/(1+a1);
tau_capa2_capa3= 2/(1+a2);
tau_capa3_capa4= 2/(1+a3);
tau_capa4_capa5= 2/(1+a4);
tau_capa5_capa6= 2/(1+a5);
tau_capa6_capa7= 2/(1+a6);
tau_capa7_capa8= 2/(1+a7);
tau_capa8_capa9= 2/(1+a8);

%MATRICES DE INTERFASE (Hij)(mejor conocida en muchos textos como matriz dinamica) 
%(aqui empiezo a definir las matrices dinamicas en terminos de los coeficientes de tranmision y reflexion, tau y rho)
H_capa1_capa2=ones(2)/tau_capa1_capa2;
H_capa1_capa2(1,2)=rho_capa1_capa2/tau_capa1_capa2;
H_capa1_capa2(2,1)=rho_capa1_capa2/tau_capa1_capa2;

H_capa2_capa3=ones(2)/tau_capa2_capa3;
H_capa2_capa3(1,2)=rho_capa2_capa3/tau_capa2_capa3;
H_capa2_capa3(2,1)=rho_capa2_capa3/tau_capa2_capa3;

H_capa3_capa4=ones(2)/tau_capa3_capa4;
H_capa3_capa4(1,2)=rho_capa3_capa4/tau_capa3_capa4;
H_capa3_capa4(2,1)=rho_capa3_capa4/tau_capa3_capa4;

H_capa4_capa5=ones(2)/tau_capa4_capa5;
H_capa4_capa5(1,2)=rho_capa4_capa5/tau_capa4_capa5;
H_capa4_capa5(2,1)=rho_capa4_capa5/tau_capa4_capa5;

H_capa5_capa6=ones(2)/tau_capa5_capa6;
H_capa5_capa6(1,2)=rho_capa5_capa6/tau_capa5_capa6;
H_capa5_capa6(2,1)=rho_capa5_capa6/tau_capa5_capa6;

H_capa6_capa7=ones(2)/tau_capa6_capa7;
H_capa6_capa7(1,2)=rho_capa6_capa7/tau_capa6_capa7;
H_capa6_capa7(2,1)=rho_capa6_capa7/tau_capa6_capa7;

H_capa7_capa8=ones(2)/tau_capa7_capa8;
H_capa7_capa8(1,2)=rho_capa7_capa8/tau_capa7_capa8;
H_capa7_capa8(2,1)=rho_capa7_capa8/tau_capa7_capa8;

H_capa8_capa9=ones(2)/tau_capa8_capa9;
H_capa8_capa9(1,2)=rho_capa8_capa9/tau_capa8_capa9;
H_capa8_capa9(2,1)=rho_capa8_capa9/tau_capa8_capa9;


%MATRIZ DE TRANSFERENCIA (S1n )(como el producto de las matrices dinamicas con las matrices de propagacion)
S_capa1_capa9=H_capa1_capa2*L_capa2*H_capa2_capa3*L_capa3*H_capa3_capa4*L_capa4*H_capa4_capa5*L_capa5*H_capa5_capa6*L_capa6*H_capa6_capa7*L_capa7*H_capa7_capa8*L_capa8*H_capa8_capa9;


%(Aqui determino la reflectividad en terminos de los coeficientes de la matriz de transferencia S(1,2) y s(2,2))
R_lista(1,t)=(abs(S_capa1_capa9(1,2)/S_capa1_capa9(2,2)))^2;
angulo(t)=theta/(2*pi)*360; 

end
  
figure; %(Grafico R y theta) 
plot(angulo,R_lista)
 xlabel('Angulo')
 ylabel('Reflectividad')
 title('Reflectividad en función del ángulo de incidencia (tipo s)')


 
 
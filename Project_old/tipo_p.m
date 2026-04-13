close all
clear all
% POLARIZACION TIPO (P) (Tm Transversal Magnetico) (Si hay resonancia plasmonica) (El campo Magnetico es perpendicular al plano de incidencia)
lambda_0=633E-9;   %longitud de onda (incidente) (1) 

%Numero de capas e indice (n) de las mismas
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

% Parametros del angulo 
theta_inicial=0;
theta_final=90;
thetasteps=1000;


% Aqui defino epsilon
eps1=n1^2;
eps2=n2^2;
eps3=n3^2;
eps4=n4^2;
eps5=n5^2;
eps6=n6^2;
eps7=n7^2;
eps8=n8^2;
eps9=n9^2;

k=2*pi/lambda_0; %Defino numero de onda

theta_inicial=theta_inicial/360*2*pi; 
theta_final=theta_final/360*2*pi;
deltatheta=(theta_final-theta_inicial)/(thetasteps-1);

%numeros de onda
for t=1:1:thetasteps
theta=theta_inicial+deltatheta*(t-1);

kx=k*n1*sin(theta);

kz1=sqrt(-(kx^2)+k^2*eps1);
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

%Matrices de propagacion
beta_capa2=kz2*d_capa2; 
beta_capa3=kz3*d_capa3;
beta_capa4=kz4*d_capa4;
beta_capa5=kz5*d_capa5;
beta_capa6=kz6*d_capa6;
beta_capa7=kz7*d_capa7;
beta_capa8=kz8*d_capa8;

L_capa2=zeros(2);
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


b1=(n1/n2)^2*(kz2/kz1);
b2=(n2/n3)^2*(kz3/kz2);
b3=(n3/n4)^2*(kz4/kz3);
b4=(n4/n5)^2*(kz5/kz4);
b5=(n5/n6)^2*(kz6/kz5);
b6=(n6/n7)^2*(kz7/kz6);
b7=(n7/n8)^2*(kz8/kz7);
b8=(n8/n9)^2*(kz9/kz8);

%Coeficientes de transmision
rho_capa1_capa2=(1-b1)/(1+b1);
rho_capa2_capa3=(1-b2)/(1+b2);
rho_capa3_capa4=(1-b3)/(1+b3);
rho_capa4_capa5=(1-b4)/(1+b4);
rho_capa5_capa6=(1-b5)/(1+b5);
rho_capa6_capa7=(1-b6)/(1+b6);
rho_capa7_capa8=(1-b7)/(1+b7);
rho_capa8_capa9=(1-b8)/(1+b8);



%Coeficientes de reflexion 
tau_capa1_capa2=(2*(n1/n2))/(1+b1);
tau_capa2_capa3=(2*(n2/n3))/(1+b2);
tau_capa3_capa4=(2*(n3/n4))/(1+b3);
tau_capa4_capa5=(2*(n4/n5))/(1+b4);
tau_capa5_capa6=(2*(n5/n6))/(1+b5);
tau_capa6_capa7=(2*(n6/n7))/(1+b6);
tau_capa7_capa8=(2*(n7/n8))/(1+b7);
tau_capa8_capa9=(2*(n8/n9))/(1+b8);

%Matrices dinamicas
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

S_capa1_capa9=H_capa1_capa2*L_capa2*H_capa2_capa3*L_capa3*H_capa3_capa4*L_capa4*H_capa4_capa5*L_capa5*H_capa5_capa6*L_capa6*H_capa6_capa7*L_capa7*H_capa7_capa8*L_capa8*H_capa8_capa9;

R_lista(1,t)=(abs(S_capa1_capa9(1,2)/S_capa1_capa9(2,2)))^2;
angulo(t)=theta/(2*pi)*360;

end
  
figure;
plot(angulo,R_lista)
 xlabel('Angulo')
 ylabel('Reflectividad')
 title('Reflectividad en función del ángulo de incidencia, Tipo (p)')

 
 
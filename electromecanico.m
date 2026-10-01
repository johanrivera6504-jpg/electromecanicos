clc;
clear;
close all;

Ra = 2;         
La = 0.023;      
Kt = 0.01;       
Ke = 0.01;       
b  = 0.0012;    
J  = 0.001;      

Va = 5;          

ia0 = 0;         
wm0 = 0;        

x0 = [ia0; wm0];

tspan = [0 5];

[t,x] = ode45(@(t,x) motorDC(t,x,Ra,La,Ke,Kt,b,J,Va), ...
              tspan,x0);

ia = x(:,1);       
wm = x(:,2);       

T = Kt .* ia;

e = Ke .* wm;

figure;

plot(t,wm,'LineWidth',1.5);

grid on;
xlabel('Tiempo [s]');
ylabel('\omega_m [rad/s]');
title('Velocidad angular del motor');

function dxdt = motorDC(t,x,Ra,La,Ke,Kt,b,J,Va)
    ia = x(1);
    wm = x(2);
    dia_dt = (Va - Ra*ia - Ke*wm)/La;
    dwm_dt = (Kt*ia - b*wm)/J;
    dxdt = [dia_dt;
            dwm_dt];
end
%__________________________________________________________
% % 1-Install FAST
% % 2-addpath() your FAST bin folder to MATLAB directories
% % 3-Run Run_closedloop.m for running simulation
% % 4-Open Closedloop.slx to see results
%___________________________________________________________
CertTest_Dir = 'CertTest';

%config parameters--------------------------------------------
TMax = 100; %Simulation time
iTest=11; %Test number
BT=5; %brake time
TT=7; %Transition time

%FAST parameters---------------------------------------------
FileRoot   = sprintf( 'Test%02.0f', iTest );
    
disp('***********************************************');
disp( ['FAST_SFunc certification test for ' FileRoot] );
disp('***********************************************');
    
FAST_InputFileName = [CertTest_Dir filesep FileRoot '.fst'];

%fixed parameters---------------------------------------------    
R=35;
Rho=1.225;
Jr=2.96e6;
Jg=53.036;
Cls=1e5;
Kls=5.6e5;
Cr=625;
Cg=0.05;
ng=87.965;
beta_opt=2;
lambda_opt=7.1;
Cp_opt=0.4857;
a31=Kls-Cls*Cr/Jr;
a32=(Cls*Cg/Jg-Kls)/ng;
a33=-Cls*(Jr+ng^2*Jg)/(ng^2*Jg*Jr);
b31=Cls/Jr;
b32=Cls/ng/Jg;
filename = 'Cp.xlsx';
Cp = xlsread(filename);

%% 
 sim('Closedloop.slx',[0,TMax]);
 sim('Closedloop_old.slx',[0,TMax]);

%% 
figure (1)
hold on
plot(Power,'b','linewidth',1.5)
plot(Power2,'r--','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Power (kW)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('smooth transition','conventional system');

figure(2)
hold on
plot(GenTq,'b','linewidth',1.5)
plot(GenTq2,'r--','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Generator Reference Torque (kN.m)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('smooth transition','conventional system');

figure(3)
hold on
plot(Beta,'b','linewidth',1.5)
plot(Beta2,'r--','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Pitch Angle (deg)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('smooth transition','conventional system');

% figure(4)
% plot(SD,'b','linewidth',1.5)
% set(gca,'fontsize',16);
% title('');
% ylabel('Standard Deviation (rad/s)','fontsize',18,'fontweight','bold');
% xlabel('Time (s)','fontsize',18,'fontweight','bold');

figure(5)
hold on
plot(Omega_r,'b','linewidth',1.5)
plot(Omega_r2,'r--','linewidth',1.5)
plot(Omega_max,'k-.','linewidth',1.5)
set(gca,'fontsize',16);
ylabel('Rotor Angular Speed (RPM)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
title('');
legend('\omega_r smooth transition','\omega_r conventional','\omega_r optimal-allowable ');

figure(6)
plot(Wind,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Wind Speed (m/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

figure (7)
hold on
plot(Power_int,'b','linewidth',1.5)
plot(Power_int2,'r--','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Power Integral(kW.s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('smooth transition','conventional system');
%% 
% scrsz = get(groot,'ScreenSize');
% figure('Position',[scrsz(4)/5 scrsz(4)/8 scrsz(3)/1.39 scrsz(4)/1.36])
% set(groot,'DefaultFigurePosition',[scrsz(4)/5 scrsz(4)/8 scrsz(3)/1.39 scrsz(4)/1.36]);
figure(4)
plot(SD,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Standard Deviation (rad/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

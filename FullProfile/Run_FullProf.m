%__________________________________________________________
% % 1-Install FAST
% % 2-addpath() your FAST bin folder to MATLAB directories
% % 3-Run Run_closedloop.m for running simulation
% % 4-Open Closedloop.slx to see results
%___________________________________________________________
CertTest_Dir = 'CertTest';

%config parameters--------------------------------------------
TMax = 300; %Simulation time
iTest=11; %Test number
BT=20; %brake time
TT=3; %Transition time

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

%% 
figure (1)
hold on
plot(Power,'b','linewidth',1.5)
plot(Power_opt,'k-.','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Power (kW)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('power output','optimal power');

figure(2)
plot(GenTq,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Generator Torque (kN.m)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

figure(3)
plot(REG,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Region Number','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

figure(4)
hold on
plot(Omega_r,'b','linewidth',1.5)
plot(Omega_max,'k-.','linewidth',1.5)
set(gca,'fontsize',16);
ylabel('Rotor Angular Speed (RPM)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');
legend('\omega_r','\omega_r optimal-allowable');

figure(5)
plot(Wind,'b','linewidth',1.5)
set(gca,'fontsize',16);
title('');
ylabel('Wind Speed (m/s)','fontsize',18,'fontweight','bold');
xlabel('Time (s)','fontsize',18,'fontweight','bold');

% figure
% hold on
% subplot(3,1,1);
% plot(t,HGt(:,1),'b--','linewidth',2)
% legend('i')
% subplot(3,1,2);
% plot(t,HGt(:,2),'r-','linewidth',2)
% ylabel('Angular Momentums (kg.m^2/s)','fontsize',25,'fontweight','bold');
% xlabel('Time (s)','fontsize',25,'fontweight','bold');
% legend('j')
% subplot(3,1,3);
% plot(t,HGt(:,3),'g-.','linewidth',2)
% set(gca,'fontsize',18,'fontweight','bold');
% legend('k')
%% plot size
% 
% scrsz = get(groot,'ScreenSize');
% figure('Position',[scrsz(4)/4 scrsz(4)/6 scrsz(3)/1.74 scrsz(4)/1.71])
% set(groot,'DefaultFigurePosition',[scrsz(4)/4 scrsz(4)/6 scrsz(3)/1.74 scrsz(4)/1.71]);
% Copyright 2016, All Rights Reserved
% Code by Steven L. Brunton
clear all, close all, clc

FIG01_LORENZ_GEN
% load('./DATA/FIG01_LORENZ.mat');
ModelName = 'Lorenz';

figure;
L1 = 100:300;
L2 = 301:600;
L3 = 601:900;
L4 = 901:2136;
v1 = 1;
v2 = 2;
v3 = 3;
hold on
plot3(V(L1,v1),V(L1,v2),V(L1,v3),'Color',[0.5 0.5 1],'LineWidth',1)
plot3(V(L2,v1),V(L2,v2),V(L2,v3),'Color',[0.7 0.5 0.1],'LineWidth',1)
plot3(V(L3,v1),V(L3,v2),V(L3,v3),'Color',[0.9 0.3 0.5],'LineWidth',1)
plot3(V(L4,v1),V(L4,v2),V(L4,v3),'Color',[1 0 0],'LineWidth',1)
%plot(V(L1,v1),V(L1,v2));
%axis tight
%xlabel('v_1'), ylabel('v_2'), zlabel('v_3')
%zlim([-10*10^-3   10*10^-3])
title('Embedded')
xlabel('v_1'), ylabel('v_2')
set(gca,'FontSize',12)
view(34,22)
set(gcf,'Position',[100 100 600 400])
set(gcf,'PaperPositionMode','auto')
% print('-depsc2', '-loose', [figpath,ModelName,'_p3_axis.eps']);
%%

%%  Part 5:  Reconstructed Attractor
figure;
L1 = 100:300;
L2 = 301:600;
L3 = 601:900;
L4 = 901:1000;
hold on
plot3(y(L1,1),y(L1,2),y(L1,3),'Color',[0 0 1],'LineWidth',1)
plot3(y(L2,1),y(L2,2),y(L2,3),'Color',[0.5 1 1],'LineWidth',1)
plot3(y(L3,1),y(L3,2),y(L3,3),'Color',[0.5 1 0.5],'LineWidth',1)
plot3(y(L4,1),y(L4,2),y(L4,3),'Color',[1 0 0],'LineWidth',1)
%plot(y(L,1),y(L,2))
axis tight
xlabel('v_1'), ylabel('v_2'), zlabel('v_3')
%ylim([-100   100])
title('2pi Reconstructed r=4')
%xlabel('v_1'), ylabel('v_2')
set(gca,'FontSize',12)
view(30,29)
set(gcf,'Position',[100 100 600 400])
set(gcf,'PaperPositionMode','auto')
% print('-depsc2', '-loose', [figpath,ModelName,'_p5_axis.eps']);
%%


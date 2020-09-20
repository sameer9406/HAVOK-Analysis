% Copyright 2016, All Rights Reserved
% Code by Steven L. Brunton
clear all, close all, clc
figpath = './figures/';
addpath('./utils');


% Integrate
dt = 0.001;
t = (dt:dt:100);
n = 2;
xdat_x = sin(n*pi*t); % Equation for sine wave modeling
xdat = xdat_x';

stackmax = 200;  % the number of shift-stacked rows
lambda = 0;   % threshold for sparse regression (use 0.02 to kill terms)
rmax = 4;       % maximum singular vectors to include

%% EIGEN-TIME DELAY COORDINATES
clear V, clear dV, clear H
H = zeros(stackmax,size(xdat,1)-stackmax);

for k=1:stackmax
    H(k,:) = xdat(k:end-stackmax-1+k,1);  
end
[U,S,V] = svd(H,'econ');
sigs = diag(S);
beta = size(H,1)/size(H,2);
thresh = optimal_SVHT_coef(beta,0) * median(sigs);
r = length(sigs(sigs>thresh));
r=min(rmax,r);

%% COMPUTE DERIVATIVES
% compute derivative using fourth order central difference
% use TVRegDiff if more error 
dV = zeros(length(V)-5,r);
for i=3:length(V)-3
    for k=1:r
        dV(i-2,k) = (1/(12*dt))*(-V(i+2,k)+
			8*V(i+1,k)-8*V(i-1,k)+V(i-2,k));
    end
end  
% concatenate

x = V(3:end-3,1:r);
dx = dV;

%%  BUILD HAVOK REGRESSION MODEL ON TIME DELAY COORDINATES
% This implementation uses the SINDY code, but least-squares works too
% Build library of nonlinear time series
polyorder = 2;
Theta = poolData(x,r,polyorder,0);
%normalize columns of Theta (required in new time-delay coords)
for k=1:size(Theta,2)
    normTheta(k) = norm(Theta(:,k));
    Theta(:,k) = Theta(:,k)/normTheta(k);
end 
m = size(Theta,2);
% compute Sparse regression: sequential least squares
% requires different lambda parameters for each column
clear Xi
for k=1:r-1
    Xi(:,k) = sparsifyDynamics(Theta,dx(:,k),lambda*k,1);  % lambda = 0 gives better results 
end
Theta = poolData(x,r,2,0);
for k=1:length(Xi)
    Xi(k,:) = Xi(k,:)/normTheta(k);
end
A = Xi(2:r+1,1:r-1)';
B = A(:,r);
A = A(:,1:r-1);
%
L = 1:2136;
sys = ss(A,0*B,eye(r-1),0*B);
[y,t] = lsim(sys,x(L,r),dt*(L-1),x(1,1:r-1));

%% SAVE DATA (OPTIONAL)
% save ./DATA/FIG01_LORENZ.mat

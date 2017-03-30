%main_Hindmarsh_Rose.m
clear;  clc;  close all;

%initial condition
P0 = [0.1 0.1 0.1];
%set parameters
a = 1.0;
b = 3.045;
c = 1.0;
d = 5.0;
I = -3.4*b +13.24;
r = 0.01;
s = 4.0;
x0 = -1.6;
parameters = [a b c d I r s x0];
%time parameters
dt = 5*10^(-3);
T = 10^(7);
tail = 5*10^(5);
%options
plotxyz = 0;
%run functions
[x,y,z] = Hindmarsh_Rose(r0,parameters,dt,T,tail,plotxyz);
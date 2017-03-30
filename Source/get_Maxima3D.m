%get_Maxima3D.m
function [xmax,ymax,zmax] = get_Maxima3D(x,y,z)
%get "derivative"
dx = diff(x);
%find sign change beween successive values
xmax = x(find(dx(1:length(dx)-1)>0 & dx(2:length(dx))<0));
%get "derivative"
dy = diff(y);
%find sign change beween successive values
ymax = y(find(dy(1:length(dy)-1)>0 & dy(2:length(dy))<0));
%get "derivative"
dz = diff(z);
%find sign change beween successive values
zmax = z(find(dz(1:length(dz)-1)>0 & dz(2:length(dz))<0));
end
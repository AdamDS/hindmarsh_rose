function [x,y,z] = Hindmarsh_Rose(r0,parameters,dt,T,tail,plotxyz)
%output for RK4
x = zeros(T,1); 
y = zeros(T,1);
z = zeros(T,1);
%parameter
a = parameters(1);
b = parameters(2);%2.6:0.001:3.1;  %2.6:0.001:3.1    %3.0
c = parameters(3);
d = parameters(4);
I = parameters(5);%2:(3/500):5;    %-3.4*b+13.24     %3.0
r = parameters(6);           %                 %0.006
s = parameters(7);
x0 = parameters(8);          %                 %-1.56
%initial conditions
x_old = r0(1);  u_old = 0;
y_old = r0(2);  v_old = 0;
z_old = r0(3);  w_old = 0;
  %4th order Runge Kutta Method
for j=1:T
  %save RK4 output
  x(j) = x_old; %u(j) = u_old;
  y(j) = y_old; %v(j) = v_old;
  z(j) = z_old; %w(j) = w_old;
  %determine weights
  X = x_old;  U = u_old;
  Y = y_old;  V = v_old;
  Z = z_old;  W = w_old;
    F1 = Y -a*X^3 +b*X^2 +I -Z;
    G1 = c -d*X^2 -Y;
    H1 = r*(s*(X-x0) -Z);
  X = x_old + F1*dt/2;  U = u_old + F1*dt/2;
  Y = y_old + G1*dt/2;  V = v_old + G1*dt/2;
  Z = z_old + H1*dt/2;  W = w_old + H1*dt/2;
    F2 = Y -a*X^3 +b*X^2 +I -Z;
    G2 = c -d*X^2 -Y;
    H2 = r*(s*(X-x0) -Z);
  X = x_old + F2*dt/2;  U = u_old + F2*dt/2;
  Y = y_old + G2*dt/2;  V = v_old + G2*dt/2;
  Z = z_old + H2*dt/2;  W = w_old + H2*dt/2;
    F3 = Y -a*X^3 +b*X^2 +I -Z;
    G3 = c -d*X^2 -Y;
    H3 = r*(s*(X-x0) -Z);
  X = x_old + F3*dt;  U = u_old + F3*dt;
  Y = y_old + G3*dt;  V = v_old + G3*dt;
  Z = z_old + H3*dt;  W = w_old + H3*dt;
    F4 = Y -a*X^3 +b*X^2 +I -Z;
    G4 = c -d*X^2 -Y;
    H4 = r*(s*(X-x0) -Z);
  %advance x,y,z
  x_new = x_old + dt*(F1+2*(F2+F3)+F4)/6;
  y_new = y_old + dt*(G1+2*(G2+G3)+G4)/6;
  z_new = z_old + dt*(H1+2*(H2+H3)+H4)/6;
  %advance u,v,w
  u_new = u_old + dt*(F1+2*(F2+F3)+F4)/6;
  v_new = v_old + dt*(G1+2*(G2+G3)+G4)/6;
  w_new = w_old + dt*(H1+2*(H2+H3)+H4)/6;
  %update x,y,z and u,v,w
  x_old = x_new;  u_old = u_new;
  y_old = y_new;  v_old = v_new;
  z_old = z_new;  w_old = w_new;
end
if plotxyz==1
  figure(ceil(rand(1)*10000));
  plot3(x(T-tail:T),y(T-tail:T),z(T-tail:T),'LineWidth',2);
  xlabel('x','FontName','Arial','FontSize',14);  
  ylabel('y','FontName','Arial','FontSize',14);  
  zlabel('z','FontName','Arial','FontSize',14);
  set(gca,'FontName','Arial','FontSize',14);
end
end
%get_Lyapunov_Exponent.m
function [lambda, P0x, P0y, P0z] = get_Lyapunov_Exponent(P0,...
  delta0,parameters,dt,T,threshold,plottime,l)
%initialize
lambda = 27183; tail = 0; plotxyz = 0;
%get time series of x y and z
[x1,y1,z1] = Hindmarsh_Rose(P0,parameters,dt,T,tail,plotxyz);
%save final values in case needing to scan through parameter space later
P0x = x1(length(x1));
P0y = y1(length(y1));
P0z = z1(length(z1));
%save time series if opted for
if l~=0
  r1 = [x1 y1 z1];
  save(['time_series_r1_' int2str(l)],'r1');
end
clear P1;
%get slightly different trajectory time series
[x2,y2,z2] = Hindmarsh_Rose(P0+delta0,parameters,dt,T,tail,plotxyz);
%save time series if opted for
if l~=0
  r2 = [x2 y2 z2];
  save(['time_series_r2_' int2str(l)],'r2');
end
clear P2;
%get squared distance
delta = ((x1-x2).^2 +(y1-y2).^2 +(z1-z2).^2);
%clear times series in case memory is fragile
clear x1 y1 z1 x2 y2 z2;
%get plotting values of distance
delta = log10(sqrt(delta));

%find when delta reaches magnitude of attractor
i_leveled_out = find(delta>threshold);
if length(i_leveled_out)==0
  i_leveled_out = length(delta);
end
%determine sufficient time after transience
ten_percent_of_time = floor(0.1*i_leveled_out(1));
y_bot = mean(delta(1:(1+ten_percent_of_time)));
x_bot = mean(1:(1+ten_percent_of_time));
%get approximated value for maximum distance to consider
y_top = mean((delta((i_leveled_out(1)-ten_percent_of_time):(i_leveled_out(1)))));
x_top = mean((i_leveled_out(1)-ten_percent_of_time):(i_leveled_out(1)));
%calculate slope/ Lyapunov exponent
lambda = (y_top-y_bot)/(dt*(x_top-x_bot));
%plot divergence time series if opted for
if plottime==1
  figure(27183);
  plot(dt*(1:(1/dt):T),delta(1:(1/dt):T));  hold on;  
  plot(dt*[x_bot x_top],[y_bot y_top],'k');
  xlabel('time'); ylabel('log10(||\delta||)');
end
end
function [crossings] = Poincare_Section(x,y,z,level)
%initialize
cross = 1;
crossings = [0 0];
if level(1)==0 %not x slice
  if level(2)==0 %not y slice
    %z slice
    cross = find(z(1:(length(z)-1))>level(3) & z(2:length(z))<level(3));
    crossings = [x(cross) y(cross)];
  else
    %y slice
    cross = find(y(1:(length(y)-1))>level(2) & y(2:length(y))<level(2));
    crossings = [x(cross) z(cross)];
  end
else
  %x slice
  cross = find(x(1:(length(x)-1))>level(1) & x(2:length(x))<level(1));
  crossings = [y(cross) z(cross)];
end

end
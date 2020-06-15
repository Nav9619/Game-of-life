function [spheres] = seedInitial(ns, vs, rs, BC)
% function to seed initial conditions of control volume 
% ns is number of spheres, vs is velocity of spheres(1 value for uniform velocity 
% or (ns x 1) array), rs is sphere radius (same as velocity- either 1 value for 
% uniform or (ns x 1) array) and BC is a (4x1) boundary conditions array


% error check function inputs
if ns < 0
  error('Number of spheres needs to be a positive integer');
elseif (length(vs) ~= 1 && length(vs) ~= ns)
  error('vs needs to be a 1x1 or ns x 1 array');
elseif (length(rs) ~= 1 && length(rs) ~= ns)
  error('rs needs to be a 1x1 or ns x 1 array');
elseif length(BC) ~= 4
  error('BC needs to be a 4x1 array');
end

% create spheres array and fill with zeros (ensures faster code runtime by avoiding 
% dynamic resizing 
 spheres = zeros(ns, 5);
 
% if radius is a uniform constant, form a vector with ns elements filled with that value
 if size(rs) == 1
   temp_rs = rs;
   rs = ones(ns,1)*temp_rs;
 end
 
 if size(vs) == 1
   temp_vs = vs;
   vs = ones(ns,1)*temp_vs;
 end
 
 
 %create random starting positions for the spheres (x & y coords here are that 
 %sphere center)
 xRand = rand(ns, 1);
 yRand = rand(ns, 1);
 boundaryWidth = BC(2)-BC(1);
 boundaryHeight = BC(4)-BC(3);
 x_pos = (xRand * boundaryWidth) + BC(1);
 y_pos = (yRand * boundaryHeight) + BC(3);
 
 for m = 1:ns
   if (2*rs(m) > boundaryHeight)||(2*rs(m) > boundaryWidth)
     error('sphere radius cannot exceed the allowed space in the control volume');
   end
 end
 
 
 seedCorrect = false; % boolean variable
 %error check for sphere position initialization & re-initialize if necessary
 for k = 1:ns
   while (seedCorrect == false)
    if (x_pos(k) + rs(k) > BC(2))    % x position exceeds right boundary
      seedCorrect = false;
      x_pos(k) = (rand * boundaryWidth) + BC(1);  
    elseif (x_pos(k) - rs(k) < BC(1))   % x position exceeds left boundary
      seedCorrect = false;
      x_pos(k) = (rand * boundaryWidth) + BC(1);
    elseif (y_pos(k) + rs(k) > BC(4))   % y position exceeds upper boundary
      seedCorrect = false;
      y_pos(k) = (rand * boundaryHeight) + BC(3);
    elseif (y_pos(k) - rs(k) < BC(3))   % y position exceeds lower boundary
      seedCorrect = false;
      y_pos(k) = (rand * boundaryHeight) + BC(3);
    else
      seedCorrect = true;
    end
  end
  
  % generated sphere cannot intersect exisiting sphere
  for j = 1:k-1
    if sqrt(((x_pos(k)-x_pos(j))^2) + ((y_pos(k)-y_pos(j))^2)) < (rs(k)+rs(j))
      x_pos(k) = (rand * boundaryWidth) + BC(1);
      y_pos(k) = (rand * boundaryHeight) + BC(3);
    end
  end    
    
 end

x_vel = zeros(ns,1);
y_vel = zeros(ns,1);
 
% velocity calculations
theta = rand(ns, 1) * 2*pi;    % random angle calculations
for n = 1:ns
  x_vel(n) = vs(n)*cos(theta(n));    % x-component of velocity
  y_vel(n) = vs(n)*sin(theta(n));    % y-component of velocity
end

   
% assign  values to spheres array
 for i = 1:ns
   spheres(i,1) = rs(i);        % radius column
   spheres(i,2) = x_pos(i);     % x-coord column
   spheres(i,3) = y_pos(i);     % y-coord column
   spheres(i,4) = x_vel(i);     % x-velocity column
   spheres(i,5) = y_vel(i);     % y-velocity column
 end
 
end

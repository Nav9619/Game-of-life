function [spheres] = fieldEvolution(spheres,dt,ns,density,boundaryWidth,boundaryHeight,absRatio,f,f2,f3)
  % calculates iterative timestep motion inside control volume
  
  s = size(spheres);
  length = s(1);
  % Update new x and y positions of spheres
  for k = 1:length
    spheres(k,2) = spheres(k,2) + dt*spheres(k,4);
    spheres(k,3) = spheres(k,3) + dt*spheres(k,5);
  end
 
 % function handle - detectCollision
  collisions = f(spheres,ns,boundaryWidth,boundaryHeight);
  % Collision type - function handles used for elastic and absorption
  w = size(collisions);
  ww = w(1);
  if ww > 0
    for m = 1:ww
        probability = rand;
        if probability <= absRatio   % absorption
            spheres = f2(spheres,collisions(m,1),collisions(m,2),density);
        % if intersection do absorption again till new sphere does not intersect others
        else      % elastic collision
            spheres = f3(spheres,collisions(m,1),collisions(m,2),density);
        end
    end
  else
      
  end
  
  s2 = size(spheres);
  length2 = s2(1);
  
  % Boundary collision
  for j = 1:length2
    x_max = spheres(j,2) + spheres(j,1);
    x_min = spheres(j,2) - spheres(j,1);
    y_max = spheres(j,3) + spheres(j,1);
    y_min = spheres(j,3) - spheres(j,1);
    
    if (x_min <= 0 && spheres(j,4) < 0)
      spheres(j,4) = - spheres(j,4);
    elseif (x_max >= boundaryWidth && spheres(j,4) > 0)
      spheres(j,4) = -spheres(j,4);
    end
    
    if (y_min <= 0 && spheres(j,5) < 0)
      spheres(j,5) = -spheres(j,5);
    elseif (y_max >= boundaryHeight && spheres(j,5) > 0)
      spheres(j,5) = -spheres(j,5);
    end
  end
  
  
end

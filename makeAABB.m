function [AABBarray] = makeAABB(spheres)
  % function that creates and AABB array, where every 4 rows represents each sphere
  % Each of the 4 rows for a sphere will represent the coordinates for the 
  % respective corner of the AABB
  
  % initialize the array with 3 columns (sphere number and x,y coords)
  s = size(spheres);
  ss = s(1);
  AABBarray = zeros((ss*4),3);
  i = 0; % index
  
  for k = 1:ss
    % Top left corner of AABB
    i = i + 1;
    AABBarray(i,1) = spheres(k,2) - spheres(k,1);
    AABBarray(i,2) = spheres(k,3) + spheres(k,1);
    AABBarray(i,3) = k;
    
    % Bottom left corner 
    i = i + 1;
    AABBarray(i,1) = spheres(k,2) - spheres(k,1);
    AABBarray(i,2) = spheres(k,3) - spheres(k,1);
    AABBarray(i,3) = k;
    
    % Top right corner
    i = i + 1;
    AABBarray(i,1) = spheres(k,2) + spheres(k,1);
    AABBarray(i,2) = spheres(k,3) + spheres(k,1);
    AABBarray(i,3) = k;
    
    % Bottom right corner
    i = i + 1;
    AABBarray(i,1) = spheres(k,2) + spheres(k,1);
    AABBarray(i,2) = spheres(k,3) - spheres(k,1);
    AABBarray(i,3) = k;
    
    
  end
end

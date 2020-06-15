function dtprime = timeCheck(collisions, spheres)
  % function that returns the time the first collision happens 
  
  collLength = length(collisions(:,1));
  for k = 1:collLength
    % positions and velocities of particles 
    Ax = collisions(k,3);
    Ay = collisions(k,4);
    Arad = spheres((collisions(k,1)),1);
    vAx = spheres((collisions(k,1)),4);
    vAy = spheres((collisions(k,1)),5);
    
    Bx = collisions(k,5);
    By = collisions(k,6);
    Brad = spheres((collisions(k,2)),1);
    vBx = spheres((collisions(k,2)),4);
    vBy = spheres((collisions(k,2)),5); 
    
    tA =   ((Arad^2*vAx^2 - 2*Arad^2*vAx*vBx + Arad^2*vBx^2 + Arad^2*vAy^2 - 2*Arad^2*vAy*vBy + Arad^2*vBy^2 + 2*Arad*Brad*vAx^2 - 4*Arad*Brad*vAx*vBx + 2*Arad*Brad*vBx^2 + 2*Arad*Brad*vAy^2 - 4*Arad*Brad*vAy*vBy + 2*Arad*Brad*vBy^2 + Brad^2*vAx^2 - 2*Brad^2*vAx*vBx + Brad^2*vBx^2 + Brad^2*vAy^2 - 2*Brad^2*vAy*vBy + Brad^2*vBy^2 - vAx^2*Ay^2 + 2*vAx^2*Ay*By - vAx^2*By^2 + 2*vAx*vBx*Ay^2 - 4*vAx*vBx*Ay*By + 2*vAx*vBx*By^2 + 2*vAx*vAy*Ax*Ay - 2*vAx*vAy*Ax*By - 2*vAx*vAy*Bx*Ay + 2*vAx*vAy*Bx*By - 2*vAx*vBy*Ax*Ay + 2*vAx*vBy*Ax*By + 2*vAx*vBy*Bx*Ay - 2*vAx*vBy*Bx*By - vBx^2*Ay^2 + 2*vBx^2*Ay*By - vBx^2*By^2 - 2*vBx*vAy*Ax*Ay + 2*vBx*vAy*Ax*By + 2*vBx*vAy*Bx*Ay - 2*vBx*vAy*Bx*By + 2*vBx*vBy*Ax*Ay - 2*vBx*vBy*Ax*By - 2*vBx*vBy*Bx*Ay + 2*vBx*vBy*Bx*By - vAy^2*Ax^2 + 2*vAy^2*Ax*Bx - vAy^2*Bx^2 + 2*vAy*vBy*Ax^2 - 4*vAy*vBy*Ax*Bx + 2*vAy*vBy*Bx^2 - vBy^2*Ax^2 + 2*vBy^2*Ax*Bx - vBy^2*Bx^2)^(1/2) + vAx*Ax - vAx*Bx - vBx*Ax + vBx*Bx + vAy*Ay - vAy*By - vBy*Ay + vBy*By)/(vAx^2 - 2*vAx*vBx + vBx^2 + vAy^2 - 2*vAy*vBy + vBy^2);
    
   dtprime = abs(tA);
   
  end
end

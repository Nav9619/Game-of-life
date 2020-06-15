function [spheres] = elasticCollision(spheres, A, B, density)
  % function where elastic collision is simulated.A and B refer to the spheres colliding.
  % A or B represent the wall if either of them are 0. final velocities are solved
  % for and stored back in the spheres matrix.
  
  % check if it is a wall collision
  if (A == 0 || B == 0)
    % wallCollision = true;
    if B == 0   % sphere A collides with wall
      angleA_bfr = atan2((spheres(A,5)),(spheres(A,4)));     % angle of collision
      angleA_aft = - angleA_bfr;
      uA = sqrt((spheres(A,4)^2)+(spheres(A,5)^2));     % initial speed of A
      spheres(A,4) = uA*cos(angleA_aft);                % new vel in x-dir
      spheres(A,5) = uA*sin(angleA_aft);                % new vel in y-dir
    elseif A == 0   % sphere B collides with wall
      angleB_bfr = atan2((spheres(B,5)),(spheres(B,4)));     
      angleB_aft = - angleB_bfr;
      uB = sqrt((spheres(B,4)^2)+(spheres(B,5)^2));     
      spheres(B,4) = uB*cos(angleB_aft);
      spheres(B,5) = uB*sin(angleB_aft);
    end      
  
    % two spheres colliding  
  else
    % first calculate masses of each sphere - density * volume
    mA = density * (4/3)*pi*(spheres(A,1))^3;
    mB = density * (4/3)*pi*(spheres(B,1))^3;
  
    % calculation of velocity magnitudes (speed)
    uA = sqrt((spheres(A,4)^2)+(spheres(A,5)^2));
    uB = sqrt((spheres(B,4)^2)+(spheres(B,5)^2));
    
    % angle of contact
    alpha = atan2((spheres(A,3)-spheres(B,3)),(spheres(A,4)-spheres(B,4)));
    % angles of motion for A & B
    thetaA = atan2((spheres(A,5)),(spheres(A,4)));
    thetaB = atan2((spheres(B,5)),(spheres(B,4)));
    
    % final velocity calculations for A
    vAxprime = ((mA-mB)*uA*cos(thetaA-alpha) + 2*mB*uB*cos(thetaB-alpha))/(mA+mB);
    vAx = (vAxprime*cos(alpha))+(uA*sin(thetaA-alpha)*sin(alpha));
    vAy = (vAxprime*sin(alpha)) + (uA*sin(thetaA-alpha)*cos(alpha));
    
    % final velocity calculations for B
    vBxprime = ((mB-mA)*uB*cos(thetaB-alpha) + 2*mB*uA*cos(thetaA-alpha))/(mB+mA);
    vBx = (vBxprime*cos(alpha))+(uB*sin(thetaB-alpha)*sin(alpha));
    vBy = (vBxprime*sin(alpha))+(uB*sin(thetaB-alpha)*cos(alpha));
   
   spheres(A,4) = vAx;
   spheres(A,5) = vAy;
   spheres(B,4) = vBx;
   spheres(B,5) = vBy;
 end

end

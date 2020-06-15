function [vAx,vBx,vAy,vBy] = revertVelocity(spheres,A_ref,B_ref)
  % function to revert velocity to time of first collision. inputs A_ref and B_ref are 
  % the reference numbers of the 2 colliding particles. The outputs are the final 
  % velocities in x and y direction of both particles
  
  %position, velocity & mass of A
  Ax = spheres(A_ref,2);
  Ay = spheres(A_ref,3);
  uAx = spheres(A_ref,4);
  uAy = spheres(A_ref,5);
  
  %position and velocity & mass of B
  Bx = spheres(B_ref,2);
  By = spheres(B_ref,3);
  uBx = spheres(B_ref,4);
  uBy = spheres(B_ref,5);

  
  % angle of rotation between xy and x'y' frames
  theta = atan2((Bx-Ax),(Ay-By));
  
  % data from before collision occurs
  uAxprime = uAx*cos(theta) + uAy*sin(theta);
  uAyprime = uAy*cos(theta) - uAx*sin(theta);
  uBxprime = uBx*cos(theta) + uBy*sin(theta);
  uByprime = uBy*cos(theta) - uBy*sin(theta);
  
  % After collision has occured, x' velocities do not change but y' swap
  vAxprime = uAxprime;
  vBxprime = uBxprime;
  vAyprime = uByprime;
  vByprime = uAyprime;

  % rotate back to xy plane
  vAx = (vAxprime*cos(theta)) - (vAyprime*sin(theta));
  vAy = (vAyprime*cos(theta)) + (vAxprime*sin(theta));
  vBx = (vBxprime*cos(theta)) - (vByprime*sin(theta));
  vBy = (vByprime*cos(theta)) + (vBxprime*sin(theta));
  
end

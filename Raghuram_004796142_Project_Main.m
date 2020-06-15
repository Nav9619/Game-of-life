clear all;
clc;

rng('shuffle')

vel = [ 0.00; 1.00; 0.50; 0.50; 0.25; 0.25; 0.30; 0.30; 0.30; 0.00];
rad = [ 1.00; 1.25; 1.50; 1.75; 2.00; 1.00; 1.15; 1.35; 1.65; 1.85];


ns = 10;    % number of spheres
vs = vel;   % velocity of spheres
rs = rad;  % radius of spheres
BC = [0; 25; 0; 25];    % Boundary conditions
density = 0.05; 
absRatio = 0.1;   % absorption ratio (probability of absorption occuring)
dt = 0.1;   % timestep
tf = 100;   % total time
t0 = 0;     % initial time
t = t0;    % current time
boundaryWidth = BC(2) - BC(1);
boundaryHeight = BC(4) - BC(3);

% Seed the spheres initially
[spheres] = seedInitial(ns,vs,rs,BC);

% Initialize Video
v = VideoWriter('CollisionVideo','MPEG-4');
v.FrameRate = 60;
open(v);

% Begin time-stepping
while t < tf
  spheres = fieldEvolution(spheres,dt,ns,density,boundaryWidth,boundaryHeight,absRatio,@detectCollision,@absorption,@elasticCollision);
  %increment time
  t = t + dt;
  % Collision check
  collisions = detectCollision(spheres,ns,boundaryWidth,boundaryHeight);
  if ~isempty(collisions)
   % Revert time to first collision
    dtprime = timeCheck(collisions,spheres);
   % Revert positions to first collision
    spheres = fieldEvolution(spheres,-dtprime,ns,density, boundaryWidth,boundaryHeight,absRatio,@detectCollision,@absorption,@elasticCollision);
    % Revert velocities to first collision
    q = size(collisions);
    qq = q(1);
    for k = 1:qq
      index1 = collisions(qq,1);   % sphere A ref number
      index2 = collisions(qq,2);   % sphere B ref number
      [vAx,vBx,vAy,vBy] = revertVelocity(spheres,collisions(qq,1),collisions(qq,2));
      spheres(index1,4) = vAx;
      spheres(index1,5) = vAy;
      spheres(index2,4) = vBx;
      spheres(index2,5) = vBy;
    end
   t = t - dtprime;
  end
  
  %Plot particles
  s = size(spheres);
  ss = s(1);
  theta = linspace(0,2*pi,50);
  for i = 1:ss
      x = spheres(i,2) + cos(theta);
      y = spheres(i,3) + sin(theta);
      plot(x,y);
      hold on;
  end
  frame = getframe;
  writeVideo(v,frame);
end
close(v);


  
    
  
  
  
  

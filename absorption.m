function [spheres] = absorption(spheres, A, B, density)
 % function to account for inelastic collisions via absorption. A & B represent the 
 % two spheres colliding. As a result sphere C is formed and will replace one of the 
 % original spheres in the array, with the array being modified to accomodate. 
 
 % vector to hold sphere C data
 C = zeros(1,5);
 
 % angles of motion for A and B
 %thetaA = atan2((spheres(A,5)),(spheres(A,4)));
 %thetaB = atan2((spheres(B,5)),(spheres(B,4)));
 
 % masses of A and B
Avol = (4/3)*pi*((spheres(A,1))^3);
Bvol = (4/3)*pi*((spheres(B,1))^3);
mA = density*Avol;
mB = density*Bvol;
 
 % calculation of sphere C data
 Cvol = Avol + Bvol;  % sphere C volume
 rC = ((3*Cvol)/(4*pi))^(1/3); % sphere C radius
 C(1,1) = rC;

 
 % calculation of sphere C x and y coords (midpoint of A & B centers)
 C(1,2) = (spheres(A,2) + spheres(B,2))/2;
 C(1,3) = (spheres(A,3) + spheres(B,3))/2;
 
 
 % calculation of sphere C x and y velocity
 vCx = ((mA*spheres(A,4))+(mB*spheres(B,4)))/(mA+mB);
 vCy = ((mA*spheres(A,5))+(mB*spheres(B,5)))/(mA+mB);
 C(1,4) = vCx;
 C(1,5) = vCy;

 
 % when spheres A and B collidie they form a single new sphere C. Hence the spheres array 
 % has to be modified to represent that by reducing the number of rows and updating
 % the data 
 s = size(spheres);
 ss = s(1);
 spheres(A:(ss-1),:) = spheres((A+1):ss,:); %shift array up one row -overwrite A
 for k = 1:5
   spheres((B-1),k) = C(1,k);      % overwrite B with C data
 end
 spheres(ss,:) = [];
 
 
end

function [collisions] = detectCollision(spheres,ns,boundaryWidth,boundaryHeight)
  % function that detects collisions and outputs an array with the collision 
  % information. These collisions are detected by first checking broad-phase
  % collisions. Following that we do an exact collison test for the spheres that
  % underwent bfroad-phase collisions.
  
  AABBarray = makeAABB(spheres);
  AABBlength = length(AABBarray);
  
  % no. of cells and cell dimensions in cell array
  Ncells = 36;        % can be any number (chose one with a nice sq root)
  Nrows = sqrt(Ncells);
  Ncolumn = sqrt(Ncells);
  cellWidth = boundaryWidth/Ncolumn;   % width of a cell
  cellHeight = boundaryHeight/Nrows;    % Height of a cell
  
  cellIndex = zeros(ns,sqrt(Ncells));
  index = 0;
  index = index + 1;
  for k = 1:4:AABBlength
    cellIndex(index,1) = AABBarray(k,3);
    % Top left coords
    xCurrent = AABBarray(k,1);
    yCurrent = AABBarray(k,2);
    col_num = ceil(xCurrent/cellWidth);
    row_num = Nrows - floor(yCurrent/cellHeight);
    cellnumber = ((col_num - 1)*Nrows) + row_num;
    cellIndex(index,2) = cellnumber;
    
    %Bottom left coords
    xCurrent = AABBarray((k+1),1);
    yCurrent = AABBarray((k+1),2);
    col_num = ceil(xCurrent/cellWidth);
    row_num = Nrows - floor(yCurrent/cellHeight);
    cellnumber = ((col_num - 1)*Nrows) + row_num;
    cellIndex(index,3) = cellnumber;
    
    %Top right coords
    xCurrent = AABBarray((k+2),1);
    yCurrent = AABBarray((k+2),2);
    col_num = ceil(xCurrent/cellWidth);
    row_num = Nrows - floor(yCurrent/cellHeight);
    cellnumber = ((col_num - 1)*Nrows) + row_num;
    cellIndex(index,4) = cellnumber;
    
    %Bottom right coords
    xCurrent = AABBarray((k+3),1);
    yCurrent = AABBarray((k+3),2);
    col_num = ceil(xCurrent/cellWidth);
    row_num = Nrows - floor(yCurrent/cellHeight);
    cellnumber = ((col_num - 1)*Nrows) + row_num;
    cellIndex(index,5) = cellnumber;
    
    
    index = index + 1;
  end
  
  % Broad phase collision check
  G = size(cellIndex);
  H = G(1);     % number of rows in cellIndex array
  BPC = cell(ns,1);   % create cell array to store Broad phase collisions (BPCs)
  for m = 1:H
    array_pos = cellIndex(:,2:end);
    row_pos = array_pos(m,:);
   for j = row_pos
     if (j <= ns && j > 0)
       z = BPC{j};
       if (any(z == m) == 0)
         w = horzcat(z,m);
         BPC{j} = w;
       end
     end
   end
 end
 
 % Only BPCs have been accounted for 
 collisions = [];   % empty array to be filled later
 L = length(BPC);
 for n = 1:L
   CurrentArray = BPC{n};
   L2 = length(CurrentArray);
   if L2 > 1        % fail AABB collision test 
     % Move onto exact collision test
     for n2 = 1:L2
       for n3 = (n2+1):L2
         % positions of spheres during collision (x and y coords)
         p1 = [spheres((CurrentArray(n2)),4)  spheres((CurrentArray(n2)),5)];
         p2 = [spheres((CurrentArray(n3)),4)  spheres((CurrentArray(n3)),5)];
         centroid_diff = sqrt((((p2(1))-(p1(1)))^2) + (((p2(2))-(p1(2)))^2));
         if (centroid_diff < (spheres((CurrentArray(n2)),1) + (spheres((CurrentArray(n3)),1))))
           % exact collision confirmed - update cell array with positions and coords
           collisions = [collisions; CurrentArray(n2) CurrentArray(n3) spheres((CurrentArray(n2)),2) spheres((CurrentArray(n2)),3) spheres((CurrentArray(n3)),2) spheres((CurrentArray(n3)),3)];
                                   %sphere A ref no.  %sphere B ref no.   % sphere A x coord           %  sphere A y coord            % sphere B x coord             % sphere B y coord                                        
         end
       end
     end
   end
 end
 
end

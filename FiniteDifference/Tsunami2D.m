% Fiona Pigott
% Chris Miller
% Dustin Martin


% Solve the 2-D wave equation subject to
% fixed boundary condition on right
% moving boundary condition on left
% --------------------------------------

clear all
close all
clc

nFrames = 400;                % number of frames in the movie

% set physical parameters ------------------------------------------
c = 1;                        
deltaT = 0.02;
deltaX = 0.05;
deltaY = 0.05;
lamb1 = (c*deltaT/deltaX)^2;
lamb2 = (c*deltaT/deltaY)^2;

% Define the dimensions of the pool
xRight = 4; % x dim
x = linspace(0, xRight,(xRight/deltaX +1) );  % x node locations
nx = length(x);

yTop = 4; % y dim
y = linspace(0, yTop, (yTop/deltaY +1) );     % y node locations
ny = length(y);

% Calculate the depth function at all points. NO change with time
[h, hx, hy] = depth2D(x,y);

% Begin calculating the wave --------------------------------------

% We're going to calculate our matrices such that each matrix includes 
% the spatial phantom values, then only plot the actual values w/n the
% bound of the problem. -> size(waveMatrix) = ny+2, nx+2, where
% waveMatrix(:,1) = left phantom
% waveMatrix(:,nx+2) = right phantom
% waveMatrix(1,:) = top phantom
% waveMatrix(ny+2,:) = bottom phantom. This is where index from 0 would be
% nice....

% NOTE: the i corresponds to x, the j to y
% Define vectors of indeces so this code will beeasier to interpret later

% y index (row index)
in = 2:ny+1;
% x index (col index)
jn = 2:nx+1;

% Always start the pool at some zero wave
uInit = zeros(ny+2,nx+2);       % set temporal initial values
% load('AKWaterColormap','AKWaterColormap')
% set(gcf,'Colormap',AKWaterColormap)
waveplot = surf(x,y,uInit(in,jn));
axis([0 xRight 0 yTop -.1 .1])  
shading interp   
colormap('bone')
drawnow

% Set up uCur
uCur = zeros(ny+2,nx+2);

% Now calculate the interior points for the first time-step
% This is for du/dn = 0 on the boundarys
uCur(in,jn) = ...
    lamb2*.5*h.*...
    ((uInit(in-1,jn)-2*uInit(in,jn)+uInit(in+1,jn)) + ...
     hy*.5.*(uInit(in+1,jn)-uInit(in+1,jn-1))) + ...
    lamb1*.5*h.*...
    ((uInit(in,jn-1)-2*uInit(in,jn)+uInit(in,jn+1)) + ...
    hx*.5.*(uInit(in,jn+1)-uInit(in,jn-1))) + ...
    uInit(in,jn);

% So we know the left boundary of uCur, the beginning of the wave function
% Only 1 timestep has passed, therefore t = deltaT
uCur(in,2) = leftBoundary(deltaT, deltaT, nx,ny, uCur);

% Now calculate the edges for the first time-step.
% Top phantoms:
uCur(:,1) = uInit(:,3);
% Bottom phantoms
uCur(:,nx+1:nx+2) = uInit(:,nx-1:nx);
% Right phantoms
uCur(ny+1:ny+2,:) = uInit(ny+1:ny+2,:);

waveplot = surf(x,y,uCur(in,jn));
axis([0 xRight 0 yTop -.1 .1]);
shading interp 

drawnow

uFut = uCur;

                        % and the rest of the time steps...
for k = 2 : nFrames
    
   uCur(in,2) = leftBoundary(k, deltaT, nx, ny, uCur);
    
   uFut(in,jn) = ...
        lamb2*h.*...
        ((uCur(in-1,jn)-2*uCur(in,jn)+uCur(in+1,jn)) ...
        + hy*.5.*(uCur(in+1,jn)-uCur(in-1,jn))) + ...
        lamb1*h.*...
        ((uCur(in,jn-1)-2*uCur(in,jn)+uCur(in,jn+1))...
        + hx*.5.*(uCur(in,jn+1)-uCur(in,jn-1)))...
        + 2*uCur(in,jn) - uInit(in,jn);
    
    % Now calculate the edges for the first time-step.

    % Top phantoms:
    uFut(1,:) = uFut(3,:);
    % Bottom phantoms
    uFut(ny+2,:) = uFut(ny,:);
    % Right phantoms
    uFut(:,nx+2) = uFut(:,nx);
    % Left phantoms
    uFut(:,1) = uFut(:,3); %reflects off the left wall

    waveplot = surf(x,y,uFut(in,jn));
    axis([0 xRight 0 yTop -.1 .1])  
    shading interp

    drawnow

    uInit = uCur;            % update u values
    uCur = uFut;
end


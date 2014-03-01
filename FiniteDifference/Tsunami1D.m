% Fiona Pigott
% Chris Miller
% Dustin Martin

% Solve the 1-D wave equation subject to
% a*u + b*(du/dx) = c on the right
% moving boundary condition on left
% -------------------------------------------

clear all
close all
clc

nFrames = 800;                % number of frames in the movie

c = 1;                        % set physical parameters
deltaT = 0.02;
deltaX = 0.02;
lamb = (c*deltaT/deltaX)^2;
alpha = 0;
beta = 1;
gamma = 0;

xRight = 4;                   % calculate x node locations
x = linspace(0, xRight, (xRight/deltaX +1) );
n = length(x);


uInit = zeros(1,n);            % set values for uInit, uCur and uFut
uCur  = uInit;
uFut  = uCur;


water = area(x,uInit); xlabel('X axis'), ylabel('Y axis'),
               title('1 Dimensional Wave'), axis([0 xRight -.2 .2])
               set(water,'BaseValue',-1);
drawnow

   
[h, hx] = depth1D(x);

                             % set left spatial boundary value
uCur(1) = leftBoundary1D(1, deltaT);
for i = 2 : n  
 
    % calculate the first time-step
    if i == n
        if beta == 0
            uCur(n) = gamma/alpha;
        else
            phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
            uCur(n) =( lamb*((uInit(i-1)-2*uInit(i)+phantom)*h(i) +...
                hx(i)*deltaX*.5*(phantom-uInit(i-1)))-uInit(i)+phantom)*-.5;
        end
    else
        uCur(i) = ( lamb*((uInit(i-1)-2*uInit(i)+uInit(i+1))*h(i) +...
            hx(i)*deltaX*.5*(uInit(i+1)-uInit(i-1)))-uInit(i)+uInit(i+1))*-.5;
    end
end

water = area(x,uCur); xlabel('X axis'), ylabel('Y axis'),
              title('1 Dimensional Wave'), axis([0 xRight -.2 .2])
              set(water,'BaseValue',-1);
drawnow

                               % and the rest of the time steps...
for k = 2 : nFrames   
    
      uFut(1) = leftBoundary1D(k, deltaT);
      
      for i = 2 : n
       
          if i == n
              if beta == 0
                  uFut(n) = gamma/alpha;
              else
                  phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
                  uFut(n) = lamb*((uCur(i-1)-2*uCur(i)+phantom)*h(i) +...
                      hx(i)*deltaX*((phantom-uCur(i-1))/2)) - uInit(i) + 2*uCur(i);
              end
          else
              uFut(i) = lamb*((uCur(i-1)-2*uCur(i)+uCur(i+1))*h(i) +...
                  hx(i)*deltaX*((uCur(i+1)-uCur(i-1))/2)) - uInit(i) + 2*uCur(i);
          end
          
          if k > 50
              uFut(1) = uCur(2);
          end
          
      end
      water = area(x,uFut); xlabel('X axis'), ylabel('Y axis'),
                    title('1 Dimensional Wave'), axis([0 xRight -.2 .2])
                    set(water,'BaseValue',-1)
      drawnow

      uInit = uCur;            % update u values
      uCur  = uFut;
end


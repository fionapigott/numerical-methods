function u = leftBoundary(t, deltaT, nx, ny, uCur)

x = linspace(-1,1,(ny));

if ( t < 0.5/deltaT);
    % x dependent
    % u = 0.1*cos(2*pi*x*t*deltaT);
    % sin wave, no x dependence
    u = .05*sin(2*pi*t*deltaT);
    % square wave from the corner
    % u(1:floor(ny/2)) = .08;
    % u(floor(ny/2):ny) = 0;
elseif (t < 200 )
    u = 0;
else
    u = uCur(2:ny+1,2);
end
function u = leftBoundary1D(t, deltaT)

if ( t < .5/deltaT);
    u = 0.05*sin(2*pi*t*deltaT);
else ( t < 50 );
    u = 0;

end
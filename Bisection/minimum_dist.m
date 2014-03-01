%Fiona Pigott, Chris Miller, Dustin Martin
%Project 1
%APPM 3050
%April 6, 2012

% Call a function to define the closest approach of the projectile
% for some defined target position and defined theta

function [ dmin ] = minimum_dist ( xtar, ytar, theta, alpha, beta )

%Initial values-------------------------------------------
% Initial velocity value in m/s
vo = 1500;
%---------------------------------------------------------

% Integrate for the path of the projectile----------------
options = odeset('Events', @minevent);

% Note that t is a column vector of time values
% f is a 4X4 matrix.
    % f(:,1) = x position values
    % f(:,2) = y position values
    % f(:,3) = velocity values
    % f(:,4) = theta values
    
[ t, f ] = ... 
    ode45(@delposition, ...
    [0,100], [0, 0, vo, theta], options, [xtar, ytar], [alpha, beta]);

% Look for how many iterations
lengthf = length(f);

% Decide if it is an undershot or an overshot:------------
% The cross product between the distance vector and the 
% velocity vector is positive k direction if it is an overshot
% and negative k if it is an undershot.

% Get the values of x, y, v and theta where distance is minimized
fvalx = f(lengthf,1);
fvaly = f(lengthf,2);
fvalv = f(lengthf,3);
fvalth = f(lengthf,4);
% Calculate the vectors vdistance and vvelocity
 vdistance = [ xtar-fvalx, ytar-fvaly, 0 ];
 vvelocity = [ fvalv*cos(fvalth), fvalv*sin(fvalth), 0 ];
% Find the sign of the k component of the cross product
crossprod = cross(vdistance, vvelocity);
signcross = (crossprod(3)/abs(crossprod(3)));

% Use those x and y values to calculate distance
% with the sign as determined by sign_dist
dmin = signcross;
end

% Create a function to define a "stop integration" point

function [ value, isterminal, direction ] = minevent(t, f, P1, P2)

% Distance between the projectile and the target
dist = (f(1)-P1(1))^2 + (f(2)-P1(2))^2;

% Find the point where distance begins increasing at an increasing rate
% i.e. d(dist)/dt > 0 (ddistdt), d^2(dist)/dt^2 > 0
% So, find where ddistdt passes through zero going in the + direction

ddistdt = ...
    ((f(1)-P1(1))*f(3)*cos(f(4)) + (f(2)-P1(2))*f(3)*sin(f(4)))/dist;

% Look for the time that d(dist)/dt = 0;
value = ddistdt;
% Stop the integration
isterminal = 1;
% When the derivative passes through zero going in the positive direction
direction = 1; 

end


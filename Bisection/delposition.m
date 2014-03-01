%Fiona Pigott, Chris Miller, Dustin Martin
%Project 1
%APPM 3050
%April 6, 2012

% Define a function containing the equations for the derivatives

function [ dotf ] = delposition(t, f, P1, P2)

%Note that:
% The function takes a column vector f(4,1) with 
% f(1) = x ( = x position )
% f(2) = y ( = y position )
% f(3) = v ( = velocity )
% f(4) = theta ( = angle between velocity and the ground )

% And it returns a column vector dotf(4,1) with
% dotf(1) = x dot
% dotf(2) = y dot
% dotf(3) = v dot
% dotf(4) = theta dot

% Constants----------------------------------------
% Value for Cd/m in m^-1
Cd_div_m = .002;
% Value for gravitational force in m/s^2
g = 9.81;
%--------------------------------------------------

% Wind----------------------------------------------
alpha = P2(1);
beta = P2(2);
%-------------------------------------------------

%Streamline the calcuations that you make most often
% Cosine of theta
costh = cos(f(4));
% Sine of theta
sinth = sin(f(4));
% the magnitude of the velocity with respect to the air
v_pa = ((f(3)*costh-alpha)^2 + (f(3)*sinth-beta)^2)^.5;
%--------------------------------------------------

%Delta functions-----------------------------------
% dependent on v, theta, wind vector, (inherently, t)
% Column vector "dot" that contains the functions for the derivatives
dotf = [0;0;0;0]; % Pre-allocate the vecotr "dot"
dotf(1) = f(3)*costh;
dotf(2) = f(3)*sinth;
dotf(3) = -Cd_div_m * v_pa * (f(3) - alpha*costh - beta*sinth) - g*sinth;
dotf(4) = -Cd_div_m/f(3)*v_pa * (alpha*sinth - beta*costh) - g/f(3)*costh;
%--------------------------------------------------

end



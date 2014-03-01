
%Fiona Pigott, Chris Miller, Dustin Martin
%Project 1
%APPM 3050
%April 6, 2012 

% Given a vector for the coordinates of the x and y position,
% and a vector for the wind (of constant velocity)
% Use bisection to zero in on the correct firing angle

% Returns theta_tar, the angle theta required to hit the target
function [ theta_tar ] = Target ( coord, wind )

%tic

% Get the coordinates & wind vector
xtar = coord(1);
ytar = coord(2);
alpha = wind(1);
beta = wind(2);


% Define a tolerance for theta_tar ---------------------
tol = .00005;

% Define original theta guesses --------------------
% Use the angle without wind to define a good mid-range guess
% Without wind (first quadrant only)
% Use the angle from the origin to the target to define a good undershot
th1 = atan(ytar/xtar);
% Use vertical as an all-encompassing overshot 
th2 = pi/2; 

% Run bisection to find a theta for the no-wind solution

% Original dtheta
dtheta = abs(th2 - th1);

while dtheta > tol %Stop the loop when theta changes by less than tol
    
    % Find a new theta mid
    thmid = (th2 + th1)/2; 
    % Replace the outher theta value with the same sign as theta mid
    if minimum_dist(xtar, ytar, th1, 0, 0 )*...
            minimum_dist(xtar, ytar, thmid, 0, 0) > 0
        th1 = thmid;
    else
        th2 = thmid;
    end
    % Calculate how much theta is changing
    dtheta = abs(th2 - th1);
    
end 

th_no_wind = thmid;

if(norm(wind) > 0) % If the wind isn't zero

    % Now, vary the theta for no wind by some reasonable amount
    % to come up with new guesses
    
    % Decide if th_no_wind is an under or overshot, given wind conditions
    if( minimum_dist(xtar, ytar, th_no_wind, alpha, beta) < 0 )
        th1 = th_no_wind;
        th2 = th_no_wind + pi/8;
    else
        th2 = th_no_wind;
        th1 = th_no_wind - pi/8;
    end
 
    % Begin the bisection for the wind case----------------------------
    dtheta = abs(th2 - th1);

      while dtheta > tol %Stop the loop when theta changes by less than tol
    
        % Find a new theta mid
        thmid = (th2 + th1)/2;
        % Replace the outer theta value with the same sign as theta mid
        
        % Fisrt check to make sure that theta 1,2 and mid aren't all the
        % same sign
        if (minimum_dist(xtar, ytar, th2, alpha, beta)*...
              minimum_dist(xtar, ytar, thmid, alpha, beta) < 0)
     
                 th1 = thmid;
           
        else
            th2 = thmid;
           
        end
        
     % Calculate how much theta is changing
        dtheta = abs(th2 - th1);

      end 
   
    theta_tar = thmid;

else
   
    theta_tar = th_no_wind;
    
end

%toc

end
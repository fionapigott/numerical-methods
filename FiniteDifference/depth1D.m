function [h, hx] = depth1D(x)

%---------------------------------
% h is h(x) = depth function measured down from
% the equlibrium surface
%
% hx is dh/dx
%---------------------------------

% h = 1;
% hx = 0;
% 
 h = 1 - (x/4)*.8;
 hx = -.8/4*ones(size(x));


% h = .8 * ones(dims);
% hx = zeros(dims);

end
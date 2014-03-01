function [h, hx, hy] = depth(x,y)

%---------------------------------
% h is h(x) = depth function measured down from
% the equlibrium surface
%
% hx is dh/dx
%---------------------------------

% h = 1;
% hx = 0;
% 
[X, Y] = meshgrid(x,y);
dims = size(X);

% h = 1 - .2*ones(dims);
% hx = zeros(dims);
% hy = zeros(dims);

h = 1 - (Y/4)*.1 - (X/4)*.1;
hx = -.1/4*ones(dims);
hy = -.1/4*ones(dims);

% h = 1+.05 * exp(-((X-2).^2+(Y-2).^2));
% hx = -.1*exp(-(-2+X).^2-(-2+Y).^2).*(-2+X);
% hy = -.1*exp(-(-2+X).^2-(-2+Y).^2).*(-2+Y);

% h = .1.*(1-exp(-1-(X.*Y)));
% hx = .1*exp(-1-X.*Y).*Y;
% hy = .1*exp(-1-X.*Y).*X;

% h = 1-.02*Y;
% hy = -.02*ones(dims);
% hx = zeros(dims);

end
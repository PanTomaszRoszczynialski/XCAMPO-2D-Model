function out = simpleLens2D(X,Y,radius,SIZE)
% IN must by mesgrided

t = linspace(-radius,radius,SIZE);
% [X, Y] = meshgrid(t,t);
% dimension control please
sigmaSq = 0.25 * 10e-10;

%% lightning points
x0 = [-radius 0 radius]/3;
y0 = [-radius 0 radius]/3;
amps = [1 0.8 0.95; 0.88 0.5 1; 1 1 1];
g = zeros(SIZE);
for i = 1 : length(x0)
    for j = 1 : length(y0)
        g = g + amps(i,j) * ...
            exp((-(X-x0(i)).^2 - (Y-y0(j)).^2)/sigmaSq);
    end
end

out = g;
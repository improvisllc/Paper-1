%% International standard atmosphere
function r = rhoSTD(h)
T0 = 288.15;
%P0 = 101325;
rho0 = 1.225;
R = 287.05;
g0 = 9.80665;
l = -6.5/1000;
T = T0 + l*h;
r = rho0 * (T/T0)^(-g0/(l*R) - 1);
end
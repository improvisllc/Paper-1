clc; clear;
format short;
gamma = 1.4;
L = [1.078, 1.435, 3.315];
T = 273.15 + 15;
R = 287.052874;
nu = 1.48 * 10^(-5);
Ma = [0.3, 0.5, 0.7, 0.9, 1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0, 2.5, 3.0, 3.5, 4.0];
v = Ma.*sqrt(gamma * R * T);
Kn = zeros(length(L),length(Ma));
for i=1:length(L)
    Re = v.*L(i)/nu;
    Kn(i,:) = Ma.* sqrt(gamma * pi / 2)./Re;
end

dxs5 = [5,4,3,2]/1000;
dxs8 = [4,3.1,2.2,1.73,1.54,1.4,1.3,1.25,1.21,1.19,0.98]/1000;
dxs8 = [5,4,3,2,1]/1000;
dxs25 = [23,17,12.5,9,7,5,4,3]/1000;
Knc5 = L(1)./dxs5;
Knc8 = L(2)./dxs8;
Knc25 = L(3)./dxs25;
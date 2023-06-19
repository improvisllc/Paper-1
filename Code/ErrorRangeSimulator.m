clc; clear;

R = {'s5', 's5s', 's8', 's8s', 's25O', 's25OF', 'Hydra70MK66_M151', 'Hydra70MK66_M261'};
V0 = [41.2, 37.8, 50, 48.7, 32.6, 31, 42.2720, 37.1340];
M0 = [5, 5.94, 11.1, 11.7, 370, 409, 10.8182, 12.3150];
Mk = [3.87, 4.81, 7.93, 8.4, 278, 320, 7.5432, 9.0401];
Tk = [0.675, 0.675, 0.88, 0.88, 2.65, 2.65, 1.15, 1.15];
jk = [2286, 2286, 6435, 6435, 192510, 192510, 6585.616901556, 6585.616901556];
D = [0.057, 0.057, 0.08, 0.08, 0.42, 0.37, 0.07, 0.07];
Dcd = [0.18, 0.18, 0.12, 0.12, 0.08, 0.08, 0.216, 0.273];

x0 = 0; y0 = 0; z0 = 0; alpha0 = 0; beta0 = 0; psi0 = 0; gamma0 = 0; wx10 = 0; wy10 = 0; wz10 = 0;

Theta0 = 5:85;

%% Table of flight range
Legend=cell(2*length(V0),1);
for h=1:length(V0)
    r = R{h}; v0 = V0(h); m0 = M0(h); mk = Mk(h); tk = Tk(h); Jk = jk(h);
    d = D(h); dcd = Dcd(h);

%     x = zeros(length(Theta0),1);
%     x_cfd = x;
    k = -20:0.01:20;
    dxk = readmatrix(['dxk20_',r,'.csv']);
%     dxk = zeros(length(Theta0),length(k));
%     for i = 1:length(Theta0)
%         theta0 = Theta0(i);
%         [xt, ~, ~, ~, ~, ~, ~] = trajectory4f(x0, y0, theta0, v0, m0, mk, tk, Jk, d, dcd, r);
%         parfor j = 1:length(k)
%             [xtk, ~, ~, ~, ~, ~, ~] = trajectory4ferr(x0, y0, theta0, v0, m0, mk, tk, Jk, d, dcd, r, k(j));
%             dxk(i,j) = (xt - xtk) * 1000 / xt;
%         end
%     end
    um = 16*3;
    lm = -16*3;
    vu = ones(size(Theta0))*20;
    vd = -ones(size(Theta0))*20;
    for i = 1:length(Theta0)
        for j = 2:length(k)
            if dxk(i,j) == lm
                vd(i) = k(j);
            elseif dxk(i,j-1) < lm && dxk(i,j) > lm
                vd(i) = interp1([dxk(i,j-1), dxk(i,j)], [k(j-1),k(j)], lm); %0.5 * (k(j-1) + k(j));
%               interp1([k(j-1),k(j)],[dxk(i,j-1), dxk(i,j)], vd(i))
            end
            if dxk(i,j) == um
                vu(i) = k(j);
            elseif dxk(i,j-1) < um && dxk(i,j) > um
                vu(i) =  interp1([dxk(i,j-1), dxk(i,j)], [k(j-1),k(j)], um); %0.5 * (k(j-1) + k(j));
%               interp1([k(j-1),k(j)],[dxk(i,j-1), dxk(i,j)], vu(i))
            end
        end
%         plot(k, dxk(i,:)); grid on; hold on;
    end
%     writematrix(dxk,['dxk20_',r,'.csv']);
    vul = ones(size(k)) * 16*3;
    vdl = -ones(size(k)) * 16*3;
%     hul = plot(k, vul, 'g', 'LineWidth', 2); hold on;
%     hdl = plot(k, vdl, 'c', 'LineWidth', 2); hold on;
%     xlabel('C_D_0 error, %');
%     ylabel('Flight range error, thousands');
%     title('Range errors for launching angles from 5 to 85 degrees');
    % extract the handles that require legend entries
%     hleglines = [hul hdl];
    % create the legend
%     hleg = legend(hleglines,'Upper limit of accepted dispersion (3\sigma)','Lower limit of accepted dispersion (-3\sigma)');

    % figure;
    plot(Theta0, vu, Theta0, vd); grid on; hold on;
    Legend{2*(h-1)+1} = ['Upper lim ', r];
    Legend{2*(h-1)+2} = ['Lower lim ', r];    
end

xlabel('launching angle, deg');
ylabel('C_D_0 error corresponding to acceptable flight dispersion, %');
title('Acceptable C_D_0 errors in % for launching angles from 5 to 85 degrees');
legend(Legend);


% subplot(3,1,1)
% plot(lam, x, lam, x_cfd); grid on;
% xlabel('\lambda_0, deg');
% ylabel('X, m');
% legend('Exp','CFD');
% subplot(3,1,2)
% plot(lam, abs(x-x_cfd));grid on;
% xlabel('\lambda_0, deg');
% ylabel('|\DeltaX|, m');
% legend('Abs Err')
% subplot(3,1,3)
% plot(lam, abs(x-x_cfd)./x * 100);grid on;
% xlabel('\lambda_0, deg');
% ylabel('|\DeltaX|, %');
% legend('Abs Err')
% % saveas(gcf,'Exp_vs__CFD.png');
% close;

%% The first line grabs the last additions to the figure, 
%  the second line deletes from the plot the last element added to the figure.
% children = get(gca, 'children');
% delete(children(1));

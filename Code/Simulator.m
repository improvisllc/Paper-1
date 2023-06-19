clc; clear;

%% Table of flight range
R = {'s5', 's8', 's25'};
V0 = [41.2, 50, 31];
M0 = [5, 11.1, 409];
Mk = [3.87, 7.93, 320];
Tk = [0.675, 0.88, 2.65];
jk = [2286, 6435, 192510];
D = [0.057, 0.08,0.37];
Dcd = [0.18, 0.12, 0.08];

x0 = 0;
y0 = 0;
lam = 5:85;
x = zeros(3,length(lam));
x_cfd = x;

xmaxs5 = 0; xmaxs8 = 0; xmaxs25 = 0;
xmaxs5c = 0; xmaxs8c = 0; xmaxs25c = 0;

for i = 1:length(lam)
    lam0 = lam(i);
    [xt, ~, Vt, LAMt, Xt, Yt, Tt] = trajectory(x0, y0, lam0, V0(1), M0(1), Mk(1), Tk(1), jk(1), D(1), Dcd(1), 's5');
    [xtCFD, ~, VtCFD, LAMtCFD, XtCFD, YtCFD, TtCFD] = trajectory_cfd(x0, y0, lam0, V0(1), M0(1), Mk(1), Tk(1), jk(1), D(1), Dcd(1), 's5');    
    x(1,i) = xt;
    x_cfd(1,i) = xtCFD;
    if(xt >= xmaxs5)
        Xmaxs5 = Xt; Ymaxs5 = Yt; Vmaxs5 = Vt; Lammaxs5 = LAMt; Tmaxs5 = Tt;
        xmaxs5 = xt;
    end
    if(xtCFD >= xmaxs5c)
        Xmaxs5c = XtCFD; Ymaxs5c = YtCFD; Vmaxs5c = VtCFD; Lammaxs5c = LAMtCFD; Tmaxs5c = TtCFD;
        xmaxs5c = xtCFD;
    end
    [xt, ~, Vt, LAMt, Xt, Yt, Tt] = trajectory(x0, y0, lam0, V0(2), M0(2), Mk(2), Tk(2), jk(2), D(2), Dcd(2), 's8');
    [xtCFD, ~, VtCFD, LAMtCFD, XtCFD, YtCFD, TtCFD] = trajectory_cfd(x0, y0, lam0, V0(2), M0(2), Mk(2), Tk(2), jk(2), D(2), Dcd(2), 's8');    
    x(2,i) = xt;
    x_cfd(2,i) = xtCFD;
    if(xt >= xmaxs8)
        Xmaxs8 = Xt; Ymaxs8 = Yt; Vmaxs8 = Vt; Lammaxs8 = LAMt; Tmaxs8 = Tt;
        xmaxs8 = xt;
    end
    if(xtCFD >= xmaxs8c)
        Xmaxs8c = XtCFD; Ymaxs8c = YtCFD; Vmaxs8c = VtCFD; Lammaxs8c = LAMtCFD; Tmaxs8c = TtCFD;
        xmaxs8c = xtCFD;
    end
    [xt, ~, Vt, LAMt, Xt, Yt, Tt] = trajectory(x0, y0, lam0, V0(3), M0(3), Mk(3), Tk(3), jk(3), D(3), Dcd(3), 's25');
    [xtCFD, ~, VtCFD, LAMtCFD, XtCFD, YtCFD, TtCFD] = trajectory_cfd(x0, y0, lam0, V0(3), M0(3), Mk(3), Tk(3), jk(3), D(3), Dcd(3), 's25');    
    x(3,i) = xt;
    x_cfd(3,i) = xtCFD;
    if(xt >= xmaxs25)
        Xmaxs25 = Xt; Ymaxs25 = Yt; Vmaxs25 = Vt; Lammaxs25 = LAMt; Tmaxs25 = Tt;
        xmaxs25 = xt;
    end
    if(xtCFD >= xmaxs25c)
        Xmaxs25c = XtCFD; Ymaxs25c = YtCFD; Vmaxs25c = VtCFD; Lammaxs25c = LAMtCFD; Tmaxs25c = TtCFD;
        xmaxs25c = xtCFD;
    end
end

figure
subplot(3,1,1)
plot(lam, x(1,:), lam, x_cfd(1,:), lam, x(2,:), lam, x_cfd(2,:), lam, x(3,:), lam, x_cfd(3,:)); grid on;
xlabel('\lambda_0, deg');
ylabel('X, m');
legend('Exp 57 mm','CFD 57 mm','Exp 80 mm','CFD 80 mm','Exp 266 mm','CFD 266 mm');
title('Flight ranges at different launching angles')
subplot(3,1,2)
plot(lam, (x(1,:)-x_cfd(1,:)), lam, (x(2,:)-x_cfd(2,:)), lam, (x(3,:)-x_cfd(3,:)));grid on;
xlabel('\lambda_0, deg');
ylabel('\DeltaX, m');
legend('57 mm', '80 mm', '266 mm');
title('Flight range error in meters')
subplot(3,1,3)
plot(lam, (x(1,:)-x_cfd(1,:))./x(1,:) * 1000, lam, (x(2,:)-x_cfd(2,:))./x(2,:) * 1000, lam, (x(3,:)-x_cfd(3,:))./x(3,:) * 1000);grid on;
xlabel('\lambda_0, deg');
ylabel('\DeltaX, thousandths');
legend('57 mm', '80 mm', '266 mm');
title('Flight range error in thousandths')

Y_maxs5 = max(Ymaxs5); 
t_Ymaxs5 = Tmaxs5'*(Y_maxs5==Ymaxs5); 
X_Ymaxs5 = Xmaxs5'*(Y_maxs5==Ymaxs5); 
V_Ymaxs5 = Vmaxs5'*(Y_maxs5==Ymaxs5); 
Lam_Ymaxs5 = Lammaxs5'*(Y_maxs5==Ymaxs5);

Y_maxs5c = max(Ymaxs5c); 
t_Ymaxs5c = Tmaxs5c'*(Y_maxs5c==Ymaxs5c); 
X_Ymaxs5c = Xmaxs5c'*(Y_maxs5c==Ymaxs5c); 
V_Ymaxs5c = Vmaxs5c'*(Y_maxs5c==Ymaxs5c); 
Lam_Ymaxs5c = Lammaxs5c'*(Y_maxs5c==Ymaxs5c);

Y_maxs8 = max(Ymaxs8); 
t_Ymaxs8 = Tmaxs8'*(Y_maxs8==Ymaxs8); 
X_Ymaxs8 = Xmaxs8'*(Y_maxs8==Ymaxs8); 
V_Ymaxs8 = Vmaxs8'*(Y_maxs8==Ymaxs8); 
Lam_Ymaxs8 = Lammaxs8'*(Y_maxs8==Ymaxs8);

Y_maxs8c = max(Ymaxs8c); 
t_Ymaxs8c = Tmaxs8c'*(Y_maxs8c==Ymaxs8c); 
X_Ymaxs8c = Xmaxs8c'*(Y_maxs8c==Ymaxs8c); 
V_Ymaxs8c = Vmaxs8c'*(Y_maxs8c==Ymaxs8c); 
Lam_Ymaxs8c = Lammaxs8c'*(Y_maxs8c==Ymaxs8c);

Y_maxs25 = max(Ymaxs25); 
t_Ymaxs25 = Tmaxs25'*(Y_maxs25==Ymaxs25); 
X_Ymaxs25 = Xmaxs25'*(Y_maxs25==Ymaxs25); 
V_Ymaxs25 = Vmaxs25'*(Y_maxs25==Ymaxs25); 
Lam_Ymaxs25 = Lammaxs25'*(Y_maxs25==Ymaxs25);

Y_maxs25c = max(Ymaxs25c); 
t_Ymaxs25c = Tmaxs25c'*(Y_maxs25c==Ymaxs25c); 
X_Ymaxs25c = Xmaxs25c'*(Y_maxs25c==Ymaxs25c); 
V_Ymaxs25c = Vmaxs25c'*(Y_maxs25c==Ymaxs25c); 
Lam_Ymaxs25c = Lammaxs25c'*(Y_maxs25c==Ymaxs25c);

figure
title('Estimated elements of trajectories for maximum ranges based on experimental results');
subplot(3,1,1)
plot(Xmaxs5,Ymaxs5,X_Ymaxs5,Y_maxs5,'ro',Xmaxs8,Ymaxs8,X_Ymaxs8,Y_maxs8,'go',Xmaxs25,Ymaxs25,X_Ymaxs25,Y_maxs25,'co');grid on;
xlabel('X, m');
ylabel('Y, m');
legend(['\lambda_0 = ', num2str(Lammaxs5(1)), ' deg for 57 mm'], ['Y_m_a_x = ', num2str(Y_maxs5), ' m for 57 mm'],...
       ['\lambda_0 = ', num2str(Lammaxs8(1)), ' deg for 80 mm'], ['Y_m_a_x = ', num2str(Y_maxs8), ' m for 80 mm'],...
       ['\lambda_0 = ', num2str(Lammaxs25(1)), ' deg for 266 mm'], ['Y_m_a_x = ', num2str(Y_maxs25), ' m for 266 mm']);

subplot(3,1,2)
plot(Tmaxs5, Vmaxs5, t_Ymaxs5, V_Ymaxs5, 'ro', Tmaxs8, Vmaxs8, t_Ymaxs8, V_Ymaxs8, 'go', Tmaxs25, Vmaxs25, t_Ymaxs25, V_Ymaxs25, 'co');grid on;
xlabel('t, s');
ylabel('v, m/s');
legend(['\lambda_0 = ', num2str(Lammaxs5(1)), ' deg for 57 mm'],'at Y_m_a_x for 57 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs8(1)), ' deg for 80 mm'],'at Y_m_a_x for 80 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs25(1)), ' deg for 266 mm'],'at Y_m_a_x for 266 mm');

subplot(3,1,3)
plot(Tmaxs5, Lammaxs5, t_Ymaxs5, Lam_Ymaxs5, 'ro', Tmaxs8, Lammaxs8, t_Ymaxs8, Lam_Ymaxs8, 'go', Tmaxs25, Lammaxs25, t_Ymaxs25, Lam_Ymaxs25, 'co');grid on;
xlabel('t, s');
ylabel('\lambda, deg');
legend(['\lambda_0 = ', num2str(Lammaxs5(1)), ' deg for 57 mm'],'at Y_m_a_x for 57 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs8(1)), ' deg for 80 mm'],'at Y_m_a_x for 80 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs25(1)), ' deg for 266 mm'],'at Y_m_a_x for 266 mm');

figure
title('Estimated elements of trajectories for maximum ranges based on CFD results');
subplot(3,1,1)
plot(Xmaxs5c,Ymaxs5c,X_Ymaxs5c,Y_maxs5c,'ro',Xmaxs8c,Ymaxs8c,X_Ymaxs8c,Y_maxs8c,'go',Xmaxs25c,Ymaxs25c,X_Ymaxs25c,Y_maxs25c,'co');grid on;
xlabel('X, m');
ylabel('Y, m');
legend(['\lambda_0 = ', num2str(Lammaxs5c(1)), ' deg for 57 mm'], ['Y_m_a_x = ', num2str(Y_maxs5c), ' m for 57 mm'],...
       ['\lambda_0 = ', num2str(Lammaxs8c(1)), ' deg for 80 mm'], ['Y_m_a_x = ', num2str(Y_maxs8c), ' m for 80 mm'],...
       ['\lambda_0 = ', num2str(Lammaxs25c(1)), ' deg for 266 mm'], ['Y_m_a_x = ', num2str(Y_maxs25c), ' m for 266 mm']);

subplot(3,1,2)
plot(Tmaxs5c, Vmaxs5c, t_Ymaxs5c, V_Ymaxs5c, 'ro', Tmaxs8c, Vmaxs8c, t_Ymaxs8c, V_Ymaxs8c, 'go', Tmaxs25c, Vmaxs25c, t_Ymaxs25c, V_Ymaxs25c, 'co');grid on;
xlabel('t, s');
ylabel('v, m/s');
legend(['\lambda_0 = ', num2str(Lammaxs5c(1)), ' deg for 57 mm'],'at Y_m_a_x for 57 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs8c(1)), ' deg for 80 mm'],'at Y_m_a_x for 80 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs25c(1)), ' deg for 266 mm'],'at Y_m_a_x for 266 mm');

subplot(3,1,3)
plot(Tmaxs5c, Lammaxs5c, t_Ymaxs5c, Lam_Ymaxs5c, 'ro', Tmaxs8c, Lammaxs8c, t_Ymaxs8c, Lam_Ymaxs8c, 'go', Tmaxs25c, Lammaxs25c, t_Ymaxs25c, Lam_Ymaxs25c, 'co');grid on;
xlabel('t, s');
ylabel('\lambda, deg');
legend(['\lambda_0 = ', num2str(Lammaxs5c(1)), ' deg for 57 mm'],'at Y_m_a_x for 57 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs8c(1)), ' deg for 80 mm'],'at Y_m_a_x for 80 mm', ...
       ['\lambda_0 = ', num2str(Lammaxs25c(1)), ' deg for 266 mm'],'at Y_m_a_x for 266 mm');
   
% saveas(gcf,'Exp_vs__CFD.png');
% close;



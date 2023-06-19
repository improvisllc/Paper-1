function [x, t, V, LAM, X, Y, T] = trajectory(x0, y0, lam0, v0, m0, mk, tk, Jk, d, dcd, r)

ta = tk;
y10 = v0; y20 = lam0 * pi / 180; y30 = x0; y40 = y0; y50 = m0;

[t1,y1] = aktiv(y10, y20, y30, y40, y50, mk, tk, Jk, d, dcd, ta, r);
n=size(y1);
n=n(1);
vp = y1(n,1); lamp = y1(n,2); xp = y1(n,3); yp = y1(n,4); mp = y1(n,5);

if t1(n) == ta
    [t2,y2] = pasiv (vp, lamp, xp, yp, mp, d, ta, r);
    t = [t1;t2]; X = [y1(:,3);y2(:,3)]; Y = [y1(:,4);y2(:,4)]; V = [y1(:,1);y2(:,1)];
    LAM = [y1(:,2);y2(:,2)]; LAM = LAM * 180 / pi;             
else
    t = t1; X = y1(:,3); Y = y1(:,4); V = y1(:,1); LAM = y1(:,2); LAM = LAM * 180 / pi; 
end
T = t;
x = X(length(X));
t = t(length(t));

end

%% Active Part
function [t,y] = aktiv (v0, lam0, x0, y0, m0, mk, tk, Jk, d, dcd, ta, r) 

tstart = 0;
tfinal = ta;

options = odeset('Events' ,@evs, 'OutputSel', 1, 'RelTol', 1e-6, 'AbsTol', 1e-9);

[t,y] = ode113(@(t,y)balact(t,y,m0,mk,tk,Jk,d,dcd,r),[tstart tfinal],[v0 lam0 x0 y0 m0],options); 
end
%% Passive Part
function [t,y] = pasiv (v0, lam0, x0, y0, mk, d, ta, r) 

tstart = ta;
tfinal = ta + 100;

options = odeset('Events' ,@evs, 'OutputSel', 1, 'RelTol', 1e-6, 'AbsTol', 1e-9);

[t,y] = ode113(@(t,y)balpas(t,y,mk,d,r),[tstart tfinal],[v0 lam0 x0 y0],options);
end
%% Ballsitics of Active Part
function dydt = balact(t,y,m0,mk,tk,Jk,d,dcd,r)

dydt = zeros(5,1);
g=9.81; 
s = pi*d^2/4; 
dcxo = dcd;

[~,rho,~,a] = intstdatm(y(4));

M = y(1)/a;

cxo = dragCoeff(M,r)-dcxo;

Td = Jk/tk;
dydt(1) = Td/y(5)-cxo*rho*y(1)^2*s/(2*y(5))-g*sin(y(2));
dydt(2) = - g * cos(y(2))/ y(1);
dydt(3) = y(1) * cos(y(2));
dydt(4) = y(1) * sin(y(2)); 
dydt(5) = (mk-m0)/tk;
end
%% Ballistics of Passive Part
function dydt = balpas(t,y,mk,d,r)

dydt = zeros(4,1);   
g=9.81;
s = pi*d^2/4;

[~,rho,~,a] = intstdatm(y(4));

M = y(1)/a;

cxo = dragCoeff(M,r);

dydt(1) = -cxo*rho*y(1)^2*s/(2*mk)-g*sin(y(2));
dydt(2) = - g * cos(y(2))/ y(1);
dydt(3) = y(1) * cos(y(2));
dydt(4) = y(1) * sin(y(2)); 
end
%% Events
function [value,isterminal,direction] = evs(t,y)
% Locate the time when height passes through zero in a decreasing direction
% and stop integration.  
value = y(4);     % detect height = 0
isterminal = 1;   % stop the integration
direction = -1;   % negative direction
%[value,isterminal,direction]
end

function cx = dragCoeff(m, r)
    M     = [0,0.3,0.5,0.7,0.9,1.0,1.1,1.2,1.4,1.6,1.8,2.0,2.5,3.0,3.5,4.0];
    cxS5  = [0.9,0.9,0.9,0.9,0.98,1.16,1.165,1.137,1.08,1.027,0.975,0.932,0.835,0.77,0.71,0.662];
    cxS8  = [0.54 0.54 0.55 0.57 0.7 0.99 1.02 1.0 0.91 0.84 0.79 0.74 0.652 0.59 0.54 0.5];
    cxS25OF = [0.37,0.38,0.385,0.42,0.55,0.8,0.945,0.96,0.92,0.86,0.815,0.77,0.665,0.595,0.525,0.475];   
    
    if(strcmp(r,'s5'))
        cx = pchip(M, cxS5, m); 
    elseif(strcmp(r,'s8'))
        cx = pchip(M, cxS8, m);    
    elseif(strcmp(r,'s25'))
        cx = pchip(M, cxS25OF, m);    
    end
end
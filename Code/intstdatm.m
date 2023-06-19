function [p,rho,T,a] = intstdatm(h)
    R = 287.058; k = 1.4; dT = 273.15; T1=-56.5+dT; T2=T1; T3=-44.5+dT;
    T4=-2.5+dT; T5=T4; 
    h1=11000; h2=20000; h3=32000; h4=47000;
    p0 = 1.01325*10^5; rho0 = 1.225; T0 = 288.15;
    g=9.80665; a1=-0.0065; a3=0.001; a4=0.0028; 
    P1=p0*(T1/T0)^(-g/(a1*R));
    rho1=rho0*(T1/T0)^(-g/(a1*R)-1);
    P2=P1*exp(-g*(h2-h1)/(R*T2));
    rho2=rho1*exp(-g*(h2-h1)/(R*T2));
    P3=P2*(T3/T2)^(-g/(a3*R));
    rho3=rho2*(T3/T2)^(-g/(a3*R)-1);
    P4=P3*(T4/T3)^(-g/(a4*R));
    rho4=rho3*(T4/T3)^(-g/(a4*R)-1);
    
    if h<=h1
        T=T0+a1*h;
        p=p0*(T/T0)^(-g/(a1*R));
        rho=rho0*(T/T0)^(-g/(a1*R)-1);
    end
    if h>h1 && h<=h2
        T=T2;
        p=P1*exp(-g*(h-h1)/(R*T));
        rho=rho1*exp(-g*(h-h1)/(R*T));
    end
    if h>h2 && h<=h3
        T=T2+a3*(h-h2);
        p=P2*(T/T2)^(-g/(a3*R));
        rho=rho2*(T/T2)^(-g/(a3*R)-1);
    end
    if h>h3 && h<=h4
        T=T3+a4*(h-h3);
        p=P3*(T/T3)^(-g/(a4*R));
        rho=rho3*(T/T3)^(-g/(a4*R)-1);
    end
    if h>h4
        T=T5;
        p=P4*exp(-g*(h-h4)/(R*T5));
        rho=rho4*exp(-g*(h-h4)/(R*T5));
    end
    a = sqrt(k*R*T);
end
function rho = rhoMoist(p, T, hum)
    T0 = 273.15; %K
    Rd = 287.058; %J/(kg·K)
    Rv = 461.495; %J/(kg·K)


    p1 = 6.1078 * 10^(7.5*T /(T + 237.3));
    pv = p1 * hum;
    pd = p - pv;
    T = T + T0;
    
    rho = (pd / (Rd * T)) + (pv / (Rv * T));
end
function [xk,yk,zk,tk,Ek] = ECEF(prn,eph,arrTime,prange_time)
% 1 Eccentricity:                             e
% 2 Time of Applicability(s):                 TOE
% 3 Orbital Inclination(rad):                 I_0
% 4 Rate of Right Ascen(r/s):                 OMEGA_DOT
% 5 SQRT(A) (m^1/2):                          SQRT_A
% 6 Right Ascen at TOA(rad):                  OMEGA_0
% 7 Argument of Perigee(rad):                 OMEGA
% 8 Mean Anom(rad):                           M_0
% 9 mean motion diff(r/s):                    DELTA_N
% 10 Rate of inclin (r/s):                    I_DOT
% 11 lat cosine ampl (r):                     CUC
% 12 Lat sine ampl   (r):                     CUS
% 13 radius cos ampl (m):                     CRC
% 14 radius sin ampl (m):                     CRS
% 15 inclin cos ampl(r):                      CIC
% 16 inclin sin ampl(r):                      CIS
% 17 t_gd:                                    T_GD
% 18 t_oc:                                    T_OC
% 19 Af0(s):                                  af0
% 20 Af1(s/s):                                af1
% 21 Af2(s/s/s):                              af2


mu = 3.986004418e14; %grav parameter
omega_dot_e = 7.2921151467e-5; %earth rotation
TOE = eph(2);
A = eph(5)^2;
n0 = sqrt(mu/A^3);
tk = arrTime - eph(2) - prange_time;
n  = n0 + eph(9);
Mk = eph(8) + n*tk;

e = eph(1);
for i = 1:length(Mk)
    Ek(i) = Eapprox(Mk(i),e);
end
Ek = Ek';
Ek = mod(Ek,2*pi);
vk = 2*atan(sqrt((1+e)/(1-e))*tan(Ek/2));

latk = vk + eph(7);
cuc = eph(11); cus = eph(12); crc = eph(13); crs = eph(14); cic = eph(15); cis = eph(16);

duk = cus*sin(2*latk)+cuc*cos(2*latk);
drk = crs*sin(2*latk)+crc*cos(2*latk);
dik = cis*sin(2*latk)+cic*cos(2*latk);

uk = latk+duk;
rk = A*(1-e*cos(Ek))+drk;
ik = eph(3) + dik + eph(10)*tk;

xkp = rk.*cos(uk);
ykp = rk.*sin(uk);

omk = eph(6) + (eph(4) - omega_dot_e).*tk - omega_dot_e * eph(2);

xk = xkp .* cos(omk) - ykp .* cos(ik) .* sin(omk);
yk = xkp .* sin(omk) + ykp .* cos(ik) .* cos(omk);
zk = ykp .* sin(ik);

end
function [iono] = klobmodel2(lat,long,az,el,GPStime,alpha,beta)
c = 299792458;
psi = 0.0137./(el/180 + 0.11) - 0.022; % sc
iono_lat = lat + psi*180 .* cosd(az);
iono_long = long + psi*180 .* sind(az) ./ cosd(iono_lat);
lat_mag = iono_lat + (0.064*cos((iono_long/180 - 1.617)))*180;
A2 =0;A4 = 0;
for i = 1:4
    A2 = A2 + alpha(i)*(lat_mag/180).^(i-1);
    A4 = A4 + beta(i)*(lat_mag/180).^(i-1);
end
t = 43200*iono_long/180 + GPStime;
x = 2*pi*(t - 50400)./A4;
tz = 5e-9 + A2.*(1 - x.^2/2 + x.^4/24);
F = 1+16*(.53-el/180).^3;
iono = F.*tz*c;









end

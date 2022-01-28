function iono = klobmodel(lat,long,az,el,gpstime,alpha,beta)
c = 299792458;
% Calculate Psi
psi = 0.0137./(el/180 + 0.11) - 0.022; % sc
% Calculating IPP Coordinates
iono_lat = lat + psi * 180 .* cosd(az);
iono_long = long + psi * 180 .* sind(az) ./ cosd(iono_lat);
if iono_lat > 75
    iono_lat = 75;
elseif iono_lat < -75
    iono_lat = -75;
end
% Calculating magnetic Latitude 
iono_lat_mag =  iono_lat + 0.064*180*cosd((iono_long/180 - 1.617)*180);
% Calculating Coefficients and Klobuchar Model
A2 = 0; A4 = 0;
for i = 1:4
    A2 = A2 + alpha(i)*(iono_lat_mag/180).^(i-1);
    A4 = A4 + beta(i)*(iono_lat_mag/180).^(i-1);
end
t = 43200*iono_long/180 + gpstime;
x = 2*pi*(t - 50400)./A4;

tz = 5e-9 + A2 .* (1 - x.^2/2 + x.^4/24);
ind = find(abs(x) >= 1.57);
tz(ind) = 5e-9;
F = 1.0 + 16.0*(0.53-el/180).^3;
iono = F .* tz * c;
end
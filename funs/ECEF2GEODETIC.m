function [lat,long,h] = ECEF2GEODETIC(XHAT)
% ellipsoid shape/size
ellipse = wgs84Ellipsoid;
a = ellipse.SemimajorAxis;
b = ellipse.SemiminorAxis;
R = norm(XHAT(1:3));
lat = asind(XHAT(3)/R); % start with geocentric
long = atan2d(XHAT(2),XHAT(1));
p = sqrt(XHAT(1)^2 + XHAT(2)^2);
% iterate for geodetic latitude
for k = 1:100
    N = a^2/sqrt(a^2*cosd(lat)^2+b^2*sind(lat)^2);
    h = p/cosd(lat) - N;
    lat = asind(XHAT(3)/(b^2/a^2*N + h));
end
end
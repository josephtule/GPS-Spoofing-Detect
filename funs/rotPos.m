function [ARRECEF,GPSECEF] = rotPos(x,y,z,delay)
wE = 7.2921151467e-5;
GPSECEF = [x,y,z];
for i = 1:length(delay)
    R = [cos(wE*delay(i)), sin(wE*delay(i)), 0;
        -sin(wE*delay(i)), cos(wE*delay(i)), 0;
        0 0 1];
    ARRECEF(:,i) = R * GPSECEF(i,:)';
end
ARRECEF = ARRECEF';
end

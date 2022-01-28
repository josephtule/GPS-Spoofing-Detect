function [x,y,z,xd,yd,zd,dR,dRd,ORT] = extractnav(nav)
x = nav(:,4);
y = nav(:,5);
z = nav(:,6);
xd = nav(:,8);
yd = nav(:,9);
zd = nav(:,10);
dR = nav(:,7);
dRd = nav(:,11);
ORT = [nav(:,2),nav(:,3)];
end
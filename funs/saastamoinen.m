function trop = saastamoinen(RH,T,P0,lat,long,h0,az,el)
e0 = 6.108*RH .* exp((17.15*T - 4684)./(T-38.5));
drydelay_S = 0.0022777*(1 + 0.0026*cosd(2*lat) + 0.00028*h0) .* P0;
wetdelay_S = 0.0022777 * (1255./T + 0.05).*e0;

% Chao Mapping Function
Chaomap_d = 1./(sind(el) + 0.00143./(tand(el) + 0.0445));
Chaomap_w = 1./(sind(el) + 0.00035./(tand(el) + 0.0170));
% Chao Saas
trop = drydelay_S.*Chaomap_d + wetdelay_S.*Chaomap_w;
end
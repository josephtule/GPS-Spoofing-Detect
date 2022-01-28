function E = Eapprox(Mk,e)
% Mk is a constant

E = Mk;
for j = 1:10
    E = E + (Mk - E + e*sin(E))/(1-e*cos(E));
end
end


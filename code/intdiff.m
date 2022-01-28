function dxdt = intdiff(x,t)
%Interpolated differencing
%x is the input vector
%t is the reference vector for spacing
    dxdt = diff(x)./diff(t);
    dxdt = interp1(t(1:end-1),dxdt,t,'previous');
end
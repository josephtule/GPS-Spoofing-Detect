function XHAT = navsolPD(GPStime,prnnums,posR,prange_corr,start,dR,option)
n = length(prnnums);
xk = start;
XHAT(1,:) = xk;
stop = length(GPStime)-1;
for i = 1:length(prnnums)
    prange_sdiff(:,i) = diff(prange_corr(:,i));
end
for t = 1:stop
    delta = 1;
%         while delta > .05
    for i = 1:6
        for i = 1:length(prnnums)
            rkp(i,1) = norm(xk - posR{i}(t,:));
            rkp2(i,1) = norm(xk - posR{i}(t+1,:));
            ukp{t,i} = (xk - posR{i}(t+1,:))/rkp(i);
            M2(i,:) = ukp{t,i};
            pcomp = rkp(i) + dR(t);
            yk(i,1) = prange_corr(t,i) - pcomp;
        end
        G = [M2,ones(n,1)];
        if isequal(string(option),"LS")
            xkpxk = inv(G'*G)*G'*yk;
        elseif isequal(string(option),"PD")
            xkpxk = inv(M2.'*M2)* M2.' * yk;
        end
        xk = xkpxk(1:3)' + xk;
        delta = norm(xkpxk(1:3));
    end
    XHAT(t+1,:) = xk;
end
end
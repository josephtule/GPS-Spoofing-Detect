function estimate = navsolLS(gECEF,prange_corr,sat_pos,GPStime,prnset)

y = cell(length(GPStime),1);
H = cell(length(GPStime),1);
delR = cell(length(GPStime),1);
XHAT = cell(length(GPStime),1);
Xstar = cell(length(GPStime),1);

% iterative process for calculating navigation solution for all time steps
for p = 1:length(GPStime)
    Xstar{p} = [gECEF;1];
end
for i = 1:length(GPStime) % for each time step
    delta = 100;
    %%%% Iterated Part
    k = 1;
    while delta > 0.05
        if k > 1
            old = delR{i};
        end
        for j = 1:length(prnset)
            range_comp = norm(sat_pos{j}(i,:) - Xstar{i}(1:3)');
            prange_comp = range_comp+Xstar{i}(4);
            y{i}(j,:) = prange_corr(i,j) - prange_comp; %1
            H{i}(j,:) = [(Xstar{i}(1:3)'-sat_pos{j}(i,:))/range_comp,1]; %2
        end
        delR{i} = (H{i}'*H{i})\H{i}'*y{i};
        XHAT{i} = Xstar{i}+delR{i};
        Xstar{i} = XHAT{i};
        estimate(i,:) = XHAT{i}';
        if k > 1
            delta = norm(delR{i}(1:3));
        end
        k = k+1;
    end
end


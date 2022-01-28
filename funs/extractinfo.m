function [az,el] = extractinfo(txinfo,prn,offset1,offset2)
% az = 4; el = 5;
for i = 1:length(prn)
    prnrow = find(txinfo(:,8)==prn(i));
    
    if isempty(prnrow)
        error('PRN is not within the dataset');
    end
    
    az(:,i) = txinfo(prnrow,4);
    el(:,i) = txinfo(prnrow,5);
end

txinfo_prn = txinfo(prnrow,:);
if offset1 ~= 0
    az(1:offset1,:) = [];
    el(1:offset1,:) = [];
end
if offset2 ~= 0
    az(offset2:end,:) = [];
    el(offset2:end,:) = [];
end
end
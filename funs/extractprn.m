function [dop,cphase,prange,cn0,RRT,ORT] = extractprn(texbat,prn,offset1,offset2)
% dop = 6; cphase = 7; prange = 8; cn0 = 9;

for i = 1:length(prn)
    prnrow = find(texbat(:,14)==prn(i));
    
    if isempty(prnrow)
        error('PRN is not within the dataset');
    end
    
    dop(:,i) = texbat(prnrow,6);
    cphase(:,i) = texbat(prnrow,7);
    prange(:,i) = texbat(prnrow,8);
    cn0(:,i) = texbat(prnrow,9);
    RRT = texbat(prnrow,2);
    ORT = texbat(prnrow,4)+texbat(prnrow,5);
end


% prndata = texbat(prnrow,:);
if offset1 ~= 0
    dop(1:offset1,:) = [];
    cphase(1:offset1,:) = [];
    prange(1:offset1,:) = [];
    cn0(1:offset1,:) = [];
    RRT(1:offset1,:) = [];
    ORT(1:offset1,:) = [];
end
if offset2 ~= 0
    dop(offset2:end,:) = [];
    cphase(offset2:end,:) = [];
    prange(offset2:end,:) = [];
    cn0(offset2:end,:) = [];
    RRT(offset2:end,:) = [];
    ORT(offset2:end,:) = [];
end
end
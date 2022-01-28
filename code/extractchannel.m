function [RRT,ORT,DOP,CPHASE,PRANGE,CN0] = extractchannel(channel,prnnums)
ninerows = find(channel(:,3) == 9999);
channel(ninerows,:) = [];
for i = 1:length(prnnums)
    prnind = find(channel(:,14) == prnnums(i));
    DOP(:,i) = channel(prnind,6);
    CPHASE(:,i) = channel(prnind,7);
    PRANGE(:,i) = channel(prnind,8);
    CN0(:,i) = channel(prnind,9);
    RRT = channel(prnind,2);
    ORT = [channel(prnind,4), channel(prnind,5)];
end
end
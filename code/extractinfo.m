function [az,el,ORT] = extractinfo(info,prnnums)
for i = 1:length(prnnums)
    prnind = find(info(:,8) == prnnums(i));
    az(:,i) = info(prnind,4);
    el(:,i) = info(prnind,5);
end
ORT = [info(prnind,2),info(prnind,3)];
end
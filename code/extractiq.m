function [I,Q,ORT] = extractiq(iq,prnnums)
ninerows = find(iq(:,3) == 9999);
iq(ninerows,:) = [];
i = find(iq(:,11)==133); iq(i,:) = [];
% i = find(iq(:,11)==138); iq(i,:) = [];
% i = find(iq(:,9)==1); iq(i,:) = [];
for i = 1:length(prnnums)
    prnindc(:,i) = {find(iq(:,11) == prnnums(i))};
    lens(i) = length(prnindc{i});
end
m = min(lens);
for i = 1:length(prnnums)
    ind = find(iq(:,11) == prnnums(i));
    prnind(:,i) = ind(1:m); 
end
    
ORT = [iq(prnind(:,1),4),iq(prnind(:,1),5)];

for i = 1:length(prnnums)
    I(:,i) = iq(prnind(:,i),7);
    Q(:,i) = iq(prnind(:,i),8);
end
ORT = [ORT(621:20:end,1),ORT(621:20:end,2)];
I = I(621:20:end,:);
Q = Q(621:20:end,:);
ORT = ORT(1:2114,:);
I = I(1:2114,:);
Q = Q(1:2114,:);
end
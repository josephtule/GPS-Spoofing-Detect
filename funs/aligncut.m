function [x,y,t] = aligncut(x,y,t1,t2)
% align and cut 2 vectors depending in their time vectors

offset = find(t1(int8(length(t1)/2),1)==t2)-int8(length(t1)/2);
t = t1;
if offset > 0
    x(end-offset+1:end,:)=[];
    y(1:offset,:)=[];
    t(end-offset+1:end,:)=[];
elseif offset < 0
    x(1:-offset,:)=[];
    y(end+offset+1:end,:)=[];
    t(1:-offset,:)=[];
elseif offset == 0 & size(x,1) ~= size(y,1)
    sizes = [size(x,1),size(y,1)];
    minsize = min(sizes);
    x = x(1:minsize,:);
    y = y(1:minsize,:);
    t = t(1:minsize,:);
end
end
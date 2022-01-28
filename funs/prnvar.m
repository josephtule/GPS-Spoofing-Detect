function prnnames = prnvar(prnnums,filename)
prnnames = string(zeros(size(prnnums)));
for j = 1:length(prnnums)
    prnnames(j) = string(filename) + "_" + string(prnnums(j));
end
end
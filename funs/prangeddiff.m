function ddiff = prangeddiff(data1,data2)
sdiff1 = diff(data1); sdiff2 = diff(data2);
ddiff = sdiff1 - sdiff2;
end
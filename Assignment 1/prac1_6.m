function [out] = prac1_6(in,n)
l = length(in);
parts = ceil(l/n);
out = [];
for i = 1:parts
    l = length(in);
    if l-n+1>=1
        new_part=in(l-n+1:l);
        in(l-n+1:l) = [];
    else
        new_part=in(1:l);
        in(1:l) = [];
    end
    out = [out,new_part];    
end
end
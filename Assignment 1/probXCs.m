pxCs1= @(x)((1/sqrt((2*pi)^length(m1)*det(S10)))*exp(-0.5*transpose(x-m1)*inv(S10)*(x-m1)))
pxCs0= @(x)((1/sqrt((2*pi)^length(m0)*det(S10)))*exp(-0.5*transpose(x-m0)*inv(S10)*(x-m0)))

p_xCs1=[];
% Test = Train;
p_xCs0=[];

for q=1:length(Test)
   p_xCs1(q)=pxCs1(transpose(Test(q,1:8)));
end
for q=1:length(Test)
   p_xCs0(q)=pxCs0(transpose(Test(q,1:8)));
end

pC1sx = p_xCs1./(p_xCs1+p_xCs0);
pC0sx = p_xCs0./(p_xCs1+p_xCs0);
result = [];
for q=1:length(Test)
    if pC1sx(q)>= 0.5
        result(q) = 1;
        count = count+1;
    else
        result(q)=0;
    end
end
compare = [];
compare = [Test(:,9) transpose(result)];
count = 0;
for k= 1:length(Test)
if compare(k,1)==compare(k,2)
    count = count+1;
end
end
      
errorSTest = 100*(length(Test)-count)/length(Test);
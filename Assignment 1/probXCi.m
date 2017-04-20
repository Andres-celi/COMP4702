Test = Train
pxC1= @(x)((1/sqrt((2*pi)^length(m1)*det(S1)))*exp(-0.5*transpose(x-m1)*inv(S1)*(x-m1)))
pxC0= @(x)((1/sqrt((2*pi)^length(m0)*det(S0)))*exp(-0.5*transpose(x-m0)*inv(S0)*(x-m0)))

p_xC1=[];
p_xC0=[];

for q=1:length(Test)
   p_xC1(q)=pxC1(transpose(Test(q,1:8)));
end
for q=1:length(Test)
   p_xC0(q)=pxC0(transpose(Test(q,1:8)));
end

pC1x = p_xC1./(p_xC1+p_xC0);
pC0x = p_xC0./(p_xC1+p_xC0);
result = [];
for q=1:length(Test)
    if pC1x(q)>= 0.5
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
      
errorTrain = 100*(length(Test)-count)/length(Test);
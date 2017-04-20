function [errorTest,S1,S0,m1,m0]=fitData(Test,g1,g0,S1,S0,m,m0)
results = [];
g=[];
for j=1:length(Test)
    g(j)=g1(transpose(Test(j,1:8)));
end
g00=[];
for j=1:length(Test)
    g00(j)=g0(transpose(Test(j,1:8)));
end
count = 0;
for k = 1:length(Test)
    if g(k)>g00(k)
        count = count +1;
        results(k) = 1;
    else
        results(k)=0;
    end
end
compare = [];
compare = [Test(:,9) transpose(results)];
count = 0;
for k= 1:length(Test)
if compare(k,1)==compare(k,2)
    count = count+1;
end
end

errorTest = 100*(length(Test)-count)/length(Test);
S1 = S1;
S0 = S0;
m1=m;
m0=m0;

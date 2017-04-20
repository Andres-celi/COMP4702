function [errorTest,m1,m0]=fitData3(Test,m,m0)
results = [];
g=[];
g1 = @(x) (transpose(x)*m-0.5*norm(m).^2);
g0 = @(x) (transpose(x)*m0-0.5*norm(m0).^2);
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
m1=m;
m0=m0;

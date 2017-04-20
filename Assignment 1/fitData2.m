function [serrorTest,S10,m,m0]=fitData2(Test,S101,S100,S10,m,m0)
sresults = [];
gs=[];

for q=1:length(Test)
    gs(q)=S101(transpose(Test(q,1:8)));
end
gs00=[];
for q=1:length(Test)
    gs00(q)=S100(transpose(Test(q,1:8)));
end
count = 0;
for q = 1:length(Test)
    if gs(q)>gs00(q)
        count = count +1;
        sresults(q) = 1;
    else
        sresults(q)=0;
    end
end
scompare = [];
scompare = [Test(:,9) transpose(sresults)];
count = 0;
for q= 1:length(Test)
if scompare(q,1)==scompare(q,2)
    count = count+1;
end
end

serrorTest = 100*(length(Test)-count)/length(Test);
S10 = S10;

m1=m;
m0=m0;

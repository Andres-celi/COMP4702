X=[randn(30,1);5+randn(30,1)];
H=histogram(X,20,'Normalization','pdf');
%Create gaussian mixture model
GaussMixMod = fitgmdist(X,2); 

test= linspace(min(X),max(X),100);
test=transpose(test);

m_1=0; 
sigma_1=1; 
m_2=5; 
sigma_2=1; 

P1 = exp(-(test-m_1).^2./(2*sigma_1^2))./(sigma_1*sqrt(2*pi));
P2 = exp(-(test-m_2).^2./(2*sigma_2^2))./(sigma_2*sqrt(2*pi)); 
 %mixture density using test set
mixD=0.5*P1+0.5*P2;
%0.5 factors as stated in the prac sheet.
M=pdf(GaussMixMod,test);
[f1,xk1]= ksdensity(X);
[f2,xk2]=ksdensity(X,'width',0.5);

%% Calculate KL divergences
% KL1
count=0;
for i=1:length(M)
    contri=M(i)*log(M(i)/mixD(i));
    count=count+contri;
end
KL1=count;
% KL2
count=0;
for i=1:length(M)
    contri=M(i)*log(M(i)/f1(i));
    count=count+contri;
end
KL2=count;
% KL3
count=0;
for i=1:length(M)
    contri=M(i)*log(M(i)/f2(i));
    count=count+contri;
end
KL3=count;


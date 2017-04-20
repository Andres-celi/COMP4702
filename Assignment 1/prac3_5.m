X=[randn(30,1);5+randn(30,1)];
H1=histogram(X,20,'Normalization','pdf');
[H12,LIMS]=hist(X,20);
H12=H12/max(H12);
%Gaussian Mixture Model
GaussMixMod = fitgmdist(X,2); 
%test set
test= linspace(min(X),max(X),100); 
test=transpose(test);
 %parameters of first gaussian
m_1=0;
sigma_1=1;
 %parameters of second gaussian
m_2=5; 
sigma_2=1;
%density function for first gaussian
P1 = exp(-(test-m_1).^2./(2*sigma_1^2))./(sigma_1*sqrt(2*pi)); 
 %density function for second gaussian
P2 = exp(-(test-m_2).^2./(2*sigma_2^2))./(sigma_2*sqrt(2*pi));

Mod=0.5*P1+0.5*P2; 

fh=pdf(GaussMixMod,test);
[f1,xk1,width1]= ksdensity(X,test);
[f2,xk2,width2]=ksdensity(X,test,'width',0.5*width1);
%% Calculate KL divergences

count=0;
for n=1:length(Mod)
    contri=fh(n)*log(fh(n)/Mod(n));
    count=count+contri;
end
KL1=count;

count=0;
for n=1:length(Mod)
    contri=f1(n)*log(f1(n)/Mod(n));
    count=count+contri;
end
KL2=count;

count=0;
for n=1:length(Mod)
    contri=f2(n)*log(f2(n)/Mod(n));
    count=count+contri;
end
KL3=count;

figure
plot(fh');hold on
plot(f1');
plot(f2');
plot(Mod');
legend('fh','f1','f2','Mod');
grid on; grid minor;
xlabel('x');
ylabel('P');
title('Model compared to estimators');
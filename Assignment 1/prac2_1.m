hold off
x = [0:0.1:5];
fx = 2*sin(1.5*x);
plot(x,fx)
xlim([0 5]);
ylim([-5 5]);
hold on

X =datasample(x,20);
fX = 2*sin(1.5*X)+0.1*randn(1,length(X));
plot(X,fX,'x')
xlim([0 5]);
ylim([-5 5]);
figure
XValidation =datasample(x,20);
fXV = 2*sin(1.5*XValidation);
plot(XValidation,fXV,'x')
xlim([0 5]);
ylim([-5 5]);
[xfitresult, xgof] = createFits9x(x,fx)
[fitresult, gof] = createFits9(x,X, fX)



hold on
%% plot of various sse vs polynome degree
XValidation =datasample(x,20);
fX = 2*sin(1.5*X)+0.1*randn(1,length(X));
plot(X,fX,'x')
xlim([0 5]);
ylim([-5 5]);

p = plot(PolynomesDegree,xSSEs,'Marker','*');
title('training/validation mse vs polynome degrees');
legend('training mse vs polynome degree','validation mse vs polynome degree');
ylabel mse
xlabel Degree
grid on
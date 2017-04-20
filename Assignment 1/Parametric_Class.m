function [ Posterior1, Posterior2 ] = Parametric_Class(Data)
%UNTITLED3 Summary of this function goes here
%   Data is a nx2 matrix, having the class identifier in the 2nd column
%Iris=[Iris1(:,1),Iris1(:,2)];
n=1;
firstclass=Data(n,2); %string to be compared

while (strcmp(firstclass, Data(n+1,2)))
    n=n+1;
end
firstSet=cell2mat(Data(1:n,1)); %cell to array
secondSet=cell2mat(Data(n+1:end,1)); %cell to array
figure, 
histogram(firstSet);
title(strcat('Histogram:',Data(n,2)))
xlabel('Value')
ylabel('Frequency')
figure, 
histogram(secondSet);
title(strcat('Histogram:',Data(n+1,2)));
xlabel('Value');
ylabel('Frequency');
params1=mle(firstSet);
params2=mle(secondSet);

values=cell2mat(Data(:,1));
x=linspace(min(values)-1,max(values)+1,100);
figure,
norm1=normpdf(x,params1(1),params1(2));
plot(x,norm1);
hold on; grid on; grid minor;
norm2=normpdf(x,params2(1),params2(2));
plot(x,norm2);
title('Likelihoods')
xlabel('x');
ylabel('p(x|C_i)');
str1=strcat('C1:',Data(n,2));
str2=strcat('C2:',Data(n+1,2));
legend(str1{1},str2{1});
hold off
%% plot priors
xs=linspace(0,max(values)+1,1000);
syms X
g1=-log(params1(2))-((X-params1(1)).^2)/(2*(params1(2))^2); %posteior1 from discriminant
%g1=g1./max(g1(:));
g2=-log(params2(2))-((X-params2(1)).^2)/(2*(params2(2))^2); %posterior2 from discriminant
%g2=g2./max(g2(:));
%Find intersections of g1 and g2
S=solve(g1==g2);
S=double(S);
y1=dsigmf(xs,[5 S(1) 5 S(2)]);
y2=ones(1,length(y1))-y1;
figure
plot(xs,y1);
hold on
plot(xs,y2,'--');
grid on; grid minor;
title('Posteriors with Equal Priors');
xlabel('x');
ylabel('p(C_i|x)');
legend(str1{1},str2{1});
S
Posterior1=g1;
Posterior2=g2;
end


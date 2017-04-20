load('TrainDiabetes.mat');
binario=zeros(length(diabetes),1);
for n=1:length(diabetes)
    cuerda=diabetes(n,9); %will be a cell containing info of whether pos or neg
    if (strcmp(cuerda{1},'pos'))
        binario(n)=1; %1 if positive
    else
        binario(n)=0; %0 if negative
    end
end
diabetes2=cell2mat(diabetes(:,1:8)); %reshaped matrix of diabetes
diabetes2=sortrows([diabetes2,binario],9); %500x9 matrix sorted wrt last column
sumri=length(nonzeros(binario));
PC1= sumri/length(binario); %P(Ci) for YES diabetes
PC0= 1-PC1; %P(Ci) for NO diabetes
%% Analyse Class 0 - Neg Diabetes
Set0=diabetes2(1:(500-sumri),1:8);
m0=mean(Set0);
S0=cov(Set0);
syms x1 x2 x3 x4 x5 x6 x7 x8
X=[x1;x2;x3;x4;x5;x6;x7;x8];
W0=-0.5*inv(S0);
w0=inv(S0)*m0';
w00=-0.5*(m0)*(inv(S0))*(m0')-0.5*log(abs(S0))+log(PC0);
g0=(X')*(W0)*X+(w0')*X+w00;
g0=g0(1,1);
%% Analyse Class 1 - Pos Diabetes
Set1=diabetes2(500-sumri+1:end,1:8);
m1=mean(Set1);
S1=cov(Set1);
W1=-0.5*inv(S1);
w1=inv(S1)*m1';
w10=-0.5*(m1)*(inv(S1))*(m1')-0.5*log(abs(S1))+log(PC1);
g1=(X')*(W1)*X+(w1')*X+w10;
g1=g1(1,1);

%% training set0 error
gtraining=zeros(length(Set0),1);
for m=1:length(Set0)
    x1t=Set0(m,1);
    x2t=Set0(m,2);
    x3t=Set0(m,3);
    x4t=Set0(m,4);
    x5t=Set0(m,5);
    x6t=Set0(m,6);
    x7t=Set0(m,7);
    x8t=Set0(m,8);
    gtraining(m)=subs(g0,[x1;x2;x3;x4;x5;x6;x7;x8],[x1t;x2t;x3t;x4t;x5t;x6t;x7t;x8t]);
end
matmin=min(gtraining);
matmax=max(gtraining);
newg0t=(gtraining-matmin)./(matmax-matmin);
counter=0;
for m=1:length(newg0t)
    if(newg0t(m)<0.5)
        counter=counter+1;
    end
end
trainErrC0=(counter/length(newg0t))*100;
%% Training Set1 Error
gtraining1=zeros(length(Set1),1);
for m=1:length(Set1)
    x1t=Set1(m,1);
    x2t=Set1(m,2);
    x3t=Set1(m,3);
    x4t=Set1(m,4);
    x5t=Set1(m,5);
    x6t=Set1(m,6);
    x7t=Set1(m,7);
    x8t=Set1(m,8);
    gtraining1(m)=subs(g1,[x1;x2;x3;x4;x5;x6;x7;x8],[x1t;x2t;x3t;x4t;x5t;x6t;x7t;x8t]);
end
matmin=min(gtraining1);
matmax=max(gtraining1);
newg1t=(gtraining1-matmin)./(matmax-matmin);
counter=0;
for m=1:length(newg1t)
    if(newg1t(m)<0.5)
        counter=counter+1;
    end
end
trainErrC1=(counter/length(newg1t))*100;
%% Import Test Set
load('TestDiabetes.mat');
binarioTest=zeros(length(diabetesTest),1);
for n=1:length(diabetesTest)
    cuerda=diabetesTest(n,9); %will be a cell containing info of whether pos or neg
    if (strcmp(cuerda{1},'pos'))
        binarioTest(n)=1; %1 if positive
    else
        binarioTest(n)=0; %0 if negative
    end
end
diabetes2Test=cell2mat(diabetesTest(:,1:8)); %reshaped matrix of diabetes
diabetes2Test=sortrows([diabetes2Test,binarioTest],9); %268x9 matrix sorted wrt last column
sumriTest=length(nonzeros(binarioTest));

%% Separate Positives and Negatives
diabetesTestSet0=diabetes2Test(1:(268-sumriTest),1:8);
diabetesTestSet1=diabetes2Test(268-sumriTest+1:end,1:8);
%% Test Class0 Error
gtest0=zeros(length(diabetesTestSet0),1);
for p=1:length(diabetesTestSet0);
    x1ts=diabetesTestSet0(p,1);
    x2ts=diabetesTestSet0(p,2);
    x3ts=diabetesTestSet0(p,3);
    x4ts=diabetesTestSet0(p,4);
    x5ts=diabetesTestSet0(p,5);
    x6ts=diabetesTestSet0(p,6);
    x7ts=diabetesTestSet0(p,7);
    x8ts=diabetesTestSet0(p,8);
    gtest0(p)=subs(g0,[x1;x2;x3;x4;x5;x6;x7;x8],[x1ts;x2ts;x3ts;x4ts;x5ts;x6ts;x7ts;x8ts]);
end
matmin=min(gtest0);
matmax=max(gtest0);
newg0ts=(gtest0-matmin)./(matmax-matmin);
counter=0;
for m=1:length(newg0ts)
    if(newg0ts(m)<0.5)
        counter=counter+1;
    end
end
testErrC0=(counter/length(diabetesTestSet0))*100; %Percent Error for Test Set C0
%% Test Class1 Error
gtest1=zeros(length(diabetesTestSet1),1);
for p=1:length(diabetesTestSet1);
    x1ts=diabetesTestSet1(p,1);
    x2ts=diabetesTestSet1(p,2);
    x3ts=diabetesTestSet1(p,3);
    x4ts=diabetesTestSet1(p,4);
    x5ts=diabetesTestSet1(p,5);
    x6ts=diabetesTestSet1(p,6);
    x7ts=diabetesTestSet1(p,7);
    x8ts=diabetesTestSet1(p,8);
    gtest1(p)=subs(g1,[x1;x2;x3;x4;x5;x6;x7;x8],[x1ts;x2ts;x3ts;x4ts;x5ts;x6ts;x7ts;x8ts]);
end
matmin=min(gtest1);
matmax=max(gtest1);
newg1ts=(gtest1-matmin)./(matmax-matmin);
counter1=0;
for m=1:length(newg1ts)
    if(newg1ts(m)<0.5)
        counter1=counter1+1;
    end
end
testErrC1=(counter1/length(diabetesTestSet1))*100; %Percent Error for Test Set C1
%% Show Figures
figure
subplot(1,2,1)
histogram(newg0t);
xlabel('x');
ylabel('Frequency')
title('Histogram of Training Set for Negative Diabetics');
grid on; grid minor;
subplot(1,2,2)
histogram(newg0ts);
xlabel('x');
ylabel('Frequency');
title('Histogram of Test Set for Negative Diabetics');
grid on; grid minor;

figure
subplot(1,2,1)
histogram(newg1t);
xlabel('x');
ylabel('Frequency');
title('Histogram of Training Set for Positive Diabetics');
grid on; grid minor;
subplot(1,2,2);
histogram(newg1ts);
xlabel('x');
ylabel('Frequency');
title('Histogram of Test Set for Positive Diabetics');
grid on; grid minor;
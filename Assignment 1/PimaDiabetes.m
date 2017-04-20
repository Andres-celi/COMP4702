%% Create Train matrix
Train = [];
Train = pimaindiansdiabetes(1:500,1:9);
%% Create a Test Matrix
Test = [];
Test = pimaindiansdiabetes(501:768,1:9);
%% Calculate probability of C1
P_C1 = sum(Train(:,9))/length(Train);
%% Calculate probability of C2
P_C0 = (length(Train)-sum(Train(:,9)))/length(Train);
%% Generates a matrix with only column 9 = 1 values
c = 1;
Train2=[];
for k = 1:size(Train)
    
    if Train(k,9) == 1
        Train2(c,1:8)=Train(k,1:8);
        c=c+1;
    end
end
%% Generates a matrix with only column 9 = 0 values
c = 1;
Train3=[];
for k = 1:size(Train)
    
    if Train(k,9) == 0
        Train3(c,1:8)=Train(k,1:8);
        c=c+1;
    end
end
%% Calculate mean of all 8 inputs C1
m=[0 0 0 0 0 0 0 0];

for j=1:8
for k=1:size(Train)
    if Train(k,9) == 1
        m11(k) = Train(k,j);
    end
end
m(j) = sum(m11)/sum(Train(:,9));
end
m = transpose(m);

%% Calculate mean of all 8 inputs C0
m0=[0 0 0 0 0 0 0 0];
m01=ones(1,8);
for j=1:8
for k=1:size(Train)
    if Train(k,9) == 0
        m01(k) = Train(k,j);
    end
end
m0(j) = sum(m01)/(length(Train)-sum(Train(:,9)));
end
m0 = transpose(m0);
%%  Covariance matrix of train C1

%Watch to see what method I used (he forgot to divide by N at the end
%though)
%https://www.youtube.com/watch?v=9B5vEVjH2Pk 
deviation = Train2 - ones(length(Train2))*Train2*1/(length(Train2));
S = transpose(deviation)*deviation*1/182; %done with sample formula

%Matlab employs population formula which has an N-1 on the denominator.

Sinv = inv(S);
Sdet=det(S);
%%  Covariance matrix of train C0

%Watch to see what method I used (he forgot to divide by N at the end
%though)
%https://www.youtube.com/watch?v=9B5vEVjH2Pk 
deviation0 = Train3 - ones(length(Train3))*Train3*1/(length(Train3));
S0 = transpose(deviation0)*deviation0*1/length(Train3); %done with sample formula

%Matlab employs population formula which has an N-1 on the denominator.

S0inv = inv(S0);
S0det=det(S0);
%% Quadratic discriminant factors C1


Wi = -0.5*Sinv;
WiT = Sinv*m;
wio = -0.5*transpose(m)*Sinv*m-0.5*log(Sdet)+log(P_C1);

g1=@(x)(transpose(x)*Wi*x+transpose(WiT)*x+wio);
%% Quadratic discriminant factors C0


Wi0 = -0.5*S0inv;
WiT0 = S0inv*m0;
wio0 = -0.5*transpose(m0)*S0inv*m0-0.5*log(S0det)+log(P_C0);

g0=@(x)(transpose(x)*Wi0*x+transpose(WiT0)*x+wio0);
%% analysis of the discriminant C1
% replace every row (xi) in gi. Treshold is 0.5 for normal. To define what
% is in and what is out of the group.

g=[];
for j=1:length(Train)
    g(j)=g1(transpose(Train(j,1:8)));
end
untouched = g;

 %% analysis of the discriminant C0
%  replace every row (xi) in gi. Treshold is 0.5 for normal. To define what
% is in and what is out of the group.
 
g00=[];
for j=1:length(Train)
    g00(j)=g0(transpose(Train(j,1:8)));
end

count = 0;
for k = 1:length(Train)
    if g(k)>g00(k)
        count = count +1;
        results(k) = 1;
    else
        results(k)=0;
    end
end
%% Shared Covariance S10
S10 = P_C0*S0+P_C1*S;
S101 = @(x)(-0.5*transpose(x-m)*inv(S10)*(x-m)+log(P_C1));
S100 = @(x)(-0.5*transpose(x-m0)*inv(S10)*(x-m0)+log(P_C0));

gs1=[];
for j=1:length(Train)
    gs1(j)=S101(transpose(Train(j,1:8)));
end
gs0=[];
for j=1:length(Train)
    gs0(j)=S100(transpose(Train(j,1:8)));
end
count = 0;
for k = 1:length(Train)
    if gs1(k)>gs0(k)
        count = count +1;
        resultss(k) = 1;
    else
        resultss(k)=0;
    end
end












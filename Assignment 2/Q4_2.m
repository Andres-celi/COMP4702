%% Q2
%load a data set
DataSet = [];

%new_actually untouched points
ActiveSet = DataSet;
%choose random starting point
[rows,columns] = size(ActiveSet);
StartPoint = ceil( (columns-1e-6)*rand)
%choose a random mean point
 % % % % 
 
%Select the new point
NewSet = sum(sqrt(x-m));


%Retrieve all points inside the cluster
PointsIn = find( NewSet < BandWith);

%Store previous mean

OldMean = Mean
%Calculate new mean


%if the means are different do:


%create a new set from untouched points

%% test Prac 4.2
a = randn(200,2);
b = a + 4;
c = a;a
c(:,1) = 3*c(:,1);
c = c - 4;
d = [a; b];
e = [a; b; c];
plot(a(:,1),a(:,2),'+');
hold on
plot(b(:,1),b(:,2),'o');
plot(c(:,1),c(:,2),'*');
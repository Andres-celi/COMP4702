Classes = sort(pimaindiansdiabetes);
class1 = Classes(1:500,:);
class2 = Classes(501:700,:);
% plot(class1(:,1),class1(:,2),'b.');hold on
% plot(class2(:,1),class2(:,2),'r.');

%%
count = 0;popo = [];
compare=[];
for k = 1:length(untouched)
    
    if -untouched(k)<=mean(-untouched)
        count = count +1;
        popo = [popo 0];
    else
        popo = [popo 1];
    end
end
compare = [Train(:,9) transpose(popo)]
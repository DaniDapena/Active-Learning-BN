clc 
clear all
n=500;
X = 5*rand(2*n,3);
jj=1;
kk=1;
%%
j=1
h=1
clear class_1 class_2
for i=1:2*n
   if X(i,3)>0.3*cos(X(i,1)*2)+0.3*cos(X(i,2)*2)+2.5
       Trainig_classes(i)=1;
       class_1(:,j)=X(i,:);
       j=j+1;
   else
       Trainig_classes(i)=-1;
       class_2(:,h)=X(i,:);
       h=h+1;
   end
    
    
end
clc
%%
clc
x=0:0.01:5;
y=0:0.01:5;
[XX,Y]=meshgrid(x,y);
z=0.3*cos(XX*2)+0.3*cos(Y*2)+2.5;
mesh(XX,Y,z)
hold on
%%
clc

plot3(class_1(1,:),class_1(2,:),class_1(3,:),'o','color',[0.9 0 0.03])
hold on
plot3(class_2(1,:),class_2(2,:),class_2(3,:),'o','color',[0 0.6 0.8]);


%%
plot(xx_1,Y,'linewidth',3,'color',[00 0 0.8]);


%%
%Trainig_set=X;
Trainig_classes=Trainig_classes';
%%

[v,c] = voronoin(Trainig_set(S,:)); 
for i = 1:length(c) 
if all(c{i}~=1)   % If at least one of the indices is 1, 
                  % then it is an open region and we can't 
                  % patch that.
patch(v(c{i},1),v(c{i},2),i); % use color i.
end
end
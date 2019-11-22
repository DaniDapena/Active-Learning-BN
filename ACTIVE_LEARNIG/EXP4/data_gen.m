clc 
clear all
n=500;
X = 5*rand(2*n,2);
jj=1;
kk=1;
%%


clc
xx_1=unique(Trainig_set(:,1));
Y=((xx_1-5).*(xx_1-0.5).*(xx_1-2.5).*(xx_1-1.5)/10)+3;

%%
clc

plot(Trainig_set(:,1),Trainig_set(:,2),'o','color',[160, 160, 160]/255,'MarkerFaceColor',[0.9 0 0.03],'MarkerSize',3)
hold on
plot(class_2(:,1),class_2(:,2),'o','color',[160, 160, 160]/255,'MarkerFaceColor',[0 0.6 0.8],'MarkerSize',3);


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
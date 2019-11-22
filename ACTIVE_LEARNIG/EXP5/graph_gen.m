clc
clear all
load('data')

%%  Distance Matrix
for i=1:length(Trainig_classes)
    for j=i:length(Trainig_classes)
        distances_M(i,j)=norm((Trainig_set(i,:)-Trainig_set(j,:)));
    end
end

distances_M=distances_M+distances_M';


%% Weigth matrix

clc
w= zeros(400,400);
for i=1:length(Trainig_classes)
    [~,K]=mink(distances_M(i,:),7);
    for j=1:length(K)
        w(i,K(j))=distances_M(i,K(j));
        w(K(j),i) =w(i,K(j));
    end
end
% 
% clc
% for i=1:length(Trainig_classes)
%      for j=1:length(Trainig_classes)   
%          if distances_M(i,j)<0.3
%              w(i,j)=distances_M(i,j);
%          end
%      end
% end
%% Graph:
figure(2)


G = graph(w);
ww=Trainig_classes;
pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'ZData',(Trainig_set(:,3)),'NodeCData',ww);
colormap('jet');
pa.MarkerSize = 4;
pa.EdgeColor=[170,170,170]/255;
pa.LineWidth=0.8;

%% Principal Path Length computation

Gu = graph(w);
Wgeos = distances(Gu);
N =2*n;


num_points=3000;
a=0; b=max(nonzeros(Wgeos(:)));
step=(b-a)/num_points;
dist=step*(1:1:num_points);
 

ht=0;
for rr=1:1:N
    v=Wgeos(rr,:);
    v=nonzeros(v);
    for ii=1:1:max(size(dist))
        h(ii) = sum(v<dist(ii))+1;    
    end  
    %ht=ht+h/G.N; clear h
    ht=ht+h; clear h
end
ht=ht/N;
aux_var=1./ht;
[~,xlim,~]=find(aux_var<=0.8);
%xlim=sum(aux_var<=0.5);
aux_var=aux_var(xlim);
dist=dist(xlim);


% Dividing by the total number of nodes in the graph
figure, plot(aux_var,(dist),'LineWidth',3);grid;
title('Circulant Graph','Interpreter','latex','FontSize',18 )
xlabel('$d$','Interpreter','latex','FontSize',20 );ylabel('$\lambda_{b}$','Interpreter','latex','FontSize',20)
 axis tight
%%
density = [0.01 0.02 0.04 0.08 0.16 0.32];
PathL=[2.156 1.6352 1.2173 0.88561 0.57714 0.42125]; 
%%
D=sum(w,1);
L=diag(D)-w;
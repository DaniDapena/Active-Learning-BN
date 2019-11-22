clc
clear all
sigma = [4 1.5; 1.5 2];
n = 400;
Class_1 =  mvnrnd([3.8,2.5],sigma,n);
Class_2 =  mvnrnd([-3,-2],sigma,n);
figure(1)
plot(Class_1(:,1),Class_1(:,2),'.')
hold on
plot(Class_2(:,1),Class_2(:,2),'r.')
hold off
%%
class_1_v = ones(n,1);
class_2_v =-class_1_v;

Trainig_set=[Class_1;Class_2];
Trainig_classes=[class_1_v;class_2_v];
N=length(Trainig_classes);
for i=1:length(Trainig_classes)
    for j=i:length(Trainig_classes)
        distances_M(i,j)=norm((Trainig_set(i,:)-Trainig_set(j,:)));
    end
end

distances_M=distances_M+distances_M';


%%

clc
w= zeros(400,400);
for i=1:length(Trainig_classes)
    [~,K]=mink(distances_M(i,:),7);
    for j=1:length(K)
        w(i,K(j))=distances_M(i,K(j));
        w(K(j),i) =w(i,K(j));
    end
end
%w=distances_M;
%%
figure(2)


G = graph(w);
ww=Trainig_classes;
pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',ww);
colormap('jet');
pa.MarkerSize = 4;
pa.EdgeColor=[192,192,192]/255;
title('Non-separable Class gaph');


%%
    Gu = graph(w);
    Wgeos = distances(Gu);
    N =2*n;
    % Plot the graph
%         pa = plot(Gu,'XData',G.coords(:,1),'YData',G.coords(:,2));
%         pa.MarkerSize = 4;
%         pa.EdgeColor=[192,192,192]/255;
%         pa.NodeColor=[0,192,192]/255;
% 
%         
% %% Density vs Lambda

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
clc
density = [0.01 0.02 0.04 0.08 0.16];
PathL=[1.8324 1.2516 0.85075 0.55626 0.35175]; %incomplete
%PathL=[1.6301 1.1048 0.74938 0.5176]; %complete


%%
clc

M = mean(mean(distances_M));
dens=zeros(N,1);
for i=1:2*n
    dens(i) = length(find(distances_M(i,:)<M))/(2*n);
end

%%
clc
D=diag(sum(w,1));
L=D-w;
%%
clc
%clear all
%load('EXP_NS')
   %[I_VC,S_R] =  my_vc_Density_v00(Wgeos,PathL(1),density(1),dens);
    [I_VC,S_R] =  my_vc_v00(Wgeos,PathL(1),density(1));
%%
    pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)));
    pa.MarkerSize = 6;
    pa.EdgeColor=[192,192,192]/255;
    s1=I_VC;
    pa.MarkerSize =4+s1*2;
    pa.NodeColor=repmat(s1,[1,3]).*repmat([0,200,220]/255,[2*n,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[2*n,1]);
    name=['Density INITIAL pattern'];
    title(name,'FontSize',18)



%%
clc
clear SF PAT_D

Trainig_classes=Trainig_classes./norm(Trainig_classes);
[SF,sig,Pat_1,PAT_D,vec] = NVERSION(I_VC,PathL,L,Trainig_classes,Wgeos);

figure(2)
for i=1:4
    clear xx
    subplot(2,2,i)
    s1 = PAT_D(:,i);
    for ii=1:2*n
        if PAT_D(ii,i)==1
            xx(ii)= 4;
        else
            xx(ii) = Trainig_classes_p(ii);
        end
    end
    NUM=(length(nonzeros(PAT_D(:,i)))/(2*n));
    %G.Nodes.NodeColors = xx;
    pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
    pa.EdgeColor=[192,192,192]/255;
    colormap('jet');
    pa.MarkerSize =2+s1*2;
    name=['Density=',num2str(NUM)];
    title(name,'FontSize',12)
end
suptitle('Signal Reconstruction Method')
%%
figure(3)
for i=1:4
    clear xx
    subplot(2,2,i)
    s1 = Pat_1(:,i);
    for ii=1:2*n
        if Pat_1(ii,i)==1
            xx(ii)= 4;
        else
            xx(ii) = Trainig_classes_p(ii);
        end
    end
    NUM=(length(nonzeros(Pat_1(:,i)))/(2*n))
    %G.Nodes.NodeColors = xx;
    pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
    pa.EdgeColor=[192,192,192]/255;
    colormap('jet');
    pa.MarkerSize =2+s1*2;
    name=['Density=',num2str(NUM)];
    title(name,'FontSize',12)
end
suptitle('First POINTS')
%%

clc
[SF,sig,Pat] = Active_v01(I_VC,PathL,L,Trainig_classes,Wgeos,Trainig_set);

figure(1)
for i=1:4
    subplot(2,2,i)
    pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)));
    pa.MarkerSize = 6;
    pa.EdgeColor=[192,192,192]/255;
    s1=Pat (:,i);
    pa.MarkerSize =4+s1*2;
    pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,220]/255,[400,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[400,1]);
    name=['Density=',num2str(n)];
    title(name,'FontSize',18)
end


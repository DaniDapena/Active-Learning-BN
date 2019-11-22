
clc
clear all

load('POL_SEP')
clear class_1 class_2 distances_M
Trainig_classes_p=Trainig_classes;
for ii=1:2*n
    if Trainig_classes(ii)<0
        Trainig_classes_p(ii)=0;
    end
end
%%
clc
hh=length(PathL);
for cc=1:100
 
   Trainig_classes=Trainig_classes./norm(Trainig_classes);
   [I_VC,S_R] =  my_vc_v00(Wgeos,PathL(1),density(1));
%  [PAT_D(:,2),S_R] =  
my_vc_v00(Wgeos,PathL(2),density(2));
%  [PAT_D(:,3),S_R] =  my_vc_v00(Wgeos,PathL(3),density(3));
%  [PAT_D(:,4),S_R] =  my_vc_v00(Wgeos,PathL(4),density(4));
%
   [SF,sig,Pat_1,PAT_D] = ACTIVE_L_SVM_V00(I_VC,PathL,Trainig_classes,Wgeos,Trainig_set);

clc
figure(1)
    for i=1:hh
        clear xx
        subplot(2,3,i)
        s1 = PAT_D(:,i);
        for ii=1:2*n
            if PAT_D(ii,i)==1
                xx(ii)= 4;
            else
                xx(ii) = Trainig_classes_p(ii);
            end
        end
        NUM=(length(nonzeros(PAT_D(:,i)))/(2*n));
        pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
        pa.EdgeColor=[192,192,192]/255;
        colormap('jet');
        pa.MarkerSize =2+s1*2;
        name=['Density=',num2str(NUM)];
        title(name,'FontSize',12)
    end
    suptitle('Signal Reconstruction Method')
    clc;     
    figure (2)
    signal = Trainig_classes;
    data = Trainig_set;
    
    for jj=1:hh
        clear score
        SF = PAT_D(:,jj);
        [S,~,~]=find(SF);
        S=find(SF);
            T_set = data(S,:);
            Class_t = signal(S);
            newX = data;
            SVMModel = fitcsvm(T_set,Class_t);
            [Class,Score] = predict(SVMModel,newX);
            for i=1:2*n
                if Class(i)<0
                    score(i) = -Score(i,1);
                else
                    score(i) = Score(i,2);
                end
            end
 
            
            subplot(2,3,jj)
            xx =score;
            s1=xx;
            
            NUM=(length(nonzeros(PAT_D(:,jj)))/(2*n));
%             G.Nodes.NodeColors = xx;
            den(cc,jj)=NUM;
            pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
            pa.EdgeColor=[192,192,192]/255;
            colormap('jet');
            pa.MarkerSize =2;
            name=['Density=',num2str(NUM)];
            title(name,'FontSize',12)
            
            CLASSES= score;
            clear signal_reconstructed_1
            clear BWdn d_signal_1

            c=0;
       for i=1:2*n
          if Class(i)== Trainig_classes(i)
             c=c;
          else
             c=c+1;
          end
       end
       error (jj) = c/N;
    end
      error
      error_vec (cc,:)= error;
      cc
end
%%
clc
EE = sum(error_vec,1)/cc
average_density = sum(den,1)/cc
save('errors_density_SVM_BN','EE','average_density')
%%


    s1 = signal_reconstructed_1;
    xx=signal_reconstructed_1;
    %G.Nodes.NodeColors = xx;
    pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
    pa.EdgeColor=[192,192,192]/255;
    colormap('jet');
    pa.MarkerSize =4;
    name=['Density=',num2str(NUM)];
    title(name,'FontSize',12)
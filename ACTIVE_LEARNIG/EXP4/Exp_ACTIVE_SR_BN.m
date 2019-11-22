
clc
clear all

load('POL_SEP')
Trainig_classes_p=Trainig_classes;
for ii=1:2*n
    if Trainig_classes(ii)<0
        Trainig_classes_p(ii)=0;
    end
end
%%
clc
[V,~]=eigs(L,N,'sm');
%%
for cc=1:1
 
Trainig_classes=Trainig_classes./norm(Trainig_classes);
   [I_VC,S_R] =  my_vc_v00(Wgeos,PathL(1),density(1));
%  [PAT_D(:,2),S_R] =  my_vc_v00(Wgeos,PathL(2),density(2));
%  [PAT_D(:,3),S_R] =  my_vc_v00(Wgeos,PathL(3),density(3));
%  [PAT_D(:,4),S_R] =  my_vc_v00(Wgeos,PathL(4),density(4));
%
[SF,sig,Pat_1,PAT_D] = ACTIVE_L_V00(I_VC,PathL,L,Trainig_classes,Wgeos);
hh=length(PathL);
clc
figure(1)
    for i=1:hh
        clear xx
        subplot(2,3,i)
        s1 = PAT_D(:,i);
        for ii=1:2*n
            if PAT_D(ii,i)==1
                xx(ii)= 2;
            else
                xx(ii) = Trainig_classes_p(ii);
            end
        end
        NUM=(length(nonzeros(PAT_D(:,i)))/(2*n));
        pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
        pa.EdgeColor=[192,192,192]/255;
        colormap('jet');
        pa.MarkerSize =3+s1*2;
        name=['Density=',num2str(NUM)];
        title(name,'FontSize',12)
    end
    suptitle('Pattern: Signal Reconstruction Method')
    clc;     
    figure (2)
    signal = Trainig_classes;
    
    for jj=1:4
        SF = PAT_D(:,jj);
        [S,~,~]=find(SF);
        m=length(S);
        BWd=0.01*N/2;
        sampled_signal_1=signal(S); 
        Ms=zeros(m,N);
        for q=1:1:m
           Ms(q,S(q))=1; 
        end  
        clear q      
        signal_reconstructed_1=V(:,1:BWd)*pinv(Ms*V(:,1:BWd))*sampled_signal_1;
        clear Ms
            
            
            subplot(2,3,jj)
            xx =signal_reconstructed_1;
            s1=xx;
            NUM=(length(nonzeros(PAT_D(:,jj)))/(2*n));
            den(cc,jj)=NUM;
%             G.Nodes.NodeColors = xx;
            pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)),'NodeCData',xx);
            pa.EdgeColor=[192,192,192]/255;
            colormap('jet');
            pa.MarkerSize =2;
            name=['Density=',num2str(NUM)];
            title(name,'FontSize',12)
            
            CLASSES= signal_reconstructed_1;
           % clear signal_reconstructed_1
            clear BWd
            clear sampled_signal_1
       for i=1:2*n
            if CLASSES(i)<=0
               Class(i)=0;
            else
               Class(i)=1;
            end
       end
            c=0;
       for i=1:2*n
          if Class(i)== Trainig_classes_p(i)
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
EE = sum(error_vec,1)/cc
average_density = sum(den,1)/cc
save('errors_density_Signal_reconstrtuction','EE','average_density')

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

clc
clear all

load('Graph')
clear class_1 class_2 distances_M
Trainig_classes_p=Trainig_classes;
for ii=1:2*n
    if Trainig_classes(ii)==0
        Trainig_classes(ii)=-1;
    end
end
N=1000;

clc

signal = Trainig_classes;
data = Trainig_set;
dd=density;
    figure (2)

    for cc=1:200
        
        for jj=1:6
        ppp = randperm(2*n); 
        NS = ceil(N*dd(jj));
        S=ppp(1:NS);
        SF=zeros(N,1);
        SF (S)= 1;
        T_set = data(S,:);
        Class_t = signal(S);
        newX = data;
        SVMModel = fitcsvm(T_set,Class_t);
        [Class,Score] = predict(SVMModel,newX);
         if size(Score,2)>1
            for i=1:2*n
                if Class(i)<0
                    score(i) = -Score(i,1);
                else
                    score(i) = Score(i,2);
                end
            end
         else
             score=Score;
         end
             
 
            
        subplot(2,3,jj)
        xx =score;
        NUM=(length(nonzeros(SF))/(2*n));
            den(cc,jj)=NUM;
%             G.Nodes.NodeColors = xx;
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
       error (cc,jj) = c/N;
    end

      error_vec = error;
      cc
end

EE = sum(error_vec,1)/cc
average_density = sum(den,1)/cc
save('ER_RAND_SVM','EE','average_density')

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
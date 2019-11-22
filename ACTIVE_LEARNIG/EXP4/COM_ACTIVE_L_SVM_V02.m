
function [SF,] = COM_ACTIVE_L_SVM_V02(D,signal,data)
    
% This code implements a Active learning uncertanty using  SVM 
% SF is the final Set  IP is the initial pattern 
%R principal path length vector geo the matrix of geodesic distances and
%signal is the training classes
            
            N=length(signal);
            
            SI=randperm(N);
            S=SI(1:ceil(0.01*N));
            SF=zeros(N,1);
            T_set = data(S,:);
            Class = signal(S);
            newX = data;
            SF(S)=1;
            SVMModel = fitcsvm(T_set,Class);
            [~,Score] = predict(SVMModel,newX); 
            for i=1:N
                 score(i) = abs(Score(i,1));
            end

             rep=2;
             pp=zeros(N,length(D));
             pp(:,1)=SF;
             pp_1= zeros(N,length(D));
             pp_1(:,1)=SF;
             jj=1;
             vec(jj)=0;
             
         while  rep<=(length(D)) 
             
             count_1 = length(S);
             NS_1 =  ceil(D(rep)*N)-count_1;
             sr=score;
             count_2=1;
             Max_gain=sort(sr);
  
             while NS_1>0
                 pos = find(sr==Max_gain(count_2));
                 if length(pos)<NS_1
                     fp=length(pos);
                 else
                     fp = NS_1;
                 end
             
                 SF(pos(1:fp))=1;
                 SS = find(SF);
                 count_1 = length(SS);
                 NS_1 =  ceil(D(rep)*N)-count_1;
                 count_2=count_2+1;
             end
             clear count_2
             clear cout_1
                
            pp_1(:,rep)=SF;
            S = find(SF);
            rep = rep+1;
            T_set = data(S,:);
            Class = signal(S);
            SVMModel = fitcsvm(T_set,Class);
            SVMModel = fitcsvm(T_set,Class); 
            [~,Score] = predict(SVMModel,newX); 
            for i=1:N
                 score(i) = abs(Score(i,1));
            end


         end
end


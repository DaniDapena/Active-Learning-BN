function [SF,sr,pp,pp_1,vec] = COM_ACTIVE_L_SVM_V02(D,signal,data)
            
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
            os1=0;
                 pos = find(score==Max_gain(count_2));
                 SF(pos)=1;
                 
                 if length(pos==os1)==length(pos)
                     break;
                 end
           
                os_1=pos 
                
            pp_1(:,rep)=SF;
            S = find(SF);
            den=length(S)/N
            if den>=D(rep)
            rep = rep+1;
            end
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


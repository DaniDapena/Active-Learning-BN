function [SF] = ACTIVE_L_SVM_V00(IP,R,signal,geo,data)
% This code implemnts a Active learning uncertanty using  SVM and the path
% length constrain SF is the final Set  IP is the initial pattern R principal 
%path length vecor geo the matrux of geodesic distances and data is the
%training set %signal is the training classes
            

            N=length(IP);
            SF = IP;
            S=find(SF);
            T_set = data(S,:);
            Class = signal(S);
            newX = data;
            SVMModel = fitcsvm(T_set,Class);
            [~,Score] = predict(SVMModel,newX); 
            for i=1:N
                 score(i) = abs(Score(i,2));
            end


            rep=2;
             pp=zeros(N,length(R));
             pp(:,1)=SF;
             pp_1(:,1)=SF;
             contador = 2;
             jj=1;
             vec(jj)=0;
         while  rep<=length(R)
             sr=score;
             for i=1:length(S)
                dis =  geo(S(i),:); % distancias geodesicas del, punto en el patron 
                NP = find((dis>=(R(rep)))) ;% puntos a una distancia mayor a 2 veces el principal Wavelength
                if length(NP)>0    
                    [SS,~,~]=find(SF);
                    ss=abs(sr(NP)); %Valor de la senal en esos puntos
                    ss_1=sort(ss); % ordenal de menor a mayor
                    k=1; %contador de pocicion en la senal
                    pos=find(ss==ss_1(k)); %Encontrar el punto con valor mas cercano a cero                    
                    
                    Dis_pos = geo(NP(pos(1)),:);% geodesicas para la posiciom
                    ring = Dis_pos(SS); % geodesicas la pa posicion  a los puntos del patron
                    rr=(min(ring)<(R(rep))); % numero de puntos por debajo del Principal WL
                    while rr>0
                         k=k+1; %Actualizar contador P
                         if k> length(NP)
                             break;
                         end
                         pos=find(ss==ss_1(k)); % nueva pocision
                         Dis_pos = geo(NP(pos(1)),:);
                         ring = Dis_pos(SS);
                         rr=(min(ring)<(R(rep))); % numero de puntos por debajo del Principal WL
                         if (sr(S(i)))<(sr(NP(pos)))
                             rr=1;
                             break;
                         end
                    end
                    if rr==0
                        SF(NP(pos(1)))=1;
                        vec(jj)=NP(pos(1));
                        jj=jj+1;
                        pp(:,contador)=SF;
                        contador=contador+1;         
                    end 
                    clear pos
                    clear NP
                end
             end
            
            
             
         
            [S,~,~]=find(SF);
            
            S=find(SF);
            T_set = data(S,:);
            Class = signal(S);
            SVMModel = fitcsvm(T_set,Class);
            [~,Score] = predict(SVMModel,newX); 
            for i=1:N
                 score(i) = abs(Score(i,2));
            end
            pp_1(:,rep)=SF;
            rep=rep+1;
         end
         
            

end


function [SF] = ACTIVE_L_V00(IP,R,L,signal,geo)
% This code implemnts a Active learning uncertanty using  Signal recontruction 
%and the path length constrain SF is the final Set  IP is the initial pattern 
%R principal path length vector geo the matrux of geodesic distances 
%signal is the training classes
                        
            SF = IP;
            
            N=length(SF);
            [V,~]=eigs(L,N,'sm');

            [S,~,~]=find(SF);
            
            sampled_signal_1=signal(S); 
            m=length(S);
            bw = ceil(0.01*N/2);
            Ms=zeros(m,length(SF));
            for q=1:1:m
                Ms(q,S(q))=1; 
            end  
            clear q      
            signal_reconstructed_1=V(:,1:bw)*pinv(Ms*V(:,1:bw))*sampled_signal_1;
            clear Ms
            
            rep=2;
             pp=zeros(N,length(R));
             pp(:,1)=SF;
             pp_1(:,1)=SF;
             contador = 2;
             jj=1;
             vec(jj)=0;
         while  rep<=length(R)
             sr=signal_reconstructed_1;
             for i=1:length(S)
                dis =  geo(S(i),:); % distancias geodesicas del, punto en el patron 
                NP = find((dis>=(R(rep)))) ;% puntos a una distancia mayor a 2 veces el principal Wavelength
                if ~isempty(NP)    
                    [SS,~,~]=find(SF);
                    ss=abs(sr(NP)); %Valor de la senal en esos puntos
                    ss_1=sort(ss); % ordenal de menor a mayor
                    k=1; %contador de pocicion en la senal
                    pos=find(ss==ss_1(k)); %Encontrar el punto con valor mas cercano a cero 
%                    SF(NP(pos(1)))=1;
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
                         if abs(sr(S(i)))<=abs(sr(NP(pos)))
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
            
            
            sampled_signal_1=signal(S); 
            m=length(S);
            BWd=bw;
            Ms=zeros(m,length(SF));
            for q=1:1:m
                Ms(q,S(q))=1; 
            end  
            clear q      
            signal_reconstructed_1=V(:,1:BWd)*pinv(Ms*V(:,1:BWd))*sampled_signal_1;
            clear Ms
            pp_1(:,rep)=SF;
            rep=rep+1;
         end
         
            

end


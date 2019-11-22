function [SF,sr,pp,pp_1,vec] = ACTIVE_L_V00_D(IP,R,L,signal,geo,data,G,x,y)
            
            
            SF = IP;
            
            N=length(SF);
            [V,~]=eigs(L,N,'sm');

            [S,~,~]=find(SF);
            
            sampled_signal_1=signal(S); 
            m=length(S);
            bw = 0.01*N/2;
            Ms=zeros(m,length(SF));
            for q=1:1:m
                Ms(q,S(q))=1; 
            end  
            clear q      
            signal_reconstructed_1=V(:,1:bw)*pinv(Ms*V(:,1:bw))*sampled_signal_1;
            clear Ms
             %%%%%%%%%
             idx=1;
             
        Trainig_set=data;
        s1 = IP;
     
        pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)));
        pa.EdgeColor=[192,192,192]/255;
        colormap('jet');
        pa.MarkerSize =1+3*s1;
        pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,0]/255,[N,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[N,1]);
               title('Pattern','FontSize',12)           
        hold on 
        plot(x,y,'linewidth',2,'Color',[0.3010 0.7450 0.9330])
        centersBright=data(S,:);
        radiiBright(1:size(centersBright,1))=(R(2)-R(2)/3);
       H=viscircles(centersBright, radiiBright,'Color',[0.6440 0.240 0.760],'LineStyle','--','LineWidth',1); %%%%%%%%%%%%%%%%%%%%%

       
          
            rep=2;
             pp=zeros(N,length(R));
             pp(:,1)=SF;
             pp_1(:,1)=SF;
             contador = 2;
             jj=1;
             vec(jj)=0;
             fig=figure;
             Trainig_set=data;
        s1 = SF;
        pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)));
        pa.EdgeColor=[192,192,192]/255;
        colormap('jet');
        pa.MarkerSize =1+3*s1;
        pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,0]/255,[N,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[N,1]);
               title('Pattern','FontSize',12)           
        hold on 
        plot(x,y,'linewidth',2,'Color',[0.3010 0.7450 0.9330])
        centersBright=data(S,:);
        radiiBright(1:size(centersBright,1))=(R(2)-R(2)/3);
        PP=viscircles(centersBright, radiiBright,'Color',[0.6440 0.240 0.760],'LineStyle','--','LineWidth',1); %%%%%%%%%%%%%%%%%%%%%

         while  rep<=2
             fig=figure;
             Trainig_set=data;
        s1 = SF;
        pa = plot(G,'XData',(Trainig_set(:,1)),'YData',(Trainig_set(:,2)));
        pa.EdgeColor=[192,192,192]/255;
        colormap('jet');
        pa.MarkerSize =1+3*s1;
        pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,0]/255,[N,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[N,1]);
               title('Pattern','FontSize',12)           
        hold on 
        plot(x,y,'linewidth',2,'Color',[0.3010 0.7450 0.9330])
        centersBright=data(S,:);
        radiiBright(1:size(centersBright,1))=(R(2)-R(2)/3);
        PP=viscircles(centersBright, radiiBright,'Color',[0.6440 0.240 0.760],'LineStyle','--','LineWidth',1); %%%%%%%%%%%%%%%%%%%%%

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
                        clear centersBright radiiBright
                        centersBright=data(NP(pos(1)),:);
                        radiiBright(1:size(centersBright,1))=(R(rep)-R(rep)/3);
     
                        s1 = SF;
                        
                        drawnow limitrate
 
                        pause(3)
                        SF(NP(pos(1)))=1;
                        vec(jj)=NP(pos);
                        jj=jj+1;
                        pp(:,contador)=SF;
                        contador=contador+1;  
                          
                        %%%%%%%%%
        

        pause(3)
        s1 = (SF);
        pa.MarkerSize =1+3*s1;
        pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,0]/255,[N,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[N,1]);
        pa.MarkerSize =1+3*s1;
        title('Pattern','FontSize',12)           
        hold on 
         plot(x,y,'linewidth',2,'Color',[0.3010 0.7450 0.9330])
        pause(3)
        H=viscircles(centersBright, radiiBright,'Color',[0.6440 0.240 0.760],'LineStyle','--','LineWidth',1);
        
        idx=idx+1;
       
        %%%%%%%%%%%%%%%%%%%%%
            
                    end 
                    clear pos
                    clear NP
                end
             end
            
            
             
         if contador==3
            break
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


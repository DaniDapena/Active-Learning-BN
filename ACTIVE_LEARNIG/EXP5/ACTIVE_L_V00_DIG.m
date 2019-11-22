function [SF,sr,pp,pp_1,vec] = ACTIVE_L_V00_DIG(IP,R,L,signal,geo,data,G,x,y)
            
            
            
             %%%%%%%%%
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
                 

                    if rr==0
                        clear centersBright radiiBright
                        centersBright=data(NP(pos(1)),:);
                        radiiBright(1:size(centersBright,1))=(R(rep)-R(rep)/3);
     
                        s1 = SF;
                        
                        drawnow limitrate
 
                        
                        SF(NP(pos(1)))=1;
                        vec(jj)=NP(pos);
                        jj=jj+1;
                        pp(:,contador)=SF;
                        contador=contador+1;  
                          
                        %%%%%%%%%
        

        
        s1 = (SF);
        pa.MarkerSize =1+3*s1;
        pa.NodeColor=repmat(s1,[1,3]).*repmat([0,180,0]/255,[N,1])+repmat(1-s1,[1,3]).*repmat([180, 180, 180]/255,[N,1]);
        pa.MarkerSize =1+3*s1;
        title('Pattern','FontSize',12)           
        hold on 
         plot(x,y,'linewidth',2,'Color',[0.3010 0.7450 0.9330])
        
        H=viscircles(centersBright, radiiBright,'Color',[0.6440 0.240 0.760],'LineStyle','--','LineWidth',1);
        
        idx=idx+1;
       
        %%%%%%%%%%%%%%%%%%%%%
            
                    end 
                    clear pos
                    clear NP
                end
             end
            
            
  
            
         end
         


end


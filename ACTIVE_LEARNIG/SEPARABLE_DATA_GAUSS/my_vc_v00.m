function [S,S_in] = my_vc_v00(Geodesics,lambda,density_pattern)


% Geodesics matrix of geodesic distances
%lambda Principa path  length
% density_pattern density of the patter view as the number of selected
% nodes over the total number of nodes

% This algorithm uses the geodesic disctances to apply Void-And-Cluster
% algorithm over an undirected Graph  


    sigma=lambda^2/log(10); % parameter to adjust the Kernel
    K_0 = exp(-(Geodesics).^2/(sigma)); % Mapping of the geodesig distace using a Kernel

    N = max(size(Geodesics));
    Ind_A=-1;
    Ind_B=-1;

    initial_values = randperm(N);


    Number_of_samples = ceil(max(size(Geodesics))*density_pattern); % Number of selected nodes in the pattern


    S_0= zeros(N,1);
    
   
    S_0= zeros(N,1);
    
    [I] =randperm(size(Geodesics,1));
    
    S_0(I(1:Number_of_samples))=1;
    
    
    k= 10*max(sum(K_0));
    S_in = S_0;
    max_r=5*N;
    c=zeros(N,1);

    for r=1:max_r
        
        for i=1:N
            if S_0(i)==1
                c(i)=(K_0(i,:)*S_0)-1;
            else
                c(i)=(K_0(i,:)*S_0)-k;
            end
        end

    position_max = find(c == max(c));
    position_min = find(c == min(c));
    
      
    S_0(position_max(1)) = 0;
    S_0(position_min(1)) = 1;
    
    
        if Ind_A == max(c)&& Ind_B == min (c)
            break
        else
            Ind_A = min(c);
            Ind_B = max (c);
        end
  
    end
    
    S=S_0;
end
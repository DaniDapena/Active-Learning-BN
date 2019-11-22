function B = pointCloudVAC(A, g, D)

[M,N]=size(A);
if (M < N)
    A = A';
    [M,N]=size(A);
end;

plot(A(:,1), A(:,2), 'b.');
hold on;

if (nargin < 3)
    D = zeros(M,M);
    for n=1:N
        X = A(:,n) * ones(1,M);
        D = D + (X - X').^2;
    end;
    D = sqrt(D);
    D(find(D>0.10))=0;
    
    for m=1:M
        for n=1:M
            %if (D(m,n) > 0)
            %    plot(A([m n],1), A([m n],2),'r-');
            %end;
            w = max(A(m,1),A(n,1));
            D(m,n) = D(m,n) * (w+0.1);
        end;
    end;
    
    D(find(D>0)) = exp(-D(find(D>0)).^2/0.001);

    %%%% convert to KNN graph
%     for m=1:size(D,1)
%         [d,i] = sort(-D(m,:));
%         D(m,:) = 0;
%         D(m,i(1:5))=1;
%     end;
%     D = (D + D') > 0.5;
end;

% for m = 1:size(D,1)
%     xa = A(m,1);
%     for n = 1:size(D,2)
%         xb = A(n,1);
%         D(m,n) = D(m,n) * xa;
%     end;
% end;

G = round(g * M)
Cst = sum(D);
[a,l] = sort(Cst);
B = zeros(M,1);
%B(l(1:G)) = 1;
B(randperm(M,G)) = 1;

h = plot(A(find(B),1), A(find(B),2), 'ro');
indA = -1;
indB = -1;
optCost = 1e6;
for m=1:1000
    Cst(find( B)) = sum(D(find(B),find( B)));
    Cst(find(~B)) = sum(D(find(B),find(~B))) - 1000;

    %%% MAKE SURE WE ARE ITERATIVELY IMPROVING THE COST
    %%% OTHERWISE, THE ALGORITHM HAS CONVERGED
    if (sum(Cst(find(B))) < optCost)
        optCost = sum(Cst(find(B)));
    else
        break;
    end;
    
    a = find(Cst == max(Cst));
    a = a(randperm(length(a),1));
    b = find(Cst == min(Cst));
    b = b(randperm(length(b),1));

    B(a) = 0;
    B(b) = 1;
    
    delete(h);
    h = plot(A(find(B),1), A(find(B),2), 'ro');
    drawnow;

    if (indA == a & indB == b)
        break;
    else
        indA = b;
        indB = a;
    end;
end;
hold off;

return;

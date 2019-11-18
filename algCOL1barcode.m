function [R,V,I]=algCOL1barcode(D)
%Fattorizzazione R=D*V. 
%Dove:  
%R è la matrice ridotta di D;
%V è una matrice triangolare superiore invertibile;
%I contiene nelle prime due colonne gli intervalli non scomponibili e
%nell'ultima colonna il numero di simplessi nei cicli
n = size(D);
n = n(1,1);
R = D;
V = eye(n);
I = [0,0,0];
for j=1:n
    if max(R(1:n,j)) ~= 0
       i = find(R(1:n,j),1,"last");
       pivRj = R(i,j);
       k=1;
       while k<j && k~=0 
           
           if max(R(1:n,k)) ~= 0
              l = find(R(1:n,k),1,"last");
              
              if i == l
                 pivRk = R(l,k);
                 c = pivRj/pivRk;
                 
                 R(:,j) = R(:,j) - c*R(:,k);
                 V(:,j) = V(:,j) - c*V(:,k);
                 
                 i = find(R(1:n,j),1,"last");
                 pivRj = R(i,j);
                 k=1;
              else
                 k=k+1;
              end            
              
           else
              k=k+1;
           end

       end
    end
end


s=1;

for j=1:n
    [~,r] = max(abs(R(1:n,j)));
    pivot= R(r,j);
    if pivot ~= 0
       r0 = find(R(1:n,j),1,"last");
%       if q0 == 0
       [d1,~]=size(find(V(:,r)));
       I(s,:)=[r0,j,d1];
       s=s+1;
%       end
    else
       stop=0;
       for i=1:n
           r1 = find(R(1:n,i),1,"last");
           if r1==j
              break
           else
              stop=i+1;
           end
           if stop==n+1
              [d1,~]=size(find(V(:,j)));
              I(s,:)=[j,stop,d1];
              s=s+1;
           end
        end
    end
    
end    
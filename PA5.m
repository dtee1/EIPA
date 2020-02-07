% David Talson
% Student number: 101022690
% In this PA is about finite difference modeling of 2D harmonic wave

nx = 50;ny = 50;
G = sparse(nx*ny,ny*nx);

for a=1:nx
    
    for b=1:ny
        
        n = b + (a-1)*ny;
        
        if a==1||a==nx||b==1||b==ny
            G(n,:)=0;
            G(n,n)=1;
        else
        
        nxm = (a-2)*ny + b;
        nxp = a*ny + b;
        nym = (a-1)*ny + b-1;
        nyp = (a-1)*ny + b+1;       
        G(n, nxp) = 1;
        G(n, nxm) = 1;
        G(n,n) = -4; 
        
        if a > 10 & a < 20 & b > 10 & b < 20
            G(n,n) = -2;  
        end
        
        G(n, nyp) = 1; 
        G(n, nym) = 1;
        
        end
    end   
end

figure(1)
spy(G)

figure(2)
[E,D] = eigs(G,9,'SM');
plot(diag(D));
grid on

for a=1:nx
    for b=1:ny
        n = b + (a-1)*ny;
        for c=1:9
            sMap(a,b,c) = E(n,c);
        end
    end
end

for c=1:9
    figure;
    surf(sMap(:,:,c))
    title(append('Surface plot mode = ', num2str(c)));
end

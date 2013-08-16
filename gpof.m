%Reference:
%Yingbo Hua and Tapan K. Sarkar,
%Generalized Pencil-of-Function Method for Extracting Poles of an EM
%System from Its Transient Response,
%IEEE Trans. on Antennas and Propagation
%vol. 37, no. 2, 1989, pp. 229-234,
%
function [Bt, At]=gpof(f,t,M,L)
N=length(f);
if(t(1)~=0)
disp('t-vector must start at 0!')
return
end
if exist('L')==0
L=round(N/2);
disp(sprintf('Choosing default pencil parameter N/2=%d...',L));
end
if (M>=L)
disp(sprintf('Requested order %d is larger than pencil parameter %d',M,L))
M=L-1;
disp(sprintf('Choosing new order %d...',M))
end
if (L>N-M)
disp(sprintf('Number of support points too small for order %d',N))
return
end
Y1=zeros(N-L,L);
for rw=0:N-L-1
for cl=0:L-1
Y1(rw+1,cl+1)=f(rw+cl+1);
end
end
Y2=zeros(N-L,L);
for rw=1:N-L
for cl=0:L-1
Y2(rw,cl+1)=f(rw+cl+1);
end
end
[U, D, V]=svd(Y1);
invD=pinv(D);
Z=invD*U'*Y2*V;
Z=Z(1:M,1:M);
zitemp=eig(Z);
zi=zitemp(1:M);
rankdef=sum(zitemp==0);
if(rankdef~=0)
disp(sprintf('Order of approximation %d too high by %d (rank %d)', ...
M,rankdef,M-rankdef))
end
dt=(t(2)-t(1));
Bt=log(zi)/dt;
Zmat=zeros(M,N);
for rw=1:M
for cl=0:N-1
Zmat(rw,cl+1)=zi(rw)^cl;
end
end
At=(f*pinv(Zmat)).';
return
function S=Smatrix(vector)
if norm(vector,inf)<10^(-8)
    S=eye(size(vector,1));
else
    S=[vector';null(vector')'];
end
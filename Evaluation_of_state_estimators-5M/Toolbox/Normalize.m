function H=Normalize(X)
H=X.minHRep.H;
for i=1:size(H,1)
    H(i,:)=H(i,:)/norm(H(i,1:end-1));
end
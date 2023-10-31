function [val, p] = Support_func(X,v)
    vertice=X.minVRep.V;
    [p,~]=Select_vertice(vertice,v);
    val=p*v;
end

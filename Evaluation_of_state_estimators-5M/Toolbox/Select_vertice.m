function [p,ind]=Select_vertice(vertice,a_i)
value=vertice*a_i;
[~,ind]=max(value);
ind=ind(1);
p=vertice(ind,:);
end

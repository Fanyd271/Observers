function P=mRep(P)
try
    P = P.minVRep;
    P = P.minHRep;
catch ME
    if (strcmp(ME.message,'CDD returned an error, see above(!) for details'))
        disp(['CDD can not handle the polyhedron with ',...
            num2str(size(P.V,1)),' vertices']);
    else
        rethrow(ME);
    end
end
end
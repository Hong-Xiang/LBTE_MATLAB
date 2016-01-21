function v = n3D22D( x )
    v = sum(x,3);
    sumv = sum(v(:));
    if sumv > 0
        v = v / sumv;
        v = v / max(v(:));
    end
end


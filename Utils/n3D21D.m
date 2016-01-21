function v = n3D21D( x )
    v = sum(n3D22D(x),2);
    sumv = sum(v(:));
    if sumv > 0
        v = v / sumv;
        v = v / max(v(:));
    end
    
end


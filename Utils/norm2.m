function v = norm2(d)
    d2 = d.^2;
    v = sum(d2(:));
    v = sqrt(v);
end
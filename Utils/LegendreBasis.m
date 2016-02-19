function p = LegendreBasis(l, x)
    p = legendre(l, x);
    p = p(1,:);
    p = sqrt(l+1/2)*p;
    p = reshape(p, numel(p), 1);
end


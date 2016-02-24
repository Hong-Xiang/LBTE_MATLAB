function n = NormalizedAssociatedLegendrePolynomails(l, m, x)
    n = legendre(l,x,'norm');
    n = n(abs(m)+1,:);
    
    n = legendre(l, x);
    if m < 0
        m = -m;
    end
    n = n(m+1, :);
    n = (-1)^m*sqrt((l+1/2)*factorial(l-m)/factorial(l+m))*n;
    n = reshape(n, numel(n), 1);
end


function v = LegendrePoly(l, m, x)
    [h, w] = size(x);
    x = reshape(x, 1, h*w);
    v = legendre(l,x);    
    v = v(abs(m)+1,:);  
    v = squeeze(v);
    v = reshape(v,h,w);
    if (m<0)
        m = -m;
        v = (-1)^m * factorial(l-m)/factorial(l+m)*v;
    end
%     v = v * sqrt(2);
end
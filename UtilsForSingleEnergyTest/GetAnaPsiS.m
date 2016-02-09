function psi = GetAnaPsiS(p, x, y, z, mu, xi, eta)
found = 0;
if p.testAnaCase == 1
    found = 1;
    psi = ones(size(x));
end
if p.testAnaCase == 2
    found = 1;
    psi = x.^2;
end
if p.testAnaCase == 3
    found = 1;
   psi = (x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz).^2;
end
if p.testAnaCase == 4
    found = 1;
    r = (x.^2 + y.^2 + z.^2).^1/2;
    psi = exp(-p.maxsigmaa*r);
end
if p.testAnaCase == 5
    found = 1;
    psi = exp(-p.maxsigmaa*x);
end
if p.testAnaCase == 6
    found = 1;
    Ylmf = p.Ylm(ilm(1,3),:);
    Ylmf = Ylmf';
    if(size(x,3) > 1)
        Ylmm = repmat(Ylmf, 1, size(x,2), size(x,3));
    else
        Ylmm = repmat(Ylmf, 1, size(x,2));
    end
    psi = exp(-p.maxsigmaa*x).*Ylmm;    
end
assert(found == 1,'Unknown id of analytical solution');
end


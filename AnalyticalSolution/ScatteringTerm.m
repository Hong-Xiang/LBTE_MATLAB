function sca = ScatteringTerm(p, x, y, z, mu, xi, eta, e)
%     sca = integral(@(s) HG_sigmas(p, s).*HG_dsigmasde(p,s,e), e, p.se)*AnalyticalSolution(p, x, y, z, mu, xi, eta, e);
found = 0;
if p.testAnaCase == 1
    found = 1;
    sca = HG_sigmas(p,e)*2*e.*(1/e-1/p.se)*ones(size(x));
end
if p.testAnaCase == 2
    found = 1;
    sca = HG_sigmas(p,e)*2*e.*(1/e-1/p.se)*x.^2;
end
if p.testAnaCase == 3
    found = 1;
    sca = HG_sigmas(p,e)*2*e.*(1/e-1/p.se)*(x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz).^2;
end
if p.testAnaCase == 4
    found = 1;
    r = (x.^2 + y.^2 + z.^2).^1/2;
    sca = HG_sigmas(p,e)*2*e.*(1/e-1/p.se)*exp(-p.maxsigmaa*r);
end
if p.testAnaCase == 5
    found = 1;
    sca = HG_sigmas(p,e)*2*e.*(1/e-1/p.se)*exp(-p.maxsigmaa*x);
end
end


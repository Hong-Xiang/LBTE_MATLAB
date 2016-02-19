function sor = SourceTerm(p, x, y, z, mu, xi, eta, e)
    st = HG_sigmaa(p,e)+HG_sigmas(p,e);
    tra = TransportTerm(p, x, y, z, mu, xi, eta, e);
%     tra = 2*mu.*x;
    ana = AnalyticalSolution(p, x, y, z, mu, xi, eta, e);
    sca = ScatteringTerm(p, x, y, z, mu, xi, eta, e);
%     sca=HG_sigmas(p,e)*2*e.*(p.se-e);
    sor =  tra + st*ana - sca;    
%     plot(1:p.nx, n3D21D(GetFlux3D(p,r)));
%     sor = 2*mu.*x+st*x.^2-HG_sigmas(p,e)*2*e.*(1/e-1/p.se).*x.^2;
end


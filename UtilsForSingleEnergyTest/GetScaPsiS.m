function sca = GetScaPsiS(p, x, y, z, mu, xi, eta)
%     sca = integral(@(s) HG_sigmas(p, s).*HG_dsigmasde(p,s,e), e, p.se)*AnalyticalSolution(p, x, y, z, mu, xi, eta, e);
found = 0;
if p.testAnaCase > 0 && p.testAnaCase <= 5
    found = 1;
    sca = p.sigmasS*GetAnaPsiS(p, x, y, z, mu, xi, eta);
end
if p.testAnaCase == 6
    cost = p.ang*p.ang';    
    scam = HG(p.gS,cost)/2/pi*p.w;
    sca = p.sigmasS*scam*GetAnaPsiS(p, x, y, z, mu, xi, eta);
end
end


function v = HG_07(mu)
    g = 0.7;
    gsq = g.^2;
    t1 = 2*g.*mu;
    tmp = (1+gsq-t1);
    t3 = tmp.*tmp.*tmp;
    t3 = sqrt(t3);
    v = 1/2 * (1-gsq)./t3;
%     v = v*2;
end


function e = EnergyGrid(ne, emin, emax)
er = emax - emin;
em = emin;
Nlevel = 10;
e = [];
epre = em;
de = er/(2^Nlevel-1);
for i = 1 : Nlevel
    te = linspace(epre, epre+de, ceil(ne/Nlevel)+1);
    if i == 1
        e = [e,te];
    else
        e = [e, te(2:end)];
    end
    epre = te(end);
    de = de*2;
end

% e1 = linspace(em + er/2, em + er, ceil(ne/4)+1);
% e2 = linspace(em + er/4, em + er/2, ceil(ne/4)+1);
% e3 = linspace(em + er/8, em + er/4, ceil(ne/4)+1);
% e4 = linspace(em, em + er/8, ceil(ne/4)+1);
% e = [e4, e3(2:end), e2(2:end), e1(2:end)];
%     e0 = linspace(emin,emax,2*ne);
%     e = zeros(ne+1,1);
%     for i = 1 : ne
%         e(i) = e0(2*i-1);
%     end
%     e(ne+1) = emax + (emax-emin)/ne/2;
end


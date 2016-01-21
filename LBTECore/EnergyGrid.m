function e = EnergyGrid(ne, emin, emax)
    e = linspace(emin, emax, ne+1);
%     e0 = linspace(emin,emax,2*ne);    
%     e = zeros(ne+1,1);
%     for i = 1 : ne
%         e(i) = e0(2*i-1);
%     end
%     e(ne+1) = emax + (emax-emin)/ne/2;
end


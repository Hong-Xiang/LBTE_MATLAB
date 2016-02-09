function philm = SolverSHFEMSingleEnergy(p, sor, sigmal, sigmat, bx0, bx1, by0, by1, bz0, bz1)
philm = zeros(p.nlm,p.ncell);
% psi = GetGroupTerm(p, @AnalyticalSolution, p.x, p.y, p.z, p.mu, p.xi, p.eta, p.energy(1), p.energy(2));
% philm = p.Ylm * p.w * psi;
looped = 0;
pcpp = struct;
pcpp.na = p.na;
pcpp.nx = p.nx;
pcpp.ny = p.ny;
pcpp.nz = p.nz;
pcpp.hx = p.dx;
pcpp.hy = p.dy;
pcpp.hz = p.dz;

time0 = tic;
tpre = cputime;
phinow = zeros(p.na, p.ncell);
while looped < p.nI
    sca = 2 * p.Ylm' * sigmal * philm;
    sor_all = sca + sor;
    pcpp.sigmat =  sigmat;        
    Transport_mex(pcpp, phinow, sor_all, p.ang', bx0, bx1, by0, by1, bz0, bz1);
    philm = p.Ylm*p.w*phinow;    
    
    looped = looped + 1;    
    timecost = toc(time0);
    complete = looped/p.nI;
    timeremain = timecost/complete*(1-complete);
    tnow = cputime;
    if tnow - tpre > 1
        disp([' i= ',num2str(looped),' tc= ',num2str(timecost),' tr= ', num2str(timeremain)]);
        tpre = tnow;
    end
end

end


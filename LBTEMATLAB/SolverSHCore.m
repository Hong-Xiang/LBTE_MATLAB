function phiall= SolverSHCore(para)
disp('Using LBTE - FEMSH Solver......');

phiall = cell(para.ne,1);
for i = 1 : para.ne
    phiall{i} = zeros(para.nlm,para.ncell);
%     phiall{i} = para.Ylm*para.w*GetGroupTerm(para, @AnalyticalSolution, para.x, para.y, para.z, para.mu, para.xi, para.eta, para.energy(i), para.energy(i+1));
end

paracpp = struct;
paracpp.na = para.na;
paracpp.nx = para.nx;
paracpp.ny = para.ny;
paracpp.nz = para.nz;
paracpp.hx = para.dx;
paracpp.hy = para.dy;
paracpp.hz = para.dz;

display('Start source iteration');
time0 = tic;
tpre = cputime;

for ie1 = para.ne : -1 :1
    el = para.energy(ie1);
    eh = para.energy(ie1+1);
    looped = 0;
    source0 = GetSource(para, el, eh);
    [bx0, bx1, by0, by1, bz0, bz1] = GetBoundary(para, el, eh);
    source1 = zeros(para.nlm, para.ncell);
    for ie2 = ie1+1 : para.ne       
        source1 = para.slg{ie2,ie1} * phiall{ie2};
    end    
    while looped < para.nI        
        sourcescal = para.slg{ie1,ie1} * phiall{ie1} + source1;
        sourcesca = para.Ylm'*sourcescal;
        phinow = para.Ylm'*phiall{ie1};        
        sourcenow = source0+sourcesca;
        paracpp.sigmat =  para.txg(ie1);
        
        Transport_mex(paracpp, phinow, sourcenow, para.ang', bx0, bx1, by0, by1, bz0, bz1);
        phiall{ie1} = para.Ylm*para.w*phinow;
        
        looped = looped + 1;
        
        timecost = toc(time0);
        complete = ((para.ne-ie1)*para.nI+looped)/(para.nI*para.ne);
        timeremain = timecost/complete*(1-complete);
        tnow = cputime;
        if tnow - tpre > 1
            disp(['eg= ', num2str(ie1), ' i= ',num2str(looped),' tc= ',num2str(timecost),' tr= ', num2str(timeremain)]);
            tpre = tnow;
        end        
    end
end

for ie = 1 : para.ne
    phiall{ie} = para.Ylm'*phiall{ie};
end
end

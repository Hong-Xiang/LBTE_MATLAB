clear
p = Parameters;
el = p.energy(1);
eh = p.energy(2);
em = (el+eh)/2;

sigmal = p.slg{1,1};

bx0 = AnalyticalSolution(p,-p.hx*ones(size(p.bxy)),p.bxy,p.bxz);
bx1 = AnalyticalSolution(p, p.hx*ones(size(p.bxy)),p.bxy,p.bxz);
by0 = AnalyticalSolution(p,p.byx,-p.hy*ones(size(p.byx)),p.byz);
by1 = AnalyticalSolution(p,p.byx, p.hy*ones(size(p.byx)),p.byz);
bz0 = AnalyticalSolution(p,p.bzx,p.bzy,-p.hz*ones(size(p.bzx)));
bz1 = AnalyticalSolution(p,p.bzx,p.bzy, p.hz*ones(size(p.bzx)));
ana = AnalyticalSolution(p,p.x,p.y,p.z,p.mu,p.xi,p.eta,em);
tra = TransportTerm(p,p.x,p.y,p.z,p.mu,p.xi,p.eta,em);
sca = ScatteringTerm(p,p.x,p.y,p.z,p.mu,p.xi,p.eta,em);

sor = SourceTerm(p,p.x,p.y,p.z,p.mu,p.xi,p.eta,em);
r = tra+(HG_sigmaa(p,em)+HG_sigmas(p,em))*ana-sca-sor;
% sor = tra + (p.maxsigmas+p.maxsigmaa)*ana - sca;


pcpp = struct;
pcpp.na = p.na;
pcpp.nx = p.nx;
pcpp.ny = p.ny;
pcpp.nz = p.nz;
pcpp.hx = p.dx;
pcpp.hy = p.dy;
pcpp.hz = p.dz;
pcpp.sigmat = p.txg(1);

phinow = zeros(p.na, p.ncell);
Transport_mex(pcpp, phinow, sor + sca, p.ang', bx0, bx1, by0, by1, bz0, bz1);


LHS = GetFlux3D(p, phinow);
RHS = GetFlux3D(p, ana);
% LHS = GetFlux3D(p,sca_a);
% RHS = GetFlux3D(p,sca_c);
plot(1:p.nx,n3D21D(LHS), 1:p.nx, n3D21D(RHS),'+');


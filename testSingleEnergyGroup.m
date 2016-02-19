clear
p = Parameters;
el = p.energy(1);
eh = p.energy(2);

sigmal = p.slg{1,1};
sor = GetSource(p,el,eh);
[bx0, bx1, by0, by1, bz0, bz1] = GetBoundary(p, el, eh);
trag = GetGroupTerm(p,@TransportTerm,p.x,p.y,p.z,p.mu,p.xi,p.eta,el,eh);
phia = GetGroupTerm(p,@AnalyticalSolution,p.x,p.y,p.z,p.mu,p.xi,p.eta,el,eh);

philm = SolverSHFEMSingleEnergy(p, sor, sigmal, p.txg(1), bx0, bx1, by0, by1, bz0, bz1);

% phi = p.Ylm'*philm;
% phia3 = GetFlux3D(p,phia);

% philm = p.Ylm * p.w* phia;
% % % sca = sigmal * philm;
% 
% sca_a = GetGroupTerm(p,@ScatteringTerm,p.x,p.y,p.z,p.mu,p.xi,p.eta,el,eh);
% sca_c = p.Ylm'*sigmal*p.Ylm*p.w*phia;
% % sca2 = integral(@(x) 2*x.*(1./x-1/p.se), el, eh)*HG_sigmas(p,(eh+el)/2).*p.x.^2;
% pcpp = struct;
% pcpp.na = p.na;
% pcpp.nx = p.nx;
% pcpp.ny = p.ny;
% pcpp.nz = p.nz;
% pcpp.hx = p.dx;
% pcpp.hy = p.dy;
% pcpp.hz = p.dz;
% pcpp.sigmat = p.txg(1);
% % phinow = zeros(p.na, p.ncell);
% phinow = phia;
% 
% Transport_mex(pcpp, phinow, sor+sca_a , p.ang', bx0, bx1, by0, by1, bz0, bz1);
% plot(1:p.nx, n3D21D(GetFlux3D(p,sor)));

LHS = GetFlux3D(p, p.Ylm'*philm);
% LHS = GetFlux3D(p,phinow);
RHS = GetFlux3D(p, phia);
% LHS = GetFlux3D(p,sca_a);
% RHS = GetFlux3D(p,sca_c);
plot(1:p.nx,n3D21D(LHS), 1:p.nx, n3D21D(RHS),'+');

% r = trag + p.txg(1)*phia - sca2 - sor;
% plot(1:p.nx,n3D21D(GetFlux3D(p,r)));


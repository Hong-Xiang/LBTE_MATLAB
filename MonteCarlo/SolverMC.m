function phi = SolverMC(p)
disp('Calculating dose deposit using In-house Monte Carlo Solver');
tic
N = p.nRun;
hx = p.hx;
hy = p.hy; 
hz = p.hz; 
nx = p.nx;
ny = p.ny;
nz = p.nz;
e0 = p.mine;
e1 = p.maxe;
sigmaa0 = p.minsigmaa;
sigmaa1 = p.maxsigmaa;
sigmas0 = p.minsigmas;
sigmas1 = p.maxsigmas;
g0 = p.ming;
g1 = p.maxg;
alpha = p.ealpha;
spx = p.spx;
spy = p.spy;
spz = p.spz;
ssx = p.ssx;
ssy = p.ssy;
ssz = p.ssz;
sdx = p.sdx;
sdy = p.sdy;
sdz = p.sdz;
isISO = p.isSourceISO;
se = p.se; 
sse = p.sse;
ecut = p.ecut;
phi = RunMC_mex(N, hx, hy, hz, ecut, nx, ny, nz, e0, e1, sigmaa0, sigmaa1, sigmas0, sigmas1, g0, g1, alpha, spx, spy, spz, ssx, ssy, ssz, sdx, sdy, sdz, isISO, se, sse);
toc
end


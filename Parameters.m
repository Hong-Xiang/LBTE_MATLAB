function p = Parameters()
%
p = struct;
p.testname = 'Ana-LBTE-Test';
p.outputFileName = [p.testname,'.mat'];

p.testAnaCase = 0;

% Space
p.hx = 10; p.hy = 10; p.hz = 10;

% For mesh
p.nx = 45; p.ny = 45; p.nz = 45;


% Source 
p.isSourceISO = 0;
xtmp = -p.hx + p.hx/p.nx : p.hx*2/p.nx : p.hx - p.hx/p.nx;
nx = numel(xtmp);
if p.isSourceISO == 1
    vp = xtmp(ceil(nx/2));
    p.spx = vp; p.spy = vp; p.spz = vp;
else
    vp0 = xtmp(ceil(nx/3));
    vp1 = xtmp(ceil(nx/2));
    p.spx = vp0; p.spy = vp1; p.spz = vp1;
end


p.ssx = p.hx/p.nx; p.ssy = p.hy/p.ny; p.ssz = p.hz/p.nz;

% p.spx = 0; p.spy = 0; p.spz = 0;
% p.ssx = 0; p.ssy = 0; p.ssz = 0;


p.sdx = 1; p.sdy = 0; p.sdz = 0;

% p.ismonoEnergy = 0;

p.se = 10; p.sse = 0; 

p.ecut = 0;




% For MC
p.nRun = 1e6;
p.randseed = 1;

% For LBTE
p.ne = 40;  % Number of energy groups
p.nao = 12;    % Order of FEM angular scheme
p.nso = 8;     % Order of SH scheme
p.nI = 1000;    % Number of Iterations
p.nIntO = 10; % Number of nodes for integral

%===Process================================================================
% For HG
p.maxg = 0.5;
p.ming = 0.5;
p.maxsigmaa = 0.1;
p.minsigmaa = 0.1;
p.maxsigmas = 3;
p.minsigmas = 3;
p.mine = 0.01;
p.maxe = 10.01;
p.cute = 0.01;
p.ealpha = 0;



%====Contrcut Mesh=========================================================
%Finite Element Angular Mesh
scheme = FEMAngularGrid(p.nao);
p.na = scheme.order; p.ang = scheme.ang; p.w = scheme.w;
clear scheme;

%Shprical Harmonic Mesh
p.L = p.nso;
[nlm, Ylm] = SphericalScheme(p.L, p.ang');
p.nlm = nlm;
p.Ylm = Ylm;
clear nlm Ylm;

%Energy Mesh
p.energy = EnergyGrid(p.ne, p.mine, p.maxe);


%x, y, z, mu, xi, eta value of na*ncell body
p.dx = p.hx*2/p.nx; p.dy = p.hy*2/p.ny; p.dz = p.hz*2/p.nz;
p.xv = -p.hx + p.dx/2 : p.dx : p.hx - p.dx/2;
p.yv = -p.hy + p.dy/2 : p.dy : p.hy - p.dy/2;
p.zv = -p.hz + p.dz/2 : p.dz : p.hz - p.dz/2;
[x3d, y3d, z3d] = ndgrid(p.xv,p.yv,p.zv);
p.ncell = p.nx*p.ny*p.nz;
p.ncellh = (p.nx*2+1)*(p.ny*2+1)*(p.nz*2+1);
x1d = reshape(x3d,1,p.ncell);
y1d = reshape(y3d,1,p.ncell);
z1d = reshape(z3d,1,p.ncell);
p.x = repmat(x1d,p.na,1);
p.y = repmat(y1d,p.na,1);
p.z = repmat(z1d,p.na,1);
p.mu = repmat(p.ang(:,1),1,p.ncell);
p.xi = repmat(p.ang(:,2),1,p.ncell);
p.eta = repmat(p.ang(:,3),1,p.ncell);


%x, y, z, mu, xi, eta value of na*nx*ny, na*nz*nx or na*nx*ny boundary
ix = 1 : p.nx;
iy = 1 : p.ny;
iz = 1 : p.nz;
ia = 1 : p.na;

[ibxa, ibxy, ibxz] = ndgrid(ia, iy, iz);
p.bxmu = p.ang(ibxa,1);
p.bxxi = p.ang(ibxa,2);
p.bxeta = p.ang(ibxa,3);
p.bxy = p.yv(ibxy);
p.bxz = p.zv(ibxz);

[ibya, ibyz, ibyx] = ndgrid(ia, iz, ix);
p.bymu = p.ang(ibya,1);
p.byxi = p.ang(ibya,2);
p.byeta = p.ang(ibya,3);
p.byz = p.zv(ibyz);
p.byx = p.xv(ibyx);

[ibza, ibxy, ibxz] = ndgrid(ia, ix, iy);
p.bzmu = p.ang(ibza,1);
p.bzxi = p.ang(ibza,2);
p.bzeta = p.ang(ibza,3);
p.bzx = p.xv(ibxy);
p.bzy = p.yv(ibxz);


%====Calculate Grouped Cross Sections======================================
p.txg = zeros(p.ne,1);
p.dxg = zeros(p.ne,1);
p.slg = cell(p.ne);

for ie = 1 : p.ne
    p.txg(ie) = GetGroupTotalCrossSection(p, p.energy(ie), p.energy(ie+1));
    p.dxg(ie) = GetGroupEnergyDepositCrossSection(p, p.energy(ie), p.energy(ie+1));
end

for ies = 1 : p.ne
    for iet = 1 : p.ne
        p.slg{ies, iet} = SetScatteringMatrixHGSH(p, p.energy(iet), p.energy(iet+1), p.energy(ies), p.energy(ies+1));
    end
end
end


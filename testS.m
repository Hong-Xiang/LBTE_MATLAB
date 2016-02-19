p = Parameters;
p.sigmaaS = (p.minsigmaa+p.maxsigmaa)/2;
p.sigmasS = (p.minsigmas+p.maxsigmas)/2;
p.sigmatS = p.sigmaaS + p.sigmasS;
p.gS = (p.ming+p.maxg)/2;
[bx0, bx1, by0, by1, bz0, bz1] = GetBndPsiS(p);
slg = zeros(p.nso+1);
for l = 0 : p.nso
    for m = -l : l
        slg(ilm(l,m),ilm(l,m)) = p.sigmasS*p.gS^l;
    end
end
sor = GetSourceS(p, p.x, p.y, p.z, p.mu, p.xi, p.eta);
Psic = SolverSHFEMSingleEnergy(p, sor, slg, p.sigmatS, bx0, bx1, by0, by1, bz0, bz1);
PsiMC = RunMCSingle_mex(p.nRun, p.hx, p.hy, p.hz, p.nx, p.ny, p.nz, p.sigmaaS, p.sigmasS, p.gS, p.spx, p.spy, p.spz, p.ssx, p.ssy, p.ssz, p.sdx, p.sdy, p.sdz, p.isSourceISO);

Psic = p.Ylm'*Psic;
% p.testAnaCase = 4;
% Psia = GetAnaPsiS(p, p.x, p.y, p.z, p.mu, p.xi, p.eta);

PsiC3 = GetFlux3D(p, Psic);
% PsiA3 = GetFlux3D(p, Psia);

plot(1:p.nx, n3D21D(PsiC3),1:p.nx, n3D21D(PsiMC),'+');
legend('LBTE','MC');
% plot(1:p.nx, n3D21D(PsiMC), 1:p.nx, n3D21D(PsiC3),'+',1:p.nx, n3D21D(PsiA3));
% legend('MC','LBTE','Ana');

% dLBTEn = PsiC3(:,23,23);
% dMCn = PsiMC(:,23,23);
% tx = 1 : 45;
% dLBTEn = dLBTEn/sum(dLBTEn);
% dMCn = dMCn/sum(dMCn);
% plot(tx, dLBTEn, tx, dMCn);
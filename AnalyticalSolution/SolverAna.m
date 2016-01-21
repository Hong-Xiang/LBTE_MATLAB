function dose = SolverAna(p)
disp('Calculating angular flux using analytical solver.');
tic
psi = cell(p.ne,1);
for ie = 1 : p.ne        
    psi{ie} = GetGroupTerm(p, @AnalyticalSolution, p.x, p.y, p.z, p.mu, p.xi, p.eta, p.energy(ie), p.energy(ie+1));
end
toc
dose = GetDose(p,psi,p.dxg);
end
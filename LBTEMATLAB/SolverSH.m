function dose = SolverSH(p)
    phig = SolverSHCore(p);
    dose = GetDose(p,phig,p.dxg);
end


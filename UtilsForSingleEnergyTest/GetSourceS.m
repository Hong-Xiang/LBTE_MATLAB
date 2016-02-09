function sor = GetSourceS(p, x, y, z, mu, xi, eta)
if  p.testAnaCase == 0
    sor = zeros(p.na,p.nx*p.ny*p.nz);    
    ix = findId(p.spx,p.xv);
    iy = findId(p.spy,p.yv);
    iz = findId(p.spz,p.zv);
    
    ids = id3d2id1d(ix,iy,iz,p.nx,p.ny,p.nz);
    if p.isSourceISO == 1
        sor(:,ids) = 1;
    else
        ia = findId([p.sdx;p.sdy;p.sdz],p.ang');
        sor(ia,ids) = 1;
    end
    
else
    tra = GetTraPsiS(p, x, y, z, mu, xi, eta);
    ana = GetAnaPsiS(p, x, y, z, mu, xi, eta);
    sca = GetScaPsiS(p, x, y, z, mu, xi, eta);
    sor =  tra + p.sigmatS*ana - sca;
end
end


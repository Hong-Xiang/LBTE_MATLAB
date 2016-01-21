function psi3 = GetFlux3D(p, psi2)
onel = ones(p.na,1);
psit = onel'*p.w*psi2;
psi3 = zeros(p.nx, p.ny, p.nz);
for ix = 1 : p.nx
    for iy = 1 : p.ny
        for iz = 1 : p.nz
            psi3(ix,iy,iz) = psi3(ix,iy,iz) + psit(ix+p.nx*(iy-1+p.ny*(iz-1)));
        end
    end
end
end


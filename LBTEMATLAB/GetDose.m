function dose = GetDose(para, phig, dg)
display('Start summation');
tic
dose = zeros(para.nx, para.ny, para.nz);
onel = ones(para.na,1);
for ie = 1 : para.ne
    phiv = onel'*para.w*phig{ie};    
    for ix = 1 : para.nx
        for iy = 1 : para.ny
            for iz = 1 : para.nz
                dose(ix,iy,iz) = dose(ix,iy,iz) + phiv(ix+para.nx*(iy-1+para.ny*(iz-1)))*dg(ie);
            end
        end
    end
end
toc
end


function psi = GetTraPsiS(p, x, y, z, mu, xi, eta)
psix = (GetAnaPsiS(p,x+p.dx/2,y,z,mu,xi,eta)-GetAnaPsiS(p,x-p.dx/2,y,z,mu,xi,eta))/p.dx;
psiy = (GetAnaPsiS(p,x,y+p.dy/2,z,mu,xi,eta)-GetAnaPsiS(p,x,y-p.dy/2,z,mu,xi,eta))/p.dy;
psiz = (GetAnaPsiS(p,x,y,z+p.dz/2,mu,xi,eta)-GetAnaPsiS(p,x,y,z-p.dz/2,mu,xi,eta))/p.dz;
psi = psix.*mu+psiy.*xi+psiz.*eta;
end


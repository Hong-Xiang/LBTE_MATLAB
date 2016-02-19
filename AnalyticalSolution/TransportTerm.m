function psi = TransportTerm(p, x, y, z, mu, xi, eta, e)
psix = (AnalyticalSolution(p,x+p.dx/2,y,z,mu,xi,eta,e)-AnalyticalSolution(p,x-p.dx/2,y,z,mu,xi,eta,e))/p.dx;
psiy = (AnalyticalSolution(p,x,y+p.dy/2,z,mu,xi,eta,e)-AnalyticalSolution(p,x,y-p.dy/2,z,mu,xi,eta,e))/p.dy;
psiz = (AnalyticalSolution(p,x,y,z+p.dz/2,mu,xi,eta,e)-AnalyticalSolution(p,x,y,z-p.dz/2,mu,xi,eta,e))/p.dz;
psi = psix.*mu+psiy.*xi+psiz.*eta;

% found = 0;
% if p.testAnaCase == 2
%     found = 1;
%     psi = 2*mu.*x;
% end
% if p.testAnaCase == 2
%     r = (x.^2 + y.^2 + z.^2).^1/2;
%     psi = exp(-p.maxsigmaa*r);
% end
% if p.testAnaCase == 3
%     found = 1;
%     psi = zeros(size(x));
%     psi = psi + 2*(x-p.hx).*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz).^2;
%     psi = psi + 2*(x-p.hx).^2.*(x+p.hx).*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz).^2;
%     psi = psi + 2*(x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz).^2;
%     psi = psi + 2*(x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).*(z-p.hz).^2.*(z+p.hz).^2;
%     psi = psi + 2*(x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).*(z+p.hz).^2;
%     psi = psi + 2*(x-p.hx).^2.*(x+p.hx).^2.*(y-p.hy).^2.*(y+p.hy).^2.*(z-p.hz).^2.*(z+p.hz);
% end
if p.testAnaCase == 7
%     found = 1;
%     r = (x.^2 + y.^2 + z.^2).^1/2;
%     r = r + 1e-8;
%     psi = exp(-p.maxsigmaa*r);
    psi = zeros(size(x));
end
% % assert(found == 1,'Unknown id of analytical solution');
end


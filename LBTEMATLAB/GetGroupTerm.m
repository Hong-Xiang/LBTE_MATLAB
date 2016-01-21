function phig = GetGroupTerm(p, f, x, y, z, mu, xi, eta, el, eh)
[ev, wv] = lgwt(p.nIntO, el, eh);
phig = zeros(size(x));
for ie = 1 : numel(ev)
    phiv = f(p, x, y, z, mu, xi, eta, ev(ie));
    phig = phig + wv(ie)*phiv;
%     plot(p.xv, n3D21D(GetFlux3D(p,phiv)));
end
end


Res = Main();
ShowResult(Res);
% p = Parameters;
% slg = p.slg{1,1};
% sl = zeros(p.nso+1,1);
% for l = 0 : p.nso
%     sl(l+1) = slg(ilm(l,0),ilm(l,0));
% end
% x = -1 : 0.01 : 1;
% sigmas = zeros(size(x));
% for l = 0 : p.nso
%     pl = LegendrePoly(l,0,x);
%     sigmas = sigmas + pl*(2*l+1)/4/pi*sl(l+1);
% end
% 
% plot(sigmas);
% sigmas0 = sum(sigmas)/numel(sigmas)/2;
% el = p.energy(1);
% eh = p.energy(2);
% sca_a = GetGroupTerm(p, @ScatteringTerm, p.x, p.y, p.z, p.mu, p.xi, p.eta, el, eh);
% psig = GetGroupTerm(p, @AnalyticalSolution, p.x, p.y, p.z, p.mu, p.xi, p.eta, el, eh);
% phig = p.Ylm*p.w*psig;
% scalm = p.slg{1,1}*phig;
% sca_c = p.Ylm'*scalm;
% sca_a3 = GetFlux3D(p,sca_a);
% sca_c3 = GetFlux3D(p,sca_c);
% plot(1:p.nx,n3D21D(sca_a3), 1:p.nx,n3D21D(sca_c3),'+');
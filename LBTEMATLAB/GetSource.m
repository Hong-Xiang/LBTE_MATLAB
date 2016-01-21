function Sor = GetSource(para, el, eh)
if para.testAnaCase > 0
    % Analytical
    Sor = GetGroupTerm(para, @SourceTerm, para.x, para.y, para.z, para.mu, para.xi, para.eta, el, eh);
else
    % Point:
    Sor = zeros(para.na,para.nx*para.ny*para.nz);
    if el <= para.se && eh >= para.se
        ix = findId(para.spx,para.xv);
        iy = findId(para.spy,para.yv);
        iz = findId(para.spz,para.zv);
        %     ia = findId([para.sdx;para.sdy;para.sdz],para.ang');
        ids = id3d2id1d(ix,iy,iz,para.nx,para.ny,para.nz);
        Sor(:,ids) = 1;
        %     Sor(ia,ids) = 1;
    end
end



% Ana:
% e = (el+eh)/2*ones(size(para.x));
% Sor = ((-4*para.x.^3./(1+para.x.^4).^2).*para.mu+sigmaa(para,e)./(1+para.x.^4))*(eh-el);

% Ana2:
% Sor = (2*para.x.*para.mu+(1-2*1*para.emax)*para.x.^2)*(eh^2-el^2)/2-1*para.x.^2*(eh^3-el^3)/3;
% Sor = Sor/(eh-el);

% Ana3:
% sa = sigmaa(para,(el+eh)/2);
% ss = sigmas(para,(el+eh)/2);
% Sor = (2*para.x.*para.mu+(sa+ss)*para.x.^2-2*para.x.^2)*(eh-el)+(eh^2-el^2)/para.emax*para.x.^2;

% Test08221746
% par = para.x.*para.mu*(eh^2-el^2);
% abo = sigmaa(para,(el+eh)/2)*para.x.^2*(eh^2-el^2)/2+para.x.^2*(eh^3-el^3)/3;
% sca = para.x.^2*(para.emax*(eh^2-el^2) - 2/3*(eh^3-el^3));
% Sor = par+abo-sca;
end
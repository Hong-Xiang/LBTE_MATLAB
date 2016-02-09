function scaml = SetScatteringMatrixHGSH(para, edl, edh, esl, esh)
scaml = zeros(para.nlm, para.nlm);
for l = 0 : para.L       
    if esh < edl
        v = 0;
    else if edh <=esl
            v = integral2(@(x,y) HG_g(para,x).^l/2.*HG_dsigmasde(para, x, y), esl, esh, edl, edh);
        else
            v = integral(@(x) HG_g(para,x).^l/2.*HG_sigmas(para,x).*(1-esl^2./(x.^2)), esl, esh);
%             v = integral(@(x) HG_g(para,x).^l/2.*HG_sigmas(para,x).*(2-2*x/esh), esl, esh);
%             v = v/(esh-(esh-esl))*esh*esl;
        end
    end    
    v = v / (esh - esl);
    
%     v = v;
%     v = v /(2*l+1);
%     v = v / 100;
%     v = 0;
    for m = -l : l
        scaml(ilm(l,m),ilm(l,m)) = v;
    end
end
end

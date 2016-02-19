function x = GetGroupEnergyDepositCrossSection (para, el, eh)
%     [xv, wv] = lgwt(para.nIntO, el, eh);
%     x0 = HG_de(para, xv);
%     x = sum(x0.*wv);
%     x = x/(eh-el);
    x = integral(@(e) HG_de(para,e), el, eh)/(eh-el);
%     x = ones(size(el));
end
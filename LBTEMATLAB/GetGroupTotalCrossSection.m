function x = GetGroupTotalCrossSection (para, el, eh)
    [xv, wv] = lgwt(para.nIntO, el, eh);
    x0 = HG_sigmaa(para,xv) + HG_sigmas(para,xv);
    x = sum(x0.*wv);
    x = x/(eh-el);
end
function x = HG_sigmas(para, e)
x = (para.maxsigmas*(e-para.mine)+para.minsigmas*(para.maxe-e))/(para.maxe-para.mine);
end


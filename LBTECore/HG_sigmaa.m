function x = HG_sigmaa(para, e)
x = (para.maxsigmaa*(e-para.mine)+para.minsigmaa*(para.maxe-e))/(para.maxe-para.mine);
end


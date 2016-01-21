function v = HG_dsigmasde(para,es, et)
    v = 2*et./es;
    v(es < et) = 0;
    v = v.*HG_sigmas(para,es);
end


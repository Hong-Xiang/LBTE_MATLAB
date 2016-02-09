p = Parameters;

na = p.na;
w = p.w;
ang = p.ang;
Ylm = p.Ylm;
sigma_s0 = 0.1;

%% Test 1-a
close all
psi = ones(na,1);
cost = zeros(na, na);
for i = 1 : na
    for j = 1 : na
        cost(i,j) = ang(i,:)*(ang(j,:)');
    end
end
cost = max(cost, -1);
cost = min(cost, 1);
scam = HG_00(cost)/2/pi*sigma_s0*w;
psi_scat = scam*psi;
plot(1:na, psi, 1:na, psi_scat/sigma_s0,'+');
% title('Test 1-a : Basic Scattering Term');

%% Test 2-a-e
close all
x = -1 : 0.05 : 1;
sigmal00 = zeros(SO+1,1);
sigmal02 = zeros(SO+1,1);
sigmal05 = zeros(SO+1,1);
sigmal07 = zeros(SO+1,1);
sigmal09 = zeros(SO+1,1);
for i = 0 : SO
    sigmal00(i+1) = 1/2*integral(@(x) sigma_s0*LegendrePoly(i,0,x).*HG_00(x), -1, 1); 
    sigmal02(i+1) = 1/2*integral(@(x) sigma_s0*LegendrePoly(i,0,x).*HG_02(x), -1, 1); 
    sigmal05(i+1) = 1/2*integral(@(x) sigma_s0*LegendrePoly(i,0,x).*HG_05(x), -1, 1); 
    sigmal07(i+1) = 1/2*integral(@(x) sigma_s0*LegendrePoly(i,0,x).*HG_07(x), -1, 1); 
    sigmal09(i+1) = 1/2*integral(@(x) sigma_s0*LegendrePoly(i,0,x).*HG_09(x), -1, 1); 
end
sigma00a = sigma_s0*HG_00(x)/4/pi;
sigma02a = sigma_s0*HG_02(x)/4/pi;
sigma05a = sigma_s0*HG_05(x)/4/pi;
sigma07a = sigma_s0*HG_07(x)/4/pi;
sigma09a = sigma_s0*HG_09(x)/4/pi;
sigma00c = zeros(size(x));
sigma02c = zeros(size(x));
sigma05c = zeros(size(x));
sigma07c = zeros(size(x));
sigma09c = zeros(size(x));
for l = 0 : SO
    pl = LegendrePoly(l, 0, x);
    sigma00c = sigma00c + (2*l+1)/4/pi*sigmal00(l+1)*pl;
    sigma02c = sigma02c + (2*l+1)/4/pi*sigmal02(l+1)*pl;
    sigma05c = sigma05c + (2*l+1)/4/pi*sigmal05(l+1)*pl;
    sigma07c = sigma07c + (2*l+1)/4/pi*sigmal07(l+1)*pl;
    sigma09c = sigma09c + (2*l+1)/4/pi*sigmal09(l+1)*pl;
end
close all


subplot(231), plot(x, sigma00a, x, sigma00c, '+');
subplot(232), plot(x, sigma02a, x, sigma02c, '+');
subplot(233), plot(x, sigma05a, x, sigma05c, '+');
subplot(234), plot(x, sigma07a, x, sigma07c, '+');
subplot(235), plot(x, sigma09a, x, sigma09c, '+');


%% Test 3-a
close all
f1a = Ylm(ilm(1,0),:)';
f1lm = Ylm*w*f1a;
f1c = zeros(size(f1a));
for l = 0 : SO
    for m = -l : l
        f1c = f1c + f1lm(ilm(l,m))*Ylm(ilm(l,m),:)';
    end
end
plot(1:na, f1a, 1 : na, f1c);

%% Test 3-b
close all
f1a = Ylm(ilm(3,2),:)';
f1lm = Ylm*w*f1a;
f1c = zeros(size(f1a));
for l = 0 : SO
    for m = -l : l
        f1c = f1c + f1lm(ilm(l,m))*Ylm(ilm(l,m),:)';
    end
end
plot(1:na, f1a, 1 : na, f1c);


%% Test 3-c
close all
f1a = sin(ang(:,1)).*cos(ang(:,2)).*ang(:,3);
f1lm = Ylm*w*f1a;
f1c = zeros(size(f1a));
for l = 0 : SO
    for m = -l : l
        f1c = f1c + f1lm(ilm(l,m))*Ylm(ilm(l,m),:)';
    end
end
plot(1:na, f1a, 1 : na, f1c);

%% Test 4-a-e
close all
psi = sin(ang(:,1)).*cos(ang(:,2)).*ang(:,3);

philm = Ylm*w*psi;

cost = zeros(na, na);
for i = 1 : na
    for j = 1 : na
        cost(i,j) = ang(i,:)*(ang(j,:)');
    end
end
cost = max(cost, -1);
cost = min(cost, 1);

scam00 = HG_00(cost)/2/pi*sigma_s0*w;
scam02 = HG_02(cost)/2/pi*sigma_s0*w;
scam05 = HG_05(cost)/2/pi*sigma_s0*w;
scam07 = HG_07(cost)/2/pi*sigma_s0*w;
scam09 = HG_09(cost)/2/pi*sigma_s0*w;

psi_scat00f = scam00*psi;
psi_scat02f = scam02*psi;
psi_scat05f = scam05*psi;
psi_scat07f = scam07*psi;
psi_scat09f = scam09*psi;

psi_scat00s = zeros(na,1);
psi_scat02s = zeros(na,1);
psi_scat05s = zeros(na,1);
psi_scat07s = zeros(na,1);
psi_scat09s = zeros(na,1);

for l = 0 : SO
    for m = -l : l
        psi_scat00s = psi_scat00s + (2*l+1)*sigmal00(l+1)*philm(ilm(l,m))*Ylm(ilm(l,m),:)'/sqrt(2*pi);
        psi_scat02s = psi_scat02s + (2*l+1)*sigmal02(l+1)*philm(ilm(l,m))*Ylm(ilm(l,m),:)'/sqrt(2*pi);
        psi_scat05s = psi_scat05s + (2*l+1)*sigmal05(l+1)*philm(ilm(l,m))*Ylm(ilm(l,m),:)'/sqrt(2*pi);
        psi_scat07s = psi_scat07s + (2*l+1)*sigmal07(l+1)*philm(ilm(l,m))*Ylm(ilm(l,m),:)'/sqrt(2*pi);
        psi_scat09s = psi_scat09s + (2*l+1)*sigmal09(l+1)*philm(ilm(l,m))*Ylm(ilm(l,m),:)'/sqrt(2*pi);
    end
end
subplot(231), plot(1:na, psi_scat00f, 1:na, psi_scat00s);
subplot(232), plot(1:na, psi_scat02f, 1:na, psi_scat02s);
subplot(233), plot(1:na, psi_scat05f, 1:na, psi_scat05s);
subplot(234), plot(1:na, psi_scat07f, 1:na, psi_scat07s);
subplot(235), plot(1:na, psi_scat09f, 1:na, psi_scat09s);
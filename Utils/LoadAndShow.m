% prefix = 'TestFEM-SH-MC-SingleEnergy-';
prefix = 'TestFEM-SH-MC-ME-va-';
filename = [prefix,'LBTE-MATLAB-FEM.mat'];
Fs = load(filename);
F = Fs.phi;

filename = [prefix,'LBTE-MATLAB-SH.mat'];
Ss = load(filename);
S = Ss.phi;

filename = [prefix,'MC.mat'];
Ms = load(filename);
M = Ms.phi;


F1 = n3D21D(F);
S1 = n3D21D(S);
M1 = n3D21D(M);
x = 1 : size(F1,1);
plot(x, F1, x, S1, x, M1);
legend('FEM','SH','MC');

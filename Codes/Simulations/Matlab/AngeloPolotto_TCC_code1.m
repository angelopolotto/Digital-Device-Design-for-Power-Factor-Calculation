%% Simula��es do TCC 1 - �ngelo Polotto
%
%% Carregar os dados
%Limpa os dados do workspace
clear
%Limpa a tela
clc
disp('Script para c�lculo do fator de pot�ncia pelo m�todo num�rico.');
disp('Autor: �ngelo Polotto');
disp('********* Carregando Dados: *********');
%Carregando os dados do arquivo com os dados da simula��o para o Workspace
load('20150311_simu_2_workspace.mat');
%Dados vindos da simula��o (Simulink)
Vsim_val = Vsim.signals.values;
Isim_val = Isim.signals.values;
tsim_val = Vsim.time;
%*************************
%% Quantiza��o e Amostragem
disp('********* Processamento dos Valores: *********');
%Simula��o do conversor A/D para estimativas de erros.

V_quant = [];
V_sample = [];
resolution = 4; %4 bits para -128 a 127 equivale 0 a 256 seria 8 bits.
maxInput = 5; %Tens�o m�xima de entrada do conversor A/D.
Tsample = 5; %Per�odo de amostragem multiplo de 100us tsim_val(2)-tsim_val(1), a menor unidade de itera��o simulada.
disp(['Resolu��o: ' num2str(resolution) ' bits']);
disp(['Per. de Amostragem: ' num2str(Tsample*(tsim_val(2)-tsim_val(1))) ' s - Freq. de Amostragem: ' num2str(1/(Tsample*(tsim_val(2)-tsim_val(1)))) ' Hz']);
disp(['M�xima tens�o de entrada do conv. A/D: ' num2str(maxInput) ' V']);

[V_quant, V_sample, Ev] = quantization(Vsim_val, resolution, maxInput, Tsample);
[I_quant, I_sample, Ei] = quantization(Isim_val, resolution, maxInput, Tsample);

t = getSubTime(tsim_val, Vsim_val);%Exibe os cruzamentos de zero e aquisi��o de t.

%Cria gr�ficos com os dados para an�lise.
plotQuantization(tsim_val, Vsim_val, V_quant, V_sample, Tsample, Ev, 1, length(t), 'Quantiza��o da Tens�o', 'Tens�o (V)');
plotQuantization(tsim_val, Isim_val, I_quant, I_sample, Tsample, Ei, 1, length(t), 'Quantiza��o da Corrente', 'Corrente (A)');

%% C�lculo do per�odo e da frequ�ncia.
T = t(end)-t(1);
disp(['Per�odo: ' num2str(T) 's - Frequencia: ' num2str(1/T) ' Hz']);
disp('********* Resultados: *********');

%% C�lculo das pot�ncias e do fator de pot�ncia
%
[V, I, t] = getSubVectors(Vsim_val, Isim_val, tsim_val);
disp('# C�lculos para o sinal original:');
[fp_val, S_val, P_val, Vrms_val, Irms_val] = powerFactor(t,V,I);
disp(['-->P = ' num2str(P_val) ' W']);
disp(['-->S = ' num2str(S_val) ' VA - Vrms = ' num2str(Vrms_val) ' V - Irms = ' num2str(Irms_val) ' A']);
disp(['-->fp = ' num2str(fp_val)]);

[V, I, t] = getSubVectors(V_quant, I_quant, tsim_val);
disp('# C�lculos para o sinal quantizado:');
[fp, S, P, Vrms, Irms] = powerFactor(t,V,I);
disp(['-->P = ' num2str(P) ' W - Erro: ' num2str(P_val-P)]);
disp(['-->S = ' num2str(S) ' VA - Erro: ' num2str(S_val-S)]);
disp(['Vrms = ' num2str(Vrms) ' V - Erro: ' num2str(Vrms_val-Vrms) ' - Irms = ' num2str(Irms) ' A - Erro: ' num2str(Irms_val-Irms)]);
disp(['-->fp = ' num2str(fp) ' - Erro: ' num2str(fp_val-fp)]);

[V, I, t] = getSubVectors(V_sample, I_sample, tsim_val);
disp('# C�lculos para o sinal amostrado e quantizado:');
[fp, S, P, Vrms, Irms] = powerFactor(t,V,I);
disp(['-->P = ' num2str(P) ' W - Erro: ' num2str(P_val-P)]);
disp(['-->S = ' num2str(S) ' VA - Erro: ' num2str(S_val-S)]);
disp(['Vrms = ' num2str(Vrms) ' V - Erro: ' num2str(Vrms_val-Vrms) ' - Irms = ' num2str(Irms) ' A - Erro: ' num2str(Irms_val-Irms)]);
disp(['-->fp = ' num2str(fp) ' - Erro: ' num2str(fp_val-fp)]);
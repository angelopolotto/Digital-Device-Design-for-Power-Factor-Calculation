function [ fp, S, P, Vrms, Irms ] = powerFactor(t, V, I)
%powerFactor Fun��o para calculo do fator de pot�ncia
%   Essa fun��o retorna o fator de pot�ncia (fp), pot�ncia ativa(P) e
%   pot�cia aparente(S) com base no tempo(t), tens�o(V) e corrente(I). 
%   Todos os valores de entrada devem ser vetores vindos da amostragem.
%   Esses valores devem tamb�m serem correspondentes a um per�odo de
%   amostra, para estimativa correta dos resultados.

if length(V) == length(I) && length(V) == length(t)
    T = t(end)-t(1);
    P = myTrapz(t, V.*I)/T;
    Vrms = sqrt(myTrapz(t, V.^2)/T);
    Irms = sqrt(myTrapz(t, I.^2)/T);
    S = Vrms.*Irms;
    fp = P/S;
    %disp(['P = ' num2str(P) ' W']);
    %disp(['S = ' num2str(S) ' VA - Vrms = ' num2str(Vrms) ' V - Irms = ' num2str(Irms) ' A']);
    %disp(['fp = ' num2str(fp)]);
else
    error('V, I e t devem possuir o mesmo tamanho.');
end
end


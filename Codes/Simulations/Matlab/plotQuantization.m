function [ Xsample_aux ] = plotQuantization( tsim_val, Xsimu, Xquant, Xsample, Fsample, Ev, i1, i2, Title, Ylabel )
%plotQuantization cria os gr�ficos para comprar as fun��es.
%   Faz a corren��o do tamanho dos vetor Xsample e o plota jutamente com os
%   outros gr�ficos. Necess�rio para an�lises de erros de quantiza��o e
%   amostragem.

Xsample_aux = zeros(1,length(Xsimu));
j=1;
for i=1:Fsample:length(Xsimu)
    Xsample_aux(i) = Xsample(j);
    j = j + 1;
end
Xsample_aux(Xsample_aux == 0) = NaN;

figure
plot(subVector(tsim_val,i1,i2), subVector(Xsimu,i1,i2), 'b', subVector(tsim_val,i1,i2), subVector(Xquant,i1,i2), 'k', subVector(tsim_val,i1,i2), subVector(Ev,i1,i2), 'g');
hold on
stem(subVector(tsim_val,i1,i2), subVector(Xsample_aux,i1,i2), 'r');
title(Title)
ylabel(Ylabel)
xlabel('Tempo (s)')
legend('Original','Quantizado', 'Erro de Quantiza��o', 'Quantizado e Amostrado', 'Location','south')
hold off

end


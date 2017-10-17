function [ Int ] = myTrapz( X, Y )
%myTrapz Fun��o para c�lculo da integral num�rica de uma fun��o discreta
%   Efetua uma aproxima��o usando o m�todo de soma de trap�zios.
Int = 0;
if length(X) == length(Y)
    for i=1:length(Y)-1
        H = X(i+1)-X(i);
        B = Y(i);
        b = Y(i+1);
        Int = Int + (B+b)*H/2;
    end
else
    error('X e Y precisam possuir o mesmo tamanho.');
%disp(Int);
%Int = Int*(h/2);
end


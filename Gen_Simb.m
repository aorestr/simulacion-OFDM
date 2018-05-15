% ////////////////////Generador de símbolos QPSK\\\\\\\\\\\\\\\\\\\\\\\\\\\
% Entradas:
% N -> número de portadoras
% Salidas:
% x -> señal generada
% /////////////////////////////////////////////////////////////////////////

function x = Gen_Simb(N)
    x = zeros(1,N);
    % Símbolo aleatorio
    for i = 1:N
        Seed = floor(4.*rand(1));
        switch Seed
            case 0
                x(i) = 1 + 1*1i;
            case 1
                x(i) = 1 - 1*1i;
            case 2
                x(i) = -1 + 1*1i;
            case 3
                x(i) = -1 + -1*1i;
        end 
    end
end
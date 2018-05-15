% ///////////////////Probabilidad de error de símbolo\\\\\\\\\\\\\\\\\\\\\\
% Entradas:
% X -> señal a la entrada del emisor
% Y -> salida del receptor
% N -> número de portadoras
% samples -> muestras totales que se transmiten
% Salidas:
% ser -> probabilidad de error de símbolo
% /////////////////////////////////////////////////////////////////////////

function ber = BER(X,Y,N,samples)
    ber = 0;
    for i = 1:samples
        for n = 1:N
            if (real(X(n,i))*real(Y(n,i)) <= 0) 
                ber = ber + 1;
            end
            if (imag(X(n,i))*imag(Y(n,i)) <= 0)
                ber = ber + 1;
            end
        end
    end
    ber = (ber/(samples*N*2))*100;
end
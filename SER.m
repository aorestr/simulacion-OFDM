% ///////////////////Probabilidad de error de símbolo\\\\\\\\\\\\\\\\\\\\\\
% Entradas:
% X -> señal a la entrada del emisor
% Y -> salida del receptor
% N -> número de portadoras
% samples -> muestras totales que se transmiten
% Salidas:
% ser -> probabilidad de error de símbolo
% /////////////////////////////////////////////////////////////////////////

function ser = SER(X,Y,N,samples)
    ser = 0;
    for i = 1:samples
        for n = 1:N
            if (real(X(n,i))*real(Y(n,i)) <= 0) || ...
                    (imag(X(n,i))*imag(Y(n,i)) <= 0)
                ser = ser + 1;
            end
        end
    end
    ser = (ser/(samples*N))*100;
end
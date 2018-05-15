% //////////Receptor para la transmisión de símbolos OFDM\\\\\\\\\\\\\\\\\\
% Entradas:
% s -> entrada en el receptor
% N -> número de portadoras
% G -> nº de símbolos del intervalo de guarda
% h (opcional) -> respuesta al impulso del canal
% Salidas:
% y -> salida del receptor
% /////////////////////////////////////////////////////////////////////////

function y = Receptor(s,N,G,h)
    % Se elimina el intervalo de guarda, que hemos consensuado que será de
    % 8 muestras
    y = s((G+1):end);
    % FFT a la señal (demodulamos)
    y = fft(y);
    % Forzamos el multitrayecto del canal
    if nargin == 4
        y = y./fft(h(1:length(y)));
    end
    % Invertimos la corrección
    if y(1) ~= 0
        y(1) = y(1) + y(N+1)*1i;
    end
    % Eliminamos las muestras creadas a partir del conjugado de los
    % símbolos emitidos
    y = y(1:N);
end
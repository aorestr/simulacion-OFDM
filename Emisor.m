% ////////////////////Emisor de símbolos OFDM\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% Entradas:
% x -> muestra a transmitir
% N -> número de portadoras
% G -> nº de símbolos del intervalo de guarda
% Salidas:
% s -> señal a la salida del emisor
% Sec_inicial -> señal aleatoria que crea el emisor para ser transmitida
% /////////////////////////////////////////////////////////////////////////

function s = Emisor(x,N,G)
    x(end+1:2*N) = 0;

    for i = 1:N-1
        % Añadimos el conjugado rotado al final del flujo
        x(N+i+1) = conj(x(N-i+1));    
    end
    % Seguimos la corrección de la que se habla en el guion
    if x(1) ~= 0
        x(N+1) = imag(x(1));    x(1) = real(x(1));
    end
    % IFFT del flujo
    s = ifft(x);
    % Añadimos un intervalo de guarda para proteger a la señal del efecto 
    % multiplath
    s = [s((N*2)-(G-1):N*2), s];
    
end                                    
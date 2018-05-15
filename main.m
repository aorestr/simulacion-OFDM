clc
clear all

%% Preparación
% Número de portadoras
N = 32;
% ...de símbolos para el prefijo cíclico
G = 7;
% y de muestras por segundo
samples = 200;
% Aumentamos el número de muestras aumentando el tiempo de transmisión
% (100 segundos)
samples = samples * 100;

% Señal de inicio y de salida
X = zeros(N,samples);
Y = cell(1,5);
for i = 1:5
    Y{i} = zeros(N,samples);
end
% Señal a emitir por el canal
S = zeros(2*N+G,samples);

% Respuesta al impulso del primer canal
h1 = zeros(1,2*N+G);
    h1(1) = 1;
    h1(4) = 0.3;
    h1(6) = 0.7;
    h1(7) = 0.5;
% Y del segundo
h2 = zeros(1,2*N+G);
    h2(1) = 1;
    h2(4) = 0.3;
    h2(11) = 0.7;
    h2(12) = 0.5;


%% Generación y emisión de la señal
for i = 1:samples
    % Generamos la cadena completa
    X(:,i) = Gen_Simb(N);
    % La modulamos
    S(:,i) = Emisor(conj(X(:,i)'),N,G);
end


%% Recepción para los distintos canales
for j = 1:5
    % Pasamos la señal por el canal (excepto en el primer caso)
    if j ~= 1
        % Para el primer canal con y sin ecualización
        if j == 2 || j == 3
            h = h1;
        % Igual para el segundo
        else
            h = h2;
        end
        S_alt = filter(h,1,S);
    else
        % Sin canal
        S_alt = S;
    end
    % Para los canales que se ecualizan
    if j == 3 || j == 5
        for i = 1:samples
            Y{j}(:,i) = Receptor(conj(S_alt(:,i)'),N,G,h);
        end
    % Para los que no
    else
        for i = 1:samples
            Y{j}(:,i) = Receptor(conj(S_alt(:,i)'),N,G);
        end
    end
end


%% Probabilidad de error de sómbolo
canales = {'Transmisión sin canal' 'Transmisión por el canal 1 sin ecualización' ...
    'Transmisión por el canal 1 con ecualización' 'Transmisión por el canal 2 sin ecualización' ...
    'Transmisión por el canal 2 con ecualización'};
for i = 1:5
    fprintf('****************************************************************\n')
    fprintf('----------%s:----------\n',canales{i})
    fprintf('La probabilidad de error de bit es del %.3f%%\n',BER(X,Y{i},N,samples))
    fprintf('La probabilidad de error de símbolo es del %.3f%%\n',SER(X,Y{i},N,samples))
    fprintf('****************************************************************\n')
end


    
    

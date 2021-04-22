info = audioinfo('handel.wav')
[y,Fs] = audioread('handel.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
%figure,plot(t,y);
%sound(y,Fs)

%TRANSFORMADA DE FOURIER DE LA FORMA DE ONDA ORIGINAL
Y=fft(y);
L=length(y);
P2=abs(Y/L);
P1=P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
        %GRAFICA DE LA TRANSFORMADA DE FOURIER DE LA FORMA DE ONDA ORIGINAL
        f = Fs*(0:(L/2))/L;
        figure, plot(f,P1) 
        title('Grafico de la transformada de Fourier de y(t)')
        xlabel('f (Hz)')
        ylabel('Magnitud de la TF')
        
%DETERMINACION DE PARAMETROS WN Y ORDEN DEL FILTRO N
Wp=2000/(Fs/2);
Ws=1500/(Fs/2);
Rp=1;
Rs=10;
[n, Wn]=cheb1ord(Wp, Ws, Rp,Rs);


%DEFINICION Y GRAFICO DE FILTRO PASA_ALTO CHEVYCHEV--------COEFICIENTES
[b,a] = cheby1(n,Rp,Wn,'high');  
[H,w] = freqz(b,a,512);   %frecuencia del filtro w (512 muestras)  H complejo (512 muestras)
size(w)
size(H)
figure, plot(w*Fs/(2*pi),abs(H));
xlabel('Frecuencia (Hz)'); ylabel('Respuesta en Frecuencia');
grid;
axis([0 4000 0 1.2]);
        %FILTRO APLICADO AL AUDIO ORIGINAL
        sf = filter(b,a,y);
        SF= fft(sf);
        L=length(y);
        P2=abs(SF/L);
        P1=P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
            %GRAFICO DE FILTRO APLICADO AL AUDIO
            f = Fs*(0:(L/2))/L;
            figure, plot(f,P1) 
            title('fILTRO PASA_ALTO CHEVYCHEV APLICADO')
            xlabel('f (Hz)')
            ylabel('Magnitud de la TF')
            sound(sf,Fs)


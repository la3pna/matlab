%Calculation of beta reduction with frequency.


bn = 100; % transistor dc beta 
ft= 190; %transistor Ft (MHz)
f = 1:0.1:(100); %Frequency vector (MHz)

h= (f./ft);

bf= bn./(1+((j*bn.*h.*f)./ft));
Y = imag(bf);
semilogx(f,bf);
xlabel('Frequency MHz')
ylabel('Beta')
hold on; grid on;
%plot(f,Y,'r')


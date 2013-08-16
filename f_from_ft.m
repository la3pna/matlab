%Calculation of beta reduction with frequency.


bn = 100; % transistor dc beta 
ft= 3000; %transistor Ft (MHz)
f = 1:0.1:(1000); %Frequency vector (MHz)

h= (f./ft);

bf= bn./(1+((j*bn.*h.*f)./ft));
Y = imag(bf);
plot(f,bf);
xlabel('Frequency MHz')
ylabel('Beta')
hold on; grid on;
%plot(f,Y,'r')


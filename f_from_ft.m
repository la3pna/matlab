bn = 100;
ft= 3000;
f = 1:0.1:(1000);

h= (f./ft);

bf= bn./(1+((j*bn.*h.*f)./ft));
Y = imag(bf);
plot(f,bf);
xlabel('Frequency MHz')
ylabel('Beta')
hold on; grid on;
%plot(f,Y,'r')


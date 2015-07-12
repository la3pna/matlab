%Power amplifier output impedance

vcc = 12; %Supply voltage
ve= 0; %Emitter voltage (voltage over emitter resistor)
pout= 5
; %Power out

Rl = (vcc-ve)^2/(2.*pout) %Target load impedance

n = sqrt(50/Rl) %Transformer turns ratio
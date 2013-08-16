function draw_smith_chart 

% Draw outer circle
t = linspace(0, 2*pi, 100);
x = cos(t);
y = sin(t);
plot(x, y, 'Color','black'); axis equal; 
% Place title and remove ticks from axes
title(' Smith Chart ')
set(gca,'xticklabel',{[]});
set(gca,'yticklabel',{[]});
hold on 

% Draw circles along horizontal axis
k = [.25 .5 .75 ];
for i = 1 : length(k)
    x(i,:) = k(i) + (1 - k(i)) * cos(t);
    y(i,:) = (1 - k(i)) * sin(t);
    plot(x(i,:), y(i,:), 'k')
end 

line ([-1 1],[0 0], 'color', 'black')

% Draw partial circles along vertical axis
kt = [0 2.5 pi 3.79 4.22];
k = [0 .5  1 2 4 ];
for i = 1 : length(kt)
    t = linspace(kt(i), 1.5*pi, 50);
    a(i,:) = 1 + k(i) * cos(t);
    b(i,:) = k(i) + k(i) * sin(t);
    plot(a(i,:), b(i,:),'k', a(i,:), -b(i,:),'k' )
end


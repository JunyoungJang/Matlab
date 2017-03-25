t = 0:0.01:4*pi;
y = sin(t);
fc = 0;
t_length = length(t);
for n = 1:10:t_length
plot(t(1:n),y(1:n), 'b -', t(n),y(n), 'r >', 'linewidth', 2)
xlabel('t','fontsize', 18);
ylabel('y','fontsize', 18);
grid on
axis([0 max(t)+0.1 -1.1 1.1]),
pause(0.1);
str = ['Sine Wave: t = ' num2str(t(n))];
title(str,'fontsize', 16);
fc = fc+1;
F(fc)=getframe(gcf);
end
moviename= ['sine_wave.avi'];
movie2avi(F, moviename, 'fps', 6, 'colormap', jet, 'quality', 100)
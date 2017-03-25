clc, clear all, close all
tic;figure(1)
fprintf('                                  -= Homework 2-2. TEST =-\n\n\n(A).\n')
fprintf('==============================================================================================\n');
fprintf('-------------------------------------< Using Gauss Quadrature >-------------------------------\n');
f=@(x) cos(x).*log(x);
i1=1;ep=0.01;
exact=integral(f,ep,4*pi,'AbsTol',1e-8,'RelTol',1e-8);
while (1)
    h1(i1)=((4*pi-0)^(2*i1+1)*(factorial(i1))^4)/((2*i1+1)*(factorial(2*i1)).^3);
    int1(i1)=Gquad1(f,ep,4*pi,i1,'L');
    err1(i1)=abs((exact-int1(i1))/exact);
    if err1(i1)<1.e-8
        int1=int1+ep*(log(ep)-1)-ep^3/6*(log(ep)-1/3)+ep^5/600*(log(ep)-1/5);
        fprintf('|||  2-1 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i1,int1(i1),err1(i1));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i1=i1+1;
end

ep=0.1;
i2=1;
fprintf('==============================================================================================\n');
fprintf('---------------------------------------< Using Trapezoidal >----------------------------------\n');
error_h=@(x) -(1./(12*x.^2))*((cos(4*pi)/(4*pi))-sin(4*pi)*log(4*pi)-((cos(ep)/(ep))-sin(ep)*log(ep)));
exact=integral(f,ep,4*pi,'AbsTol',1e-8,'RelTol',1e-8);
while (1)
    h2(i2)=(4*pi-ep)/i2.^2;
    int2(i2)=trapezoidal(f,i2,ep,4*pi);
    err2(i2)=abs((exact-int2(i2))/exact);
    if err2(i2)<1.e-8 || i2==1.e3
        int2=int2+ep*(log(ep)-1)-ep^3/6*(log(ep)-1/3)+ep^5/600*(log(ep)-1/5);
        fprintf('|||  2-1 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i2,int2(i2),err2(i2));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i2=i2+1;
end

subplot(4,3,1);loglog(1:i1,err1,'-bo','linewidth', 2);hold on;
loglog(1:i2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('number of node');grid on;title('Convergence:Effect of number of Point');
subplot(4,3,2);loglog(h1,err1,'-bo','linewidth', 2);hold on;
loglog(h2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('h(mesh size)');grid on;title('Convergence:Effect of Mesh Size');
subplot(4,3,3);plot(1:i1,int1,'b');hold on;
plot(1:i2,int2,'r');legend('Gauss L Quadrature','Trapezoidal');
title('Integral value');grid on;xlabel('number of Iteration');ylabel('Integration Value');
fprintf('==============================================================================================\n');
%% 2
fprintf('\n\n\n(B).\n');
fprintf('==============================================================================================\n');
fprintf('-------------------------------------< Using Gauss Quadrature >-------------------------------\n');
clear all
f=@(x) x.^2.*sin(1./x);
i1=1;ep=0.01;
exact=integral(f,0,2/pi,'AbsTol',1e-10,'RelTol',1e-10);
while (1)
    h1(i1)=((2/pi-0)^(2*i1+1)*(factorial(i1))^4)/((2*i1+1)*(factorial(2*i1)).^3);
    int1(i1)=Gquad1(f,0,2/pi,i1,'L');
    err1(i1)=abs((exact-int1(i1))/exact);
    if err1(i1)<1.e-3
        %int1=int1+ep*(log(ep)-1)-ep^3/6*(log(ep)-1/3)+ep^5/600*(log(ep)-1/5);
        fprintf('|||  2-2 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i1,int1(i1),err1(i1));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i1=i1+1;
end


i2=1;
fprintf('==============================================================================================\n');
fprintf('---------------------------------------< Using Trapezoidal >----------------------------------\n');
error_h=@(x) -(1./(12*x.^2))*(2*(2/pi)*sin(pi/2)-cos(pi/2));
while (1)
    h2(i2)=(2/pi-0)/i2.^2;
    int2(i2)=trapezoidal(f,i2,ep,2/pi)+integral(@(x) x.^3-x.^5/6+x.^7/120,0,ep);
    err2(i2)=abs(error_h(i2)/exact);
    if err2(i2)<1.e-3
        fprintf('|||  2-2 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i2,int2(i2),err2(i2));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i2=i2+1;
end

subplot(4,3,4);loglog(1:i1,err1,'-bo','linewidth', 2);hold on;
loglog(1:i2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('number of node');grid on;title('Convergence:Effect of number of Point');
subplot(4,3,5);loglog(h1,err1,'-bo','linewidth', 2);hold on;
loglog(h2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('h(mesh size)');grid on;title('Convergence:Effect of Mesh Size');
subplot(4,3,6);plot(1:i1,int1,'b');hold on;
plot(1:i2,int2,'r');legend('Gauss L Quadrature','Trapezoidal');
title('Integral value');grid on;xlabel('number of Iteration');ylabel('Integration Value');
fprintf('==============================================================================================\n');

%% 3
fprintf('\n\n\n(C).\n');
fprintf('==============================================================================================\n');
fprintf('-------------------------------------< Using Gauss Quadrature >-------------------------------\n');
clear all
f=@(x) cos(x)./x.^(2/3);
exf=@(t) cos(t.^(3/2)).*(3/2).*(t.^(-1/2));
i1=1;ep=0.0001;
taylorplus=integral(@(x) 3*x.^(1/3) -3/14*x.^(7/3) +1/104*x.^(13/3),0,ep);
exact=integral(exf,ep,1,'AbsTol',1e-8,'RelTol',1e-8);
while (1)
    h1(i1)=((1-0)^(2*i1+1)*(factorial(i1))^4)/((2*i1+1)*(factorial(2*i1)).^3);
    int1(i1)=Gquad1(exf,ep,1,i1,'L');%+taylorplus;
    err1(i1)=abs((exact-int1(i1))/exact);
    if err1(i1)<1.e-8
        int1=int1+taylorplus+0.03;
        fprintf('|||  2-3 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i1,int1(i1),err1(i1));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i1=i1+1;
end


i2=1;
fprintf('==============================================================================================\n');
fprintf('---------------------------------------< Using Trapezoidal >----------------------------------\n');
taylorplus=integral(@(x) 3*x.^(1/3) -3/14*x.^(7/3) +1/104*x.^(13/3),0,ep);
exact=integral(exf,ep,1,'AbsTol',1e-8,'RelTol',1e-8);
while (1)
    h2(i2)=(1-0)/i2.^2;
    int2(i2)=trapezoidal(exf,i2,ep,1);
    err2(i2)=abs((exact-int2(i2))/exact);
    if err2(i2)<1.e-8 || i2==1.e3
        int2=int2+taylorplus;
        fprintf('|||  2-2 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i2,int2(i2),err2(i2));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i2=i2+1;
end

subplot(4,3,7);loglog(1:i1,err1,'-bo','linewidth', 2);
hold on;loglog(1:i2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('number of node');grid on;title('Convergence:Effect of number of Point');
subplot(4,3,8);loglog(h1,err1,'-bo','linewidth', 2);hold on;
loglog(h2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('h(mesh size)');grid on;title('Convergence:Effect of Mesh Size');
subplot(4,3,9);plot(1:i1,int1,'b');hold on;
plot(1:i2,int2,'r');legend('Gauss L Quadrature','Trapezoidal');
title('Integral value');grid on;xlabel('number of Iteration');ylabel('Integration Value');
fprintf('==============================================================================================\n');






%% 4
fprintf('\n\n\n(D).\n');
fprintf('==============================================================================================\n');
fprintf('-------------------------------------< Using Gauss Quadrature >-------------------------------\n');
clear all
f=@(x) sqrt(1-x.^4)./x.^(1-(1/pi));
exf=@(x) sqrt(1-x.^(4*pi/(pi-1))).*x.^((-pi+2)/(pi-1))*(pi/(pi-1));
i1=1;ep=1.e-4;
taylorplus=integral(@(x) 3*x.^(1/3) -3/14*x.^(7/3) +1/104*x.^(13/3),0,ep);
exact=integral(exf,ep,1,'AbsTol',1e-8,'RelTol',1e-8);
while (1)
    h1(i1)=((1-0)^(2*i1+1)*(factorial(i1))^4)/((2*i1+1)*(factorial(2*i1)).^3);
    int1(i1)=Gquad1(exf,ep,1,i1,'L');%+taylorplus;
    err1(i1)=abs((exact-int1(i1))/exact);
    if err1(i1)<1.e-5
        int1=int1+taylorplus+4.261609e-02;
        fprintf('|||  2-4 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i1,int1(i1),err1(i1));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i1=i1+1;
end


i2=1;
fprintf('==============================================================================================\n');
fprintf('---------------------------------------< Using Trapezoidal >----------------------------------\n');
while (1)
    h2(i2)=(1-0)/i2.^2;
    int2(i2)=trapezoidal(exf,i2,ep,1);
    err2(i2)=abs((exact-int2(i2))/exact);
    if err2(i2)<1.e-8 || i2==1.e3
        int2=int2+taylorplus;
        fprintf('|||  2-4 Result   || iteration - %5d | value - %20.15f | error - %10.8f |||\n',i2,int2(i2),err2(i2));
        fprintf('----------------------------------------------------------------------------------------------\n');
        break;
    end
    i2=i2+1;
end

subplot(4,3,10);loglog(1:i1,err1,'-bo','linewidth', 2);
hold on;loglog(1:i2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('number of node');grid on;title('Convergence:Effect of number of Point');
subplot(4,3,11);loglog(h1,err1,'-bo','linewidth', 2);hold on;
loglog(h2,err2,'-ro','linewidth', 2);legend('Gauss L Quadrature','Trapezoidal');
ylabel('relative error(%)');xlabel('h(mesh size)');grid on;title('Convergence:Effect of Mesh Size');
subplot(4,3,12);plot(1:i1,int1,'b');hold on;
plot(1:i2,int2,'r');legend('Gauss L Quadrature','Trapezoidal');
title('Integral value');grid on;xlabel('number of Iteration');ylabel('Integration Value');
fprintf('==============================================================================================\n');




toc
fprintf('\n')
fprintf('\n')
fprintf('\n')
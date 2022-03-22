function out = RS1
out{1} = @init;
out{2} = @fun_eval;
out{3} = @jacobian;
out{4} = @jacobianp;
out{5} = @hessians;
out{6} = @hessiansp;
out{7} = [];
out{8} = [];
out{9} = [];
out{10}= @A;

% --------------------------------------------------------------------------
function dydt = fun_eval(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
dydt=[ -kmrgd(1)*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5))*kb2 - kmrgd(1)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*kb4 + kmrgd(4)*k1 + kmrgd(5)*kub2 + kmrgd(9)*kub4 + kmrgd(8)*k3;;
 -kmrgd(2)*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5))*ab2 - kmrgd(2)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*ab4 + kmrgd(6)*a1 + kmrgd(7)*aub2 + kmrgd(11)*aub4 + kmrgd(10)*a3;;
 -kmrgd(3)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*ab3 - kmrgd(3)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*kb3 + kmrgd(5)*k2 + kmrgd(7)*a2 + kmrgd(8)*kub3 + kmrgd(10)*aub3;;
 kb1*(ATotal -kmrgd(2) - kmrgd(1) - kmrgd(3) - kmrgd(4) - kmrgd(5) - kmrgd(6) - kmrgd(7) - kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5)) - (k1 + kub1)*kmrgd(4);;
 kb2*kmrgd(1)*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5)) - (k2 + kub2)*kmrgd(5);;
 ab1*(ATotal -kmrgd(2) - kmrgd(1) - kmrgd(3) - kmrgd(4) - kmrgd(5) - kmrgd(6) - kmrgd(7) - kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9))*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5)) - (aub1 + a1)*kmrgd(6);;
 ab2*kmrgd(2)*(KTotal -kmrgd(4) - kmrgd(7) - kmrgd(6) - kmrgd(5)) - (aub2 + a2)*kmrgd(7);;
 kb3*kmrgd(3)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9)) - (kub3 + k3)*kmrgd(8);;
 kb4*kmrgd(1)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9)) - (kub4 + k4)*kmrgd(9);;
 ab3*kmrgd(3)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9)) - (aub3 + a3)*kmrgd(10);;
 ab4*kmrgd(2)*(PTotal -kmrgd(8) - kmrgd(11) - kmrgd(10) - kmrgd(9)) - (aub4 + a4)*kmrgd(11);;];

% --------------------------------------------------------------------------
function [tspan,y0,options] = init
y0=[0,0,0,0,0,0,0,0,0,0,0];
options = odeset('Jacobian',handles(3),'JacobianP',handles(4),'Hessians',handles(5),'HessiansP',handles(6));
handles = feval(RS1);
tspan = [0 10];

% --------------------------------------------------------------------------
function jac = jacobian(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
jac=[ kb2*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) + kb4*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , k1 + kmrgd(1)*kb2 , kub2 + kmrgd(1)*kb2 , kmrgd(1)*kb2 , kmrgd(1)*kb2 , k3 + kmrgd(1)*kb4 , kub4 + kmrgd(1)*kb4 , kmrgd(1)*kb4 , kmrgd(1)*kb4 ; 0 , ab2*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) + ab4*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , kmrgd(2)*ab2 , kmrgd(2)*ab2 , a1 + kmrgd(2)*ab2 , aub2 + kmrgd(2)*ab2 , kmrgd(2)*ab4 , kmrgd(2)*ab4 , a3 + kmrgd(2)*ab4 , aub4 + kmrgd(2)*ab4 ; 0 , 0 , ab3*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) + kb3*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , k2 , 0 , a2 , kub3 + kmrgd(3)*ab3 + kmrgd(3)*kb3 , kmrgd(3)*ab3 + kmrgd(3)*kb3 , aub3 + kmrgd(3)*ab3 + kmrgd(3)*kb3 , kmrgd(3)*ab3 + kmrgd(3)*kb3 ; kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) - kub1 - k1 + kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) ; -kb2*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , 0 , -kmrgd(1)*kb2 , - k2 - kub2 - kmrgd(1)*kb2 , -kmrgd(1)*kb2 , -kmrgd(1)*kb2 , 0 , 0 , 0 , 0 ; ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) - aub1 - a1 + ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) + ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) ; 0 , -ab2*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , -kmrgd(2)*ab2 , -kmrgd(2)*ab2 , -kmrgd(2)*ab2 , - a2 - aub2 - kmrgd(2)*ab2 , 0 , 0 , 0 , 0 ; 0 , 0 , -kb3*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , - k3 - kub3 - kmrgd(3)*kb3 , -kmrgd(3)*kb3 , -kmrgd(3)*kb3 , -kmrgd(3)*kb3 ; -kb4*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(1)*kb4 , - k4 - kub4 - kmrgd(1)*kb4 , -kmrgd(1)*kb4 , -kmrgd(1)*kb4 ; 0 , 0 , -ab3*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , -kmrgd(3)*ab3 , -kmrgd(3)*ab3 , - a3 - aub3 - kmrgd(3)*ab3 , -kmrgd(3)*ab3 ; 0 , -ab4*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , -kmrgd(2)*ab4 , -kmrgd(2)*ab4 , -kmrgd(2)*ab4 , - a4 - aub4 - kmrgd(2)*ab4 ];
% --------------------------------------------------------------------------
function jacp = jacobianp(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
jacp=[ kmrgd(4) , 0 , kmrgd(8) , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(1)*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , kmrgd(1)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , kmrgd(5) , 0 , kmrgd(9) , 0 , 0 , 0 , 0 , 0 , -kmrgd(1)*kb2 , -kmrgd(1)*kb4 ; 0 , 0 , 0 , 0 , kmrgd(6) , 0 , kmrgd(10) , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(2)*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , kmrgd(2)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , kmrgd(7) , 0 , kmrgd(11) , 0 , -kmrgd(2)*ab2 , -kmrgd(2)*ab4 ; 0 , kmrgd(5) , 0 , 0 , 0 , kmrgd(7) , 0 , 0 , 0 , 0 , kmrgd(3)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , kmrgd(3)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , kmrgd(8) , 0 , 0 , 0 , kmrgd(10) , 0 , 0 , 0 , - kmrgd(3)*ab3 - kmrgd(3)*kb3 ; -kmrgd(4) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , (kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal)*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(4) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kb1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , -kb1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) , 0 ; 0 , -kmrgd(5) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(1)*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(5) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(1)*kb2 , 0 ; 0 , 0 , 0 , 0 , -kmrgd(6) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , (kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal)*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(6) , 0 , 0 , 0 , -ab1*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , -ab1*(kmrgd(1) + kmrgd(2) + kmrgd(3) + kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(9) + kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal) , 0 ; 0 , 0 , 0 , 0 , 0 , -kmrgd(7) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(2)*(kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(7) , 0 , 0 , 0 , kmrgd(2)*ab2 , 0 ; 0 , 0 , -kmrgd(8) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(3)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(8) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(3)*kb3 ; 0 , 0 , 0 , -kmrgd(9) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(1)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(9) , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(1)*kb4 ; 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(10) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(3)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(10) , 0 , 0 , 0 , kmrgd(3)*ab3 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(11) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(2)*(kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(11) , 0 , 0 , kmrgd(2)*ab4 ];
% --------------------------------------------------------------------------
function hess = hessians(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
hess1=[ 0 , 0 , 0 , kb2 , kb2 , kb2 , kb2 , kb4 , kb4 , kb4 , kb4 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -kb2 , -kb2 , -kb2 , -kb2 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kb4 , -kb4 , -kb4 , -kb4 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess2=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab2 , ab2 , ab2 , ab2 , ab4 , ab4 , ab4 , ab4 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -ab2 , -ab2 , -ab2 , -ab2 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -ab4 , -ab4 , -ab4 , -ab4 ];
hess3=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , ab3 + kb3 , ab3 + kb3 , ab3 + kb3 , ab3 + kb3 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -kb3 , -kb3 , -kb3 , -kb3 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -ab3 , -ab3 , -ab3 , -ab3 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess4=[ kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kb1 , kb1 , kb1 , 2*kb1 , 2*kb1 , 2*kb1 , 2*kb1 , kb1 , kb1 , kb1 , kb1 ; -kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; ab1 , ab1 , ab1 , 2*ab1 , 2*ab1 , 2*ab1 , 2*ab1 , ab1 , ab1 , ab1 , ab1 ; 0 , -ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess5=[ kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kb1 , kb1 , kb1 , 2*kb1 , 2*kb1 , 2*kb1 , 2*kb1 , kb1 , kb1 , kb1 , kb1 ; -kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; ab1 , ab1 , ab1 , 2*ab1 , 2*ab1 , 2*ab1 , 2*ab1 , ab1 , ab1 , ab1 , ab1 ; 0 , -ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess6=[ kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kb1 , kb1 , kb1 , 2*kb1 , 2*kb1 , 2*kb1 , 2*kb1 , kb1 , kb1 , kb1 , kb1 ; -kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; ab1 , ab1 , ab1 , 2*ab1 , 2*ab1 , 2*ab1 , 2*ab1 , ab1 , ab1 , ab1 , ab1 ; 0 , -ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess7=[ kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kb1 , kb1 , kb1 , 2*kb1 , 2*kb1 , 2*kb1 , 2*kb1 , kb1 , kb1 , kb1 , kb1 ; -kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; ab1 , ab1 , ab1 , 2*ab1 , 2*ab1 , 2*ab1 , 2*ab1 , ab1 , ab1 , ab1 , ab1 ; 0 , -ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess8=[ kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , ab3 + kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -ab3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess9=[ kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , ab3 + kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -ab3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess10=[ kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , ab3 + kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -ab3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess11=[ kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , ab3 + kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , kb1 , kb1 , kb1 , kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , ab1 , ab1 , ab1 , ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , -ab3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hess(:,:,1) =hess1;
hess(:,:,2) =hess2;
hess(:,:,3) =hess3;
hess(:,:,4) =hess4;
hess(:,:,5) =hess5;
hess(:,:,6) =hess6;
hess(:,:,7) =hess7;
hess(:,:,8) =hess8;
hess(:,:,9) =hess9;
hess(:,:,10) =hess10;
hess(:,:,11) =hess11;
% --------------------------------------------------------------------------
function hessp = hessiansp(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
hessp1=[ 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp2=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp3=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp4=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp5=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp6=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp7=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp8=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 ];
hessp9=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp10=[ kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , 0 , 0 , kmrgd(1) , kmrgd(1) , kmrgd(1) , kmrgd(1) , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; KTotal - kmrgd(5) - kmrgd(6) - kmrgd(7) - kmrgd(4) , 0 , 0 , -kmrgd(1) , -kmrgd(1) , -kmrgd(1) , -kmrgd(1) , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp11=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal , 0 , 0 , 0 , 0 , kmrgd(3) , kmrgd(3) , kmrgd(3) , kmrgd(3) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , PTotal - kmrgd(11) - kmrgd(8) - kmrgd(10) - kmrgd(9) , 0 , 0 , 0 , 0 , -kmrgd(3) , -kmrgd(3) , -kmrgd(3) , -kmrgd(3) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp12=[ kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal , 0 , 0 , 0 , 0 , 0 , 0 , kmrgd(1) , kmrgd(1) , kmrgd(1) , kmrgd(1) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; PTotal - kmrgd(11) - kmrgd(8) - kmrgd(10) - kmrgd(9) , 0 , 0 , 0 , 0 , 0 , 0 , -kmrgd(1) , -kmrgd(1) , -kmrgd(1) , -kmrgd(1) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp13=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(1) + kmrgd(2) + kmrgd(3) + 2*kmrgd(4) + 2*kmrgd(5) + 2*kmrgd(6) + kmrgd(9) + 2*kmrgd(7) + kmrgd(11) + kmrgd(8) + kmrgd(10) - ATotal - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp14=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , kmrgd(4) + kmrgd(5) + kmrgd(6) + kmrgd(7) - KTotal , 0 , kmrgd(2) , kmrgd(2) , kmrgd(2) , kmrgd(2) , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , KTotal - kmrgd(5) - kmrgd(6) - kmrgd(7) - kmrgd(4) , 0 , -kmrgd(2) , -kmrgd(2) , -kmrgd(2) , -kmrgd(2) , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp15=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal , 0 , 0 , 0 , 0 , kmrgd(3) , kmrgd(3) , kmrgd(3) , kmrgd(3) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , PTotal - kmrgd(11) - kmrgd(8) - kmrgd(10) - kmrgd(9) , 0 , 0 , 0 , 0 , -kmrgd(3) , -kmrgd(3) , -kmrgd(3) , -kmrgd(3) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp16=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , kmrgd(9) + kmrgd(11) + kmrgd(8) + kmrgd(10) - PTotal , 0 , 0 , 0 , 0 , 0 , kmrgd(2) , kmrgd(2) , kmrgd(2) , kmrgd(2) ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , PTotal - kmrgd(11) - kmrgd(8) - kmrgd(10) - kmrgd(9) , 0 , 0 , 0 , 0 , 0 , -kmrgd(2) , -kmrgd(2) , -kmrgd(2) , -kmrgd(2) ];
hessp17=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp18=[ 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp19=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp20=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp21=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp22=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp23=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp24=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , -1 ];
hessp25=[ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -kb1 , -kb1 , -kb1 , -kb1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , -ab1 , -ab1 , -ab1 , -ab1 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp26=[ -kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 , -kb1 ; kb2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 , -ab1 ; 0 , ab2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp27=[ -kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , -ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , - ab3 - kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , kb3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; kb4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , 0 , ab3 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ; 0 , ab4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
hessp(:,:,1) =hessp1;
hessp(:,:,2) =hessp2;
hessp(:,:,3) =hessp3;
hessp(:,:,4) =hessp4;
hessp(:,:,5) =hessp5;
hessp(:,:,6) =hessp6;
hessp(:,:,7) =hessp7;
hessp(:,:,8) =hessp8;
hessp(:,:,9) =hessp9;
hessp(:,:,10) =hessp10;
hessp(:,:,11) =hessp11;
hessp(:,:,12) =hessp12;
hessp(:,:,13) =hessp13;
hessp(:,:,14) =hessp14;
hessp(:,:,15) =hessp15;
hessp(:,:,16) =hessp16;
hessp(:,:,17) =hessp17;
hessp(:,:,18) =hessp18;
hessp(:,:,19) =hessp19;
hessp(:,:,20) =hessp20;
hessp(:,:,21) =hessp21;
hessp(:,:,22) =hessp22;
hessp(:,:,23) =hessp23;
hessp(:,:,24) =hessp24;
hessp(:,:,25) =hessp25;
hessp(:,:,26) =hessp26;
hessp(:,:,27) =hessp27;
%---------------------------------------------------------------------------
function tens3  = der3(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
%---------------------------------------------------------------------------
function tens4  = der4(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
%---------------------------------------------------------------------------
function tens5  = der5(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
function userfun1=A(t,kmrgd,k1,k2,k3,k4,a1,a2,a3,a4,kb1,kb2,kb3,kb4,ab1,ab2,ab3,ab4,kub1,kub2,kub3,kub4,aub1,aub2,aub3,aub4,ATotal,KTotal,PTotal)
	userfun1=0;
clear all
close all

W2 = tf([2],[1 10]);
W1 = tf([1],[1 1]);
P = tf([1],[1 -1]);
C = 5/7;

L = P*C;
T = L/(1+L);
S = 1/(1+L);
figure(7)
%bode(2*W2*T)
bode(W2*T)
hold on
%bode((W1*S)/(1-2*W2*T))
%bode((W1*S)/(1+2*W2*T))

%%
%sfigure(1)
%bode(1/(P*(W2-1))) % *2

figure(2)
C = -30;
for i= 0:1:20
   
    L = P*C;
    T = L/(1+L);
    hold on
    bode(2*W2*T)
    C = C-i;
    
end

%%
C = -0.7;
figure(3)

bode(2*W2*T)
% nyquist(W2*T)

% norm(2*W2*T,inf)

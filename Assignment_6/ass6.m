clc
clear all
close all

W2 = tf([2],[1 10]);
W1 = tf([1],[1 1]);
P = tf([1],[1 -1]);

figure(4)
rlocus(P)
sgrid

%%
C = 1;
beta = 2;

L = P*C;
T = L/(1+L);
S = 1/(1+L);
figure(1)
%bode(2*W2*T)
bode(beta*W2*T)
hold on


%% Bode per vari valori del controllore

figure(2)
C = -30;
for i= 0:1:20
   
    L = P*C;
    T = L/(1+L);
    hold on
    bode(beta*W2*T)
    C = C-i;
    
end

%%

C = -0.7;
figure(3)
bode(2*W2*T)
% nyquist(W2*T)

% norm(2*W2*T,inf)

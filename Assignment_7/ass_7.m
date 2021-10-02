% Conti Assignment 7
clc
clear all
close all

n = 4;
M = 1;
F = 1;
l = 1;
g = 9.81;

w = 0.1;

% Matrici Sistema Linearizzato
A = [0   1    0   0;
     0 -F/M   0   0;
     0   0    0   1;
     0 F/M*l g/l 0];

B = [0;1/M;0;-(1/M*l)];

C = [1 0 0 0;
     0 0 1 0];
 
P = B;

%% Controllabilità (a tempo continuo coincide con la raggiungibilità)
p = ctrb(A,B);
if(rank(p) == n)
    disp('il sistema è controllabile')
end

%% Verifica del lemma di Hautus 
syms omega
hautus = [(omega*1i)*eye(n)-A B;C(1,:) 0];
rank(hautus)

%% Osservabilità
S = [0 0 0;0 0 w;0 -w 0]; % S dipende d omega dove è 0.1
Q = [0 -1 0];

Pes = [P zeros(4,1) zeros(4,1)];
Aes = [A Pes;zeros(3,4) S];
Qes = [Q ; zeros(1,3)];
Ces = [C Qes];

rank(obsv(Aes,Ces))


%% Matrice K 

% u = Kx +Ld

p = [-8 -6 -10 -12];
%p = [-5 -6 -7 -8];

K = -(place(A,B,p));
% u = -Kx   ->  prendo K = -K -> u = Kx

%% Sylvester equation-> risolta in Wolfram Mathematica

% caso w = 0.1;   anche queste dipendono da omega

PI = [0 1 0;
      0 0 0.1;
      0 -0.00101833 0;
      0 0 -0.000101833];
  
Gamma = [-1 -0.01 0.1];

L = Gamma - K*PI;

%% caso w = 1

w = 1;

S = [0 0 0;0 0 w;0 -w 0];
PI = [0 1 0;
      0 0 1;
      0 -0.0925069 0;
      0 0 -0.0925069];
  
Gamma = [-1 -1 1];  
L = Gamma - K*PI;

% risolvi Sylvester

%% caso w = 10

w = 10;
S = [0 0 0;0 0 w;0 -w 0];

PI = [0 1 0;
      0 0 10;
      0 -0.910664 0;
      0 0 -9.10664];
  
Gamma = [-1 -100 10];  
L = Gamma - K*PI;

%% Analisi Sistema

% Risposta del sistema in base all'ingresso
D = [0;0];
sysMec = ss(A,B,C,D);
sysMectf = minreal(tf(sysMec));
figure(1)
bode(sysMectf)
grid on
title("Risposta in frequenza Sistema Meccanico")

%% non-stationary problem with action-values methods using upper boundary condition

alpha=1/10; c = 1.5;
iter = 100000;
episodes = 50;
BA_array = zeros(1,iter);
R_avg = zeros(1,iter);
for j = 1:episodes
    Rtot=0; best_actions = 0;
    q = normrnd(0,10,1,10); %vettore che tiene conto di q
    Q = ones(1,10) * 10; %vettore che tiene conto delle stime di q
    N = zeros(1,10);
    for i=1:iter
        exploration = c*sqrt(log(i)./N);
        [~, a] = max(Q + exploration);
        [~, a_best] = max(q);
        if q(a) == q(a_best)
            best_actions = best_actions + 1;
        end
        BA_array(i) = BA_array(i) + 100*best_actions / i;
        N(a) = N(a) + 1;
        %genero ricompensa
        R = normrnd(q(a),1);
        Rtot = Rtot + R;
        R_avg(i) = R_avg(i) + Rtot / i;
        %apprendimento
        Q(a) = Q(a) + alpha*(R - Q(a));
        %q* fa random walks ogni tot passi
        if rem(i,10) == 0
            q = q + 0.01*normrnd(0,10,1,10);
        end
        
    end
end
R_avg = R_avg / episodes;
BA_array = BA_array / episodes;

save 15UCB_data.mat R_avg BA_array
disp("UCB done!")
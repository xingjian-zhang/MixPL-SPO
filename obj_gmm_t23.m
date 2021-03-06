function se = obj_gmm_t23( theta, emp )
% objective function for GMM-top-2,3
l = length(theta);
m = l/2 - 1;
q = m^2 - 1;
q1 = m*(m-1) - 1;
t3 = cyclic_partial(m, 3);
alphas = theta(1:2);
alpha = alphas(1);
gamma1 = theta(3:m+2);
gamma2 = theta(m+3:2*m+2);
%Computing probabilities given theta
theo = zeros(1, q);
ind = 0;
% top 2
for a1 = 1:m
    for a2 = 1:m
        if a1 ~= a2
            ind = ind + 1;
            p1 = gamma1(a1)*gamma1(a2)/(1-gamma1(a1));
            p2 = gamma2(a1)*gamma2(a2)/(1-gamma2(a1));
            theo(ind) = alpha * p1 + (1 - alpha) * p2;
        end
    end
end
% top 3
for j = 1:m
    a1 = t3(j, 1);
    a2 = t3(j, 2);
    a3 = t3(j, 3);
    p1 = gamma1(a1)*gamma1(a2)*gamma1(a3)/(1-gamma1(a1))/(1-gamma1(a1)-gamma1(a2));
    p2 = gamma2(a1)*gamma2(a2)*gamma2(a3)/(1-gamma2(a1))/(1-gamma2(a1)-gamma2(a2));
    theo(q1+j) = alpha * p1 + (1 - alpha) * p2;
end
diff = theo - emp;
se = diff*diff';
end

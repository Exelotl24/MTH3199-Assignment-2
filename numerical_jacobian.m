function J = numerical_jacobian(F, V)
    f0 = F(V);
    n = length(V);
    m = length(f0);
    J = zeros(m, n);
    h = 1e-6; 

    for i = 1:n
        Vh = V;
        Vh(i) = Vh(i) + h; % bump one coordinate slightly
        J(:,i) = (F(Vh) - f0) / h;% measure change in output / step
    end
end
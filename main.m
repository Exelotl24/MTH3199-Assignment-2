% Initial guess
clear
close all
run_simulation(pi/4, 10)


return;
X = [3; 2; 1];  

tol = 1e-8;      
max_iter = 50;  

for k = 1:max_iter
    [f_val, J] = test_function01(X);
    
    % Update step
    delta = J \ f_val;
    X_new = X - delta;
    
    % Check convergence
    if norm(f_val) < tol
        fprintf('Converged in %d iterations.\n', k);
        break;
    end
    
    X = X_new;
end

disp('Root found:');
disp(X);
disp('Function evaluated at root:');
disp(test_function01(X));

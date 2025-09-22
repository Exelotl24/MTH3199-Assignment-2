% test for test_function01

% Define input vector
X_test = [1; 2; 3];

% Call your function
[f_val, J] = test_function01(X_test);

% Display results
disp('f(X) = ')
disp(f_val)

disp('Jacobian J(X) = ')
disp(J)

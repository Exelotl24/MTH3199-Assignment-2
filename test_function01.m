%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like
function [f_val, J] = test_function01(X)
    % X is [x1; x2; x3]
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);

    % Define f(X)
    f1 = x1^2 + x2^2 - 6 - x3^5;
    f2 = x1*x3 + x2 - 12;
    f3 = sin(x1 + x2 + x3);

    f_val = [f1; f2; f3];

    % Jacobian J(X) = df/dx
    % f1 = x1^2 + x2^2 - 6 - x3^5
    df1_dx1 = 2*x1;
    df1_dx2 = 2*x2;
    df1_dx3 = -5*x3^4;

    % f2 = x1*x3 + x2 - 12
    df2_dx1 = x3;
    df2_dx2 = 1;
    df2_dx3 = x1;

    % f3 = sin(x1 + x2 + x3)
    df3_dx1 = cos(x1 + x2 + x3);
    df3_dx2 = cos(x1 + x2 + x3);
    df3_dx3 = cos(x1 + x2 + x3);

    % Assemble Jacobian
    J = [df1_dx1, df1_dx2, df1_dx3;
         df2_dx1, df2_dx2, df2_dx3;
         df3_dx1, df3_dx2, df3_dx3];
end
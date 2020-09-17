%%%%%%%%%%%%%%
% first example - only force equilibrium is concidered (no torques)
%%%%%%%%%%%%%%
close all; clear;
tol = 10^-6;

number_of_contacts = 5;

ContactPoints = randn(3, number_of_contacts);
ContactNormals = randn(3, number_of_contacts);
ContactTangents = cell(number_of_contacts, 1);

for i = 1:number_of_contacts
    ContactNormals(:, i) = ContactNormals(:, i) / norm(ContactNormals(:, i));
    
    temp = svd_suit(ContactNormals(:, i), tol);
    ContactTangents{i} = temp.left_null;
end

friction_coef = 0.5;

cvx_begin 
    variable F(3, number_of_contacts) %reaction forces
    
    minimize( norm( sum(F, 2) ) )
    subject to
        sum(F, 2) == zeros(3, 1);
    	for i = 1:number_of_contacts
            ContactNormals(:, i)' * F(:, i) >= 0;
            norm( (ContactTangents{i})' * F(:, i) ) <= friction_coef * ContactNormals(:, i)' * F(:, i)
        end
cvx_end

F
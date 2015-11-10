function[value] = fitness(params,index)
    %%Add your functions in this file
    switch index
        case 1
            value = sum(params.^2);%Spherical
        case 2
            value = log(1+(1-params(1))^2+100*(params(2)-params(1)^2)^2);%Rosenbrock
        case 3
            value = (1.5-params(1)+params(1)*params(2))^2+(2.25-params(1)+params(1)*(params(2)^2))^2+(2.625-params(1)+params(1)*(params(2)^3))^2;%Beale
        case 4
            %value = 0.5 *sum((w/params(1)) * erfc((sqrt(6 * params(2) * params(3)))))
            %value = (1*params(1))-1.0*params(2)+100*params(3)+1.0*params(4);
            value = -(10*params(1))-1.0*params(2)+100*params(3)-1.0*params(4);
        case 5
            value = -(10*params(1))-1.0*params(2)+100*params(3)+1.0*params(4);
        otherwise
            value = sum(params.^2);%Spherical
    end
end

%wfree = 6
%dfree = 50
%nfree = 100
%rc = 0,3-0,5
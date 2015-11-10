function[LOW, HIGH, NVAR, INDEX] = userPrompt()
    %%This file should be synced with fitness.m file regularly
    disp('Test Functions');
    disp('1: Spherical Function');
    disp('2: Rosenbrock''s Function');
    disp('3: Beale''s Function');
    disp('4: Code Function (positive)');
    disp('5: Code Function (negative)');
    
    INDEX=input('Enter Your choice : ');
    
    switch INDEX
        case 1
            LOW = [-10 -10 -10];
            HIGH = [10 10 10];
            NVAR = 3;
        case 2
            LOW = [-10 -10];
            HIGH = [10 10];
            NVAR = 2;
        case 3
            LOW = [-4.5 -4.5];
            HIGH = [4.5 4.5];
            NVAR = 2;
        case 4
            LOW = [1 1 5 0.3];
            HIGH = [100 6 40 0.5];
            NVAR = 4;
        case 5
            LOW = [1 1 5 0.3];
            HIGH = [100 6 40 0.5];
            NVAR = 4;
        otherwise
            LOW = [-10 -10 -10];
            HIGH = [10 10 10];
            NVAR = 3;
    end
end
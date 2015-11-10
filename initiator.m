function[HM]=initiator(HMS,NVAR,LOW,HIGH,INDEX)
    
    %%DOCUMENTATION
    %
    %Purpose:
    %Initiates the Harmony Memory
    %
    %Input Parameters:
    %HMS=Harmonic Memory Size
    %NVAR=Number of variables
    %LOW=Vector containing lower bounds of the variables
    %HIGH=Vector containing upper bounds of the variables
    %INDEX=Index of Function to be optimised(See 'fitness.m' for more
    %details)
    %
    %Output:
    %HM=Harmonic Memory,a HMS*(NVAR+1) matrix with elements filled randomly between the
    %values described by LOW and HIGH vectors
    
    HM = zeros(HMS,NVAR);
    NCHV = zeros(1,NVAR);
    for n = 1:HMS
        for m = 1:NVAR
            temp_low = LOW(m);
            temp_high = HIGH(m);
            HM(n,m) = temp_low + (temp_high-temp_low)*rand;
            NCHV(m) = HM(n,m);
        end
        curfit = fitness(NCHV,INDEX);
        HM(n,NVAR+1) = curfit;
    end
end
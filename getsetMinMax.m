function[lowHM,highHM]=getsetMinMax(HM,HMS,NVAR)
    tempcol = zeros(1,HMS);
    lowHM = zeros(1,NVAR);
    highHM = zeros(1,NVAR);
    for i = 1:NVAR
        for j = 1:HMS
            tempcol(j) = HM(j,i);
        end
        lowHM(i) = min(tempcol);
        highHM(i) = max(tempcol);
    end
end
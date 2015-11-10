% Improved Harmony Search Algorithm (Mahdavi et. al) %
TOTALRUNS = 20;
NVAR = 4;
bestHarmonyArray = zeros(TOTALRUNS,NVAR+1);
bestArray = zeros(TOTALRUNS,1);
[LOW,HIGH,NVAR,INDEX] = userPrompt();
for run = 1:TOTALRUNS
    
    % Reseed the Random Number Generator
    rng shuffle
    
    % Parameters begin
    % LOW=[1 1 5 0.3];
    % HIGH=[100 6 40 0.5];
    % INDEX=4;
    % NVAR=Number of Variables
    % LOW=Vector containing lower bounds of parameters
    % HIGH=Vector containing upper bounds of parameters
    HMS = 5;% Harmony Memory Size
    MAXITERS = 25000;% Maximum Iterations
    PAR_MIN = 0.35;%Min. Pitch Adjusting Rate
    PAR = 0.4;%Pitch Adjusting Rate
    PAR_MAX = 0.35;%Max. Pitch Adjusting Rate
    BW_MIN = 0.00001;%Min Bandwidth
    BW = 0.02;%BandWidth or FretWidth
    BW_MAX = 0.002;%Max Bandwidth
    generation = 1;% Iteration Number
    bestHarmony = zeros(1,NVAR);% Best harmony obtained after evaluation
    NCHV = zeros(1,NVAR);% New Candidate Harmony Vector
    bestFitHistory = zeros(MAXITERS,1);% History of best harmonies
    worstFitHistory = zeros(MAXITERS,1);% History of worst harmonies
    HMCR = 0.9;% Harmony Memory Consideration Rate
    HM = initiator(HMS,NVAR,LOW,HIGH,INDEX);% Harmony Memory
    % Parameters end
    
    
    % Algorithm starts
    while generation <= MAXITERS
        standardDeviation = calculateStandardDeviation(HM(1:HMS,NVAR+1));
        [lowHM,highHM] = getsetMinMax(HM,HMS,NVAR);
        for i = 1:NVAR
            if rand < HMCR
                
                % Memory Consideration begins here
                temp_val1 = HM(randi([1,HMS],1),i);
                NCHV(i) = temp_val1;
                % Memory Consideration ends here
                
                %Pitch Adjust starts here
                if rand < PAR
                    
                    temp_rand = rand;
                    temp = NCHV(i);
                    if temp_rand<0.5
                        temp = temp+temp_rand*BW;
                        if temp < HIGH(i)
                            NCHV(i) = temp;
                        end
                    else
                        temp = temp-temp_rand * BW;
                        if temp > LOW(i)
                            NCHV(i) = temp;
                        end
                    end
                end
                %Pitch adjust ends here
                
            else
                
                % Random Selection begins here
                if standardDeviation > 0.0001
                    temp_rand1 = rand;
                    temp_val2 = LOW(i) + temp_rand1 * (HIGH(i)-LOW(i));
                    NCHV(i) = temp_val2;
                else
                    temp_rand2 = rand;
                    temp_val3 = lowHM(i) + temp_rand2 * (highHM(i)-lowHM(i));
                    NCHV(i) = temp_val3;
                end
                % Random Selection ends here
                
            end
        end
        currentFit = fitness(NCHV,INDEX);
        
        %Dynamic adjust of BW and PAR
        PAR = PAR_MIN + (PAR_MAX - PAR_MIN)*generation/MAXITERS;
        c = log(BW_MIN/BW_MAX)/MAXITERS;
        BW = BW_MAX*exp(c*generation);
        %Process ends here
        
        worst = HM(1,NVAR+1);
        worstIndex = 1;
        
        % Search for Worst Harmony in HM starts here
        for i = 1:HMS
            if HM(i,NVAR+1) > worst
                worst = HM(i,NVAR+1);
                worstIndex = i;
            end
        end
        % Search ends here
        
        worstFitHistory(generation) = worst;% History of worst harmonies
        
        % Update of HM starts here
        if(currentFit < worst)
            for k = 1:NVAR
                HM(worstIndex,k) = NCHV(k);
            end
            HM(worstIndex,NVAR+1) = currentFit;
        end
        % Update ends here
        
        % Search for best harmony in HM starts here
        best = HM(1,NVAR+1);
        bestIndex = 1;
        for i = 1:HMS
            if HM(i,NVAR+1) < best
                best = HM(i,NVAR+1);
                bestIndex = i;
            end
        end
        % Search for best ends here
        
        bestFitHistory(generation) = best;%History of best harmonies
        
        % Searching the best Harmony in besthistory starts here
        if (generation > 1) && (best ~= bestFitHistory(generation-1))
            for k = 1:NVAR
                bestHarmony(k) = HM(bestIndex,k);
            end
        end
        % Search ends here
        
        generation = generation + 1;
    end
    % Algorithm ends
    
    
    
    % Display Results
    disp('Optimized parameter values = ')
    disp(bestHarmony)
    for indx = 1:NVAR
        bestHarmonyArray(run,indx) = bestHarmony(indx);
    end
    bestHarmonyArray(run,NVAR+1) = best;
    disp('Optimized Function Value = ')
    disp(best)
    bestArray(run,1) = best;
end

% Buffering in a excel file
if INDEX == 1
    filename = 'Spherical.xlsx';
elseif INDEX == 2
    filename = 'Rosenbrock.xlsx';
elseif INDEX == 3
    filename = 'Beale.xlsx';
elseif INDEX == 4
    filename = 'newHS_Values_Negative.xlsx';
elseif INDEX == 5
    filename = 'newHS_Values_Positive.xlsx';
else
    filename = 'Spherical.xlsx';
end
xlswrite(filename,bestHarmonyArray);
% end
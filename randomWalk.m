% Generate an n x m matrix for an A&S student's chance of
% escaping from the e-center staring at any given node.

% The engineering center is a grid with user-entered dimensions
% the 'student' makes a random decision at each intersection
% The student 'escapes' if they come to the west side of the building
% The student fails to esacpe if they end at the N,E,or S sides of 
% the building.

% Set-up ----------------------------------------------
% The dimensions of the ecenter
NSdim = input('Type a N-S dimension for the e-center: ');
EWdim = input('Type a E-W dimension for the e-center: ');

% intialize avgProb
avgProb= zeros(NSdim,EWdim);

for NSstu = 1:NSdim
    for EWstu = 1:EWdim
        
    stu = [NSstu,EWstu];

    % Begin---------------------------------------------------------
    % Check to make sure he isn't out already:
    if stu(2) == 1
        % The student exited on the W side
        prob = 1;
        exit = 1;
        avgProb(NSstu,EWstu) = prob;
    elseif stu(1) == 1 || stu(1) ==NSdim || stu(2) == EWdim
        % Exited on the N,S,E side
        prob = 0;
        exit = 1;
        avgProb(NSstu,EWstu) = prob;
    else
        exit = 0; % hasn't gotten out yet!
    end

    if exit ==0
    % 10,000 trials
    for trial = 1:10000

        stu = [NSstu,EWstu];

        % these boots are made for walkin'...
        while exit == 0

            % Generate a random step --------------------------------
            % The randStep(1) position indicates a N-S(1) or E-W(2) step
            % the randStep(2) position indicates a N,E(1) or S,W(-1) step
            randStep = randi([1,2],1,2);
            if randStep(2) == 2
                randStep(2) = -1;
            end

            % Make the student take one step 
            % stu is a vector [NSposition,EWposition]
            % stu(of either 1 or 2, so either NS or EW) moves  1 or -1
            stu(randStep(1)) = stu(randStep(1)) + randStep(2);

            % Keep moving the student
            % If the student comes to the wall of the e-center;
            % that is, if stu(1) (in NS dir) ever equals or exceeds NSdim
            % or if stu(2) (EW) ever equals or exceeds EWdim, game over

                if stu(2) <= 1
                    % The student exited on the N,S,E side--failure
                    prob(trial) = 1;
                    break
                elseif stu(1) <= 1 || stu(1) >=NSdim || stu(2) >= EWdim
                    % Exited on the W side
                    prob(trial) = 0;
                    break
                end
        end

    end

    % Generate a matrix of all probabilites for all nodes
    avgProb(NSstu,EWstu) = mean(prob);

    end

    end
end

clearvars -except avgProb






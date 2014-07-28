% Ant Colony Opimization - Ant Colony System for Hybird Job Shop Sceduling
% Problem.

function [costs, bestSol] = ACO(jobs, m, n, ants, iterations, ...
                                rzero, costFunc)

  costEnd = 0;
  costs = [];
  bestSol = ones(1, n);
  bestSolCost = costFunc(bestSol, jobs, m, n);

  phermone = ones(n, m*m); % track phermone value on each path.

  for i = 1:iterations

    antPaths = []; % stores all antPaths
    for a = 1:ants;

      antPath = []; % current ants path

      for l = 1:n % going down n layers in total

        phermoneToNextLevel = [];

        if l == 1 % layer 1 to n mapping
          for j = 1:m
            phermoneToNextLevel(j) = phermone(1, j);
          end

        else % rest layers are n to n mapping
          lastNode = antPath(l-1);

          phermoneRow = l;
          phermoneColS = (lastNode - 1) * m + 1;
          phermoneColF = lastNode * m;
          phermoneToNextLevel = phermone(phermoneRow, ...
                                         phermoneColS:phermoneColF);
        end

        randVal = rand(1);
        weights = phermoneToNextLevel;
        testPath = antPath; % copy current ant path to calculate distance
        for mi = 1:m
          testPath(l) = mi;
          % Construct a matrix to memorize this for better performance
          distance =  costFunc(testPath, jobs, m, l) - costFunc(antPath, ...
                                                                jobs, m, l-1);
          weights(mi) = weights(mi) / (distance+1);
        end
        totalWeight = sum(weights);
        weightAcc = 0;
        nextIndex = 0;

        if rand(1) < rzero % experience vs exploration
          nextIndexs = find(weights == max(weights));
          nextIndex = nextIndexs(randi(numel(nextIndexs)));
        else
          while randVal > (weightAcc / totalWeight)
            nextIndex = nextIndex + 1;
            weightAcc = weightAcc + weights(nextIndex);
          end
        end
        antPath(l) = nextIndex;
      end

      antPaths(a, :) = antPath;

    end

    antCosts = [];

    % Find costs for all ant paths. Consider to use a vectoralization
    % version of cost function for this process in matlab.
    for a = 1:ants
      antCosts(a) = costFunc(antPaths(a,:), jobs, m, n);
    end

    bestAntCost = min(antCosts);
    worstAntCost = max(antCosts);
    bestAntPaths = antPaths(find(antCosts==bestAntCost), :);

    % Update phermone
    phermone = phermone .* 0.4;

    if bestAntCost <= bestSolCost
       % ONLY THE GLOBAL BEST ALLOW TO UPDATE
      deltaPhermone = 1 / bestAntCost;

      for s = 1:size(bestAntPaths, 1)
        bestAntPath = bestAntPaths(s,:);
        for ji = 1:n
          pcol = 0;
          if ji == 1 % first job
            pcol = bestAntPath(ji);
          else
            lastNode = bestAntPath(ji - 1);
            pcol = (lastNode - 1) * m + bestAntPath(ji);
          end
          phermone(ji, pcol) = phermone(ji, pcol) + deltaPhermone;
        end
      end
    end

    costEnd = costEnd + 1;
    costs(costEnd) = bestAntCost;

    if bestAntCost < bestSolCost
       bestSol = bestAntPaths(1,:);
       bestSolCost = bestAntCost;
    end
  end
end

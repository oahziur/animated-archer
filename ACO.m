% Ant Colony Opimization - Ant Colony System for Hybird Job Shop Sceduling
% Problem.

function [costs, bestSol] = ACO(jobs, m, n, ants, iterations, costFunc)

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
          tempIndex = 1;

          for j = phermoneColS:phermoneColF
            phermoneToNextLevel(tempIndex) = phermone(phermoneRow, j);
            tempIndex = tempIndex + 1;
          end
        end

        randVal = rand(1);
        totalPhermone = sum(phermoneToNextLevel);
        phermoneAcc = 0;
        nextIndex = 0;

        while randVal > (phermoneAcc / totalPhermone)
          nextIndex = nextIndex + 1;
          phermoneAcc = phermoneAcc + phermoneToNextLevel(nextIndex);
        end

        antPath(l) = nextIndex;

      end

      antPaths(a, :) = antPath;

    end

    antPaths
    pause;

    % Update phermone
    phermone = phermone .* 0.5;

    % Update the best path of current iterations
  end
end

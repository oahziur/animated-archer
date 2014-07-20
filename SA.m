% Simulated Annealing Algorithm for Hybrid Job Shop Scheduling
% Problem.
%
% costs: history of cost for each iteration's schedule.
% bestSol: best solution for the given sT and fT.
%
% iterations: number of iteration for each T.
% sT: start T.
% fT: final T.
% alpha: alpha in geometric cooling schedule.

function [costs, bestSol] = SA(schedule, jobs, m, n, iterations, sT, ...
                               fT, alpha, costFunc, genNeighborFunc)
  costsEnd = 0;
  costs = [];
  bestSol = schedule;
  bestSolCost = costFunc(schedule, jobs, m, n);
  acceptedSol = schedule;
  acceptedSolCost = costFunc(schedule, jobs, m, n);
  T = sT;
  while T > fT
    for i=1:iterations
      newSol = genNeighborFunc(acceptedSol, m, n);
      newSolCost = costFunc(newSol, jobs, m, n);
      deltaCost = newSolCost - acceptedSolCost;
      if deltaCost < 0
        acceptedSol = newSol;
        acceptedSolCost = newSolCost;
      else
        randVal = rand(1);
        p = exp(-1*deltaCost / T);
        if p > randVal
          acceptedSol = newSol;
          acceptedSolCost = newSolCost;
        end
      end

      % record the cost value in to history
      costsEnd = costsEnd + 1;
      costs(costsEnd) = acceptedSolCost;

      % Update current best value
      if acceptedSolCost < bestSolCost
         bestSol = acceptedSol;
         bestSolCost = acceptedSolCost;
      end
    end
    T = T * alpha; % cooling
  end
end

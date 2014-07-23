% Ant Colony Opimization - Ant Colony System for Hybird Job Shop Sceduling
% Problem.

function [costs, bestSol] = ACO(jobs, m, n, ants, iterations, costFunc)
  costs = [];
  bestSol = ones(1, n);
  bestSolCost = costFunc(bestSol, jobs, m, n);
  phermone = ones(n, n*n); % track phermone value on each path.
  for i = 1:iterations
    for a = 1:ants;

      ant_path = [];

      for l = 1:n % going down n layers in total

        if l == 1 % layer 1 to n mapping

        else % rest layers are n to n mapping

        end

      end
      % Update the current best ants

    end

    % Update the current best solution

    % Update phermone
    phermone = phermone .* 0.5;

  end
end

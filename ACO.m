% Ant Colony Opimization - Ant Colony System for Hybird Job Shop Sceduling
% Problem.

function [costs, bestSol] = ACO(jobs, m, n, ants, iterations, costFunc)
  costs = [];
  bestSol = ones(1, n);
  bestSolCost = costFunc(bestSol, jobs, m, n);

  phermone = ones(n, m*m); % track phermone value on each path.

  for i = 1:iterations
    for a = 1:ants;

      ant_path = [];

      for l = 1:n % going down n layers in total

        if l == 1 % layer 1 to n mapping
          phermone_to_next_level = [];
          for j = 1:m
            phermone_to_next_level(j) = phermone(1, j);
          end

        else % rest layers are n to n mapping
          last_node = ant_path(l-1);

          phermone_row = l;
          phermone_col_s = (last_node-1) * m + 1;
          phermone_col_f = last_node * m;
          phermone_to_next_level = [];
          temp_index = 1;

          for j = phermone_col_s:phermone_col_f
            phermone_to_next_level(temp_index) = phermone(phermone_row, j);
          end

        end

      end
      % Update the current best ants

    end

    % Update the current best solution

    % Update phermone
    phermone = phermone .* 0.5;

  end
end

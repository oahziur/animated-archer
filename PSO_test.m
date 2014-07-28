function [] = PSO_test()
  PSO_samll_test(150);
  PSO_16t6m_test(500);
  PSO_17t5m_test(500);
end

function [costs] = PSO_samll_test(iterations)
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = PSO_lbest(J, m, n, 1500, iterations, @cost);
  if cost(bestSol, J, 3, 6) == 7
    disp('small global best found!');
  else
    disp('small local best found!');
  end
end

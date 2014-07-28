function [] = GA_test()
  GA_small_test(150);
  GA_16t6m_test(500);
  GA_17t5m_test(500);
end

function [costs] = GA_small_test(iterations)
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = GA(J, m, iterations);
  if cost(bestSol, J, 3, 6) == 7
    disp('small global best found!');
  else
    disp('small local best found!');
  end
end

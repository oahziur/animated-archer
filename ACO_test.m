function [] = ACO_test()
  ACO_small_test(100);
  ACO_16t6m_test(100);
  ACO_17t5m_test(100);
end

function [costs] = ACO_small_test(iterations)
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  ants = 5;
  [costs, bestSol] = ACO(J, m, n, ants, iterations, 0.2, @cost);
  if cost(bestSol, J, 3, 6) == 7
    disp('small test PASSED!');
  else
    disp('small test FAILED!');
  end
end

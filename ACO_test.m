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

function [costs] = ACO_16t6m_test(iterations)
  m = 6;
  n = 16;
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  ants = 5;
  [costs, bestSol] = ACO(J, m, n, ants, iterations, 0.2, @cost);
  bestSolCost = cost(bestSol, J, m, n);
  if bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    disp(bestSolCost);
  end
end

function [costs] = ACO_17t5m_test(iterations)
  m = 5;
  n = 17;
  J = [50,22,13,64,43,70,53,55,95,83,54,56,60,77,28,24,25];
  ants = 5;
  [costs, bestSol] = ACO(J, m, n, ants, iterations, 0.2, @cost);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 176
    disp('17t5m test PASSED!');
  else
    disp('17t5m test FAILED!');
    disp(bestSolCost);
  end
end

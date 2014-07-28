function [costs] = PSO_17t5m_test(iterations)
  m = 5;
  n = 17;
  J = [50,22,13,64,43,70,53,55,95,83,54,56,60,77,28,24,25];
  [costs, bestSol] = PSO_lbest(J, m, n, 500, iterations, @cost);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 175
    disp('17t5m global best found!');
  else
    disp('17t5m local best found!');
    disp(bestSolCost);
  end
end

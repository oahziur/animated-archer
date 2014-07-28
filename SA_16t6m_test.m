function [costs] = SA_16t6m_test(iterations)
  m = 6;
  n = 16;
  S = initSolution(m,n);
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  sT = findStartTemp(J, m);
  alpha = 0.85;
  iterationsAtTemp = 55;
  [costs, bestSol] = SA(S, J, m, n, iterationsAtTemp, sT, iterations, ...
                        alpha, @cost, @gen_neighbor);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    disp(bestSolCost);
  end
end

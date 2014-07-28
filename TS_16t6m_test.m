function [costs] = TS_16t6m_test(iterations)
  m = 6;
  n = 16;
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  [costs, bestSol] = TS(J, m, n, 15, iterations, @cost, @getBestNeighbor);
  bestSolCost = cost(bestSol, J, m, n);
  if bestSolCost == 154
    disp('16t6m global best found!');
  else
    disp('16t6m local best found!');
    disp(bestSolCost);
  end
end

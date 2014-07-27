function [] = TS_test()
  TS_small_test();
  TS_16t6m_test();
end

function [] = TS_small_test()
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = TS(J, m, n, 5, 50, @cost, @getBestNeighbor);
  if cost(bestSol, J, 3, 6) == 7
    disp('small test PASSED!');
  else
    disp('small test FAILED!');
  end
  plot(costs);
end

function [] = TS_16t6m_test()
  m = 6;
  n = 16;
  S = ones(1, n);
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  [costs, bestSol] = TS(J, m, n, 15, 1600, @cost, @getBestNeighbor);
  bestSolCost = cost(bestSol, J, m, n);
  if bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    bestSolCost
  end
end

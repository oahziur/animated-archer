function [] = SA_test()
  m = 3;
  n = 6;
  S = ones(1, n);
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = SA(S, J, m, n, 2, 30, 0.01, 0.85, @cost, @gen_neighbor);
  if cost(bestSol, J, 3, 6) == 7
    disp("small test PASSED!");
  else
    disp("small test FAILED!");
  end
  plot(costs);
end

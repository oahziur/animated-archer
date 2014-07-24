function [] = ACO_test()
  ACO_small_test();
end

function [] = ACO_small_test()
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = ACO(J, m, n, n, 20, 0.2, @cost);
  if cost(bestSol, J, 3, 6) == 7
    disp("small test PASSED!");
  else
    disp("small test FAILED!");
  end
  plot(costs);
end

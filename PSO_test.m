function [] = PSO_test()
  SA_samll_test();
  SA_16t6m_test();
end

function [] = SA_samll_test()
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = PSO_lbest(J, m, n, 1000, 100, @cost);
  if cost(bestSol, J, 3, 6) == 7
    disp('small test PASSED!');
  else
    disp('small test FAILED!');
  end
  plot(costs);
end

function [] = SA_16t6m_test()
  m = 6;
  n = 16;
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  [costs, bestSol] = PSO_lbest(J, m, n, 1000, 100, @cost);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    disp(bestSolCost);
  end
  plot(costs);
end

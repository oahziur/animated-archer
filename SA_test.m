function [] = SA_test()
  SA_samll_test();
  SA_16t6m_test();
end

function [] = SA_samll_test()
  m = 3;
  n = 6;
  S = initSolution(m,n);
  J = [2, 3, 4, 6, 2, 2];
  sT = findStartTemp(J, m);
  [costs, bestSol] = SA(S, J, m, n, 2, sT, 0.01, 0.85, @cost, @gen_neighbor);
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
  S = initSolution(m,n);
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  sT = findStartTemp(J, m);
  [costs, bestSol] = SA(S, J, m, n, 55, sT, 0.000001, 0.85, @cost, @gen_neighbor);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    disp(bestSolCost);
  end
  plot(costs);
end

function [sT] = findStartTemp(jobs, m)
  sT = 0;
  maxChange = max(jobs);
  avgExeTime = sum(jobs) / m;
  if (avgExeTime > maxChange)
    maxChange = avgExeTime;
  end
  sT = -1* maxChange / log(0.85);
end

function [S] = initSolution(m, n)
  S = [];
  for i = 1:n
      S(i) = mod(i, m) + 1;
  end
end

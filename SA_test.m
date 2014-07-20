function [] = SA_test()
  SA_samll_test();
end

function [] = SA_samll_test()
  m = 3;
  n = 6;
  S = ones(1, n);
  J = [2, 3, 4, 6, 2, 2];
  sT = findStartTemp(J, m);
  [costs, bestSol] = SA(S, J, m, n, 2, sT, 0.01, 0.85, @cost, @gen_neighbor);
  if cost(bestSol, J, 3, 6) == 7
    disp("small test PASSED!");
  else
    disp("small test FAILED!");
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

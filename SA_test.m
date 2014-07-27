function [] = SA_test()
  SA_samll_test(100);
  SA_16t6m_test(10000);
  SA_17t5m_test(10000);
end

function [costs] = SA_samll_test(iterations)
  m = 3;
  n = 6;
  S = initSolution(m,n);
  J = [2, 3, 4, 6, 2, 2];
  sT = findStartTemp(J, m);
  alpha = 0.85;
  iterationsAtTemp = 2;
  fT = sT*(alpha^(iterations/iterationsAtTemp));
  [costs, bestSol] = SA(S, J, m, n, iterationsAtTemp, sT, fT, alpha, @cost, @gen_neighbor);
  if cost(bestSol, J, 3, 6) == 7
    disp('small test PASSED!');
  else
    disp('small test FAILED!');
  end
end

function [costs] = SA_16t6m_test(iterations)
  m = 6;
  n = 16;
  S = initSolution(m,n);
  J = [58,72,79,43,16,37,7,74,97,44,39,80,65,65,39,96];
  sT = findStartTemp(J, m);
  alpha = 0.85;
  iterationsAtTemp = 55;
  fT = sT*(alpha^(iterations/iterationsAtTemp));
  [costs, bestSol] = SA(S, J, m, n, iterationsAtTemp, sT, fT, alpha, @cost, @gen_neighbor);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 154
    disp('16t6m test PASSED!');
  else
    disp('16t6m test FAILED!');
    disp(bestSolCost);
  end
end

function [costs] =  SA_17t5m_test(iterations)
  m = 5;
  n = 17;
  S = initSolution(m,n);
  J = [50,22,13,64,43,70,53,55,95,83,54,56,60,77,28,24,25];
  sT = findStartTemp(J, m);
  alpha = 0.85;
  iterationsAtTemp = 55;
  fT = sT*(alpha^(iterations/iterationsAtTemp));
  [costs, bestSol] = SA(S, J, m, n, iterationsAtTemp, sT, fT, alpha, @cost, @gen_neighbor);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 176
    disp('17t6m test PASSED!');
  else
    disp('17t6m test FAILED!');
    disp(bestSolCost);
  end
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

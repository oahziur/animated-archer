function [costs] =  SA_17t5m_test(iterations)
  m = 5;
  n = 17;
  S = initSolution(m,n);
  J = [50,22,13,64,43,70,53,55,95,83,54,56,60,77,28,24,25];
  sT = findStartTemp(J, m);
  alpha = 0.85;
  iterationsAtTemp = 5;
  [costs, bestSol] = SA(S, J, m, n, iterationsAtTemp, sT, iterations, ...
                        alpha, @cost, @gen_neighbor);
  bestSolCost = cost(bestSol, J, 6, 16);
  if  bestSolCost == 175
    disp('17t6m test PASSED!');
  else
    disp('17t6m test FAILED!');
    disp(bestSolCost);
  end
end

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
    disp('small global best found!');
  else
    disp('small local best found!');
  end
end

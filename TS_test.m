function [] = TS_test()
  TS_small_test(100);
  TS_16t6m_test(100);
  TS_17t5m_test(100);
end

function [costs] = TS_small_test(iterations)
  m = 3;
  n = 6;
  J = [2, 3, 4, 6, 2, 2];
  [costs, bestSol] = TS(J, m, n, 10, iterations, @cost, @getBestNeighbor);
  if cost(bestSol, J, 3, 6) == 7
    disp('small global best found!');
  else
    disp('small local best found!');
  end
end

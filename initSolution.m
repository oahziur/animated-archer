function [S] = initSolution(m, n)
  S = [];
  for i = 1:n
      S(i) = mod(i, m) + 1;
  end
end

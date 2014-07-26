function [costs, bestSol] = PSO(jobs, m, n, particals, iterations, costFunc)
  c1 = 1.4944;
  c2 = 1.4944;
  w = 0.792;
  gbests = ones(1, n);
  gbest = costFunc(gbests, jobs, m, n);
  lbests = randi(m, particals, n);
  lbest = ones(1, particals);
  for i = 1:particals
      lbest(i) = costFunc(lbests(i, :), jobs, m, n);
      if lbest(i) < gbest
          gbest = lbest(i);
          gbests = lbests(i, :);
      end
  end
  x = lbests;
  v = zeros(particals, n);
  
  for i = 1:iterations
      ibests = ones(particals, n);
      ibest = ones(1, particals);
      r = rand(particals, 1);
      v = w*v + c1 * bsxfun(@times, r, lbests - x) + ...
        c2 * bsxfun(@times, r, (bsxfun(@minus, gbests, x)));
      x = round(x + v);
      x(x < 1) = 1;
      x(x > m) = m;
      for j = 1:particals
          c = costFunc(x(j, :), jobs, m, n);
          if c < lbest(j)
              lbest(j) = c;
              lbests(j, :) = x(j, :);
          end
      end
      [ibest, idx] = min(lbest);
      ibests = lbests(idx, :);
      if ibest < gbest
          gbest = ibest;
          gbests = ibests;
      end
  end
  
  costs = gbest;
  bestSol = gbests;
end